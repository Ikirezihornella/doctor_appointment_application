import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _signUp() {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        print("Signing Up with email: $email and password: $password");
      } else {
        print("Passwords don't match");
      }
    } else {
      print("Please fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            TextField(controller: _confirmPasswordController, decoration: InputDecoration(labelText: 'Confirm Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _signUp, child: Text('Sign Up')),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () { Navigator.pop(context); },
              child: Text('Signed up already? Login here', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Appointments')),
      body: Center(child: Text('No appointments yet!')),
    );
  }
}
