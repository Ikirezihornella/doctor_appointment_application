import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dbmodels/symptom_assess_model.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.5:5000'; 

  static Future<bool> submitSymptoms(SymptomAssessment assessment) async {
    final url = Uri.parse('$baseUrl/api/symptoms');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'selectedSymptoms': assessment.selectedSymptoms,
        'description': assessment.description,
        'severity': assessment.severity,
      }),
    );

    return response.statusCode == 200;
  }
}
