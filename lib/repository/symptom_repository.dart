import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dbmodels/symptom_assess_model.dart';

class SymptomsRepository {
  final String baseUrl = "http://192.168.1.5:5000"; 

  Future<void> submitSymptoms(SymptomAssessment assessment) async {
    final url = Uri.parse('$baseUrl/api/symptoms');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(assessment.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to submit symptoms: ${response.body}");
    }
  }
}
