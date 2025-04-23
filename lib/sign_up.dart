import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dbmodels/user_model.dart';
import 'cubits/sign_up_cubit.dart';
import 'cubits/sign_up_state.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: BlocProvider(
        create: (_) => SignUpCubit(),
        child: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
              );
            }
            if (!state.isLoading && state.errorMessage.isEmpty) {
              Navigator.pop(context); 
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
                TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
                TextField(controller: _confirmPasswordController, decoration: InputDecoration(labelText: 'Confirm Password'), obscureText: true),
                SizedBox(height: 20),
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<SignUpCubit>().signUp(
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                        );
                      },
                      child: state.isLoading ? CircularProgressIndicator() : Text('Sign Up'),
                    );
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Already have an account? Log in', style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
