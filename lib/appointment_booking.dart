import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/appointment_repository.dart';
import 'cubits/appointment_cubit.dart';

class AppointmentBookingPage extends StatelessWidget {
  
  AppointmentBookingPage({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _sicknessTimeController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),

      body: BlocProvider(
        create: (_) => AppointmentCubit(AppointmentRepository()),

        child: BlocListener<AppointmentCubit, AppointmentState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
              );
            } else if (!state.isBooking && state.errorMessage.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Appointment Booked!'), backgroundColor: Colors.green),
              );
            }
          },

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTextField('First Name', _firstNameController),
                _buildTextField('Last Name', _lastNameController),
                _buildTextField('Age', _ageController, keyboardType: TextInputType.number),
                _buildTextField('Address', _addressController),
                _buildTextField('Time of Sickness Recognition', _sicknessTimeController),
                _buildTextField('Mobile Number', _mobileController, keyboardType: TextInputType.phone),
                _buildTextField('Email', _emailController, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 20),

                BlocBuilder<AppointmentCubit, AppointmentState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.isBooking
                          ? null
                          : () {
                              final appointmentDetails = {
                                'firstName': _firstNameController.text,
                                'lastName': _lastNameController.text,
                                'age': _ageController.text,
                                'address': _addressController.text,
                                'sicknessTime': _sicknessTimeController.text,
                                'mobile': _mobileController.text,
                                'email': _emailController.text,
                              };

                              context.read<AppointmentCubit>().bookAppointment(appointmentDetails);
                            },

                      child: state.isBooking
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Book Appointment'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
