import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_up_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  // signUp function to handle user registration
  Future<void> signUp(String email, String password, String confirmPassword) async {
    // Validate input fields
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      emit(SignUpState(errorMessage: 'Please fill in all fields'));
      return;
    }

    // Password and confirm password mismatch validation
    if (password != confirmPassword) {
      emit(SignUpState(errorMessage: 'Passwords don’t match'));
      return;
    }

    // Emit loading state while processing the signup
    emit(SignUpState(isLoading: true));

    try {
      // Send HTTP POST request to the backend signup endpoint
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/signup'), // Replace with actual IP for real devices
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': email.split('@')[0], // Use the first part of the email as the name
          'email': email,
          'password': password,
        }),
      );

      // Decode response from the server
      final data = jsonDecode(response.body);

      // Check for success (status code 201 is success for creation)
      if (response.statusCode == 201) {
        // Emit state with no loading and clear any error message
        emit(SignUpState(isLoading: false, errorMessage: ''));
      } else {
        // Emit state with error message if signup fails
        emit(SignUpState(isLoading: false, errorMessage: data['error'] ?? 'Signup failed'));
      }
    } catch (e) {
      // Emit state with error message in case of network or other errors
      emit(SignUpState(isLoading: false, errorMessage: 'Network error: Please try again later'));
    }
  }
}
