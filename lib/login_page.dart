import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_booking.'

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final bool redirectToAppointment;

  LoginPage({
    required this.onLoginSuccess,
    this.redirectToAppointment= false,
    });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      widget.onLoginSuccess();

      if(widget.redirectToAppointment) {
        Navigator.pushReplacementNamed(context,'/appointmentBooking');
      } else {
      Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Here')),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10), 
            ElevatedButton(onPressed: _login, child: Text('Login')),
            SizedBox(height: 10), 
            
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text(
                "No account? Sign up",
                style: TextStyle(
                  color: Colors.blue, 
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
