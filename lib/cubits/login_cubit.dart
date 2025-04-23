import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginState {
  final bool isLoading;
  final String errorMessage;
  final bool isSuccess;

  LoginState({this.isLoading = false, this.errorMessage = '', this.isSuccess = false});
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(LoginState(errorMessage: 'Please fill in both email and password.'));
      return;
    }

    emit(LoginState(isLoading: true));

    // Call the backend API for login
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/login'), // Replace with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        emit(LoginState(isLoading: false, isSuccess: true));
      } else {
        final errorData = jsonDecode(response.body);
        emit(LoginState(isLoading: false, errorMessage: errorData['error']));
      }
    } catch (error) {
      emit(LoginState(isLoading: false, errorMessage: 'An error occurred. Please try again.'));
    }
  }
}
