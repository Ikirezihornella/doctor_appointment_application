import 'package:flutter/material.dart';

class AppointmentBookingPage extends StatefulWidget {
  @override
  _AppointmentBookingPageState createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _sicknessTimeController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Booking'),
        content: Text('Pay fees of \$2 for booking.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Appointment Booked!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Appointment')),
      body: SingleChildScrollView(
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showPaymentDialog,
              child: Text('Book an Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
