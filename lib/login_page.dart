import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_up.dart';
import 'appointment_booking.dart';
import 'cubits/login_cubit.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final bool redirectToAppointment;

  const LoginPage({Key? key, required this.onLoginSuccess, this.redirectToAppointment = false}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider(
        create: (_) => LoginCubit(),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
              );
            }
            if (!state.isLoading && state.errorMessage.isEmpty) {
              widget.onLoginSuccess();
              if (widget.redirectToAppointment) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentBookingPage()),
                );
              } else {
                Navigator.pop(context);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      child: state.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Login'),
                    );
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    'No account? Sign up',
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
