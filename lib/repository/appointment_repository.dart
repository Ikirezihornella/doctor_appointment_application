import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentRepository {
  final String baseUrl = 'http://your-api-url.com/api'; // Update this to your real API endpoint

  Future<void> bookAppointment(Map<String, String> details) async {
    final response = await http.post(
      Uri.parse('$baseUrl/appointments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(details),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to book appointment: ${response.body}');
    }
  }
}
