import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_page.dart';

class SymptomsDescriptionPage extends StatefulWidget {
  final List<String> selectedSymptoms;

  SymptomsDescriptionPage({required this.selectedSymptoms});

  @override
  _SymptomsDescriptionPageState createState() => _SymptomsDescriptionPageState();
}

class _SymptomsDescriptionPageState extends State<SymptomsDescriptionPage> {
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedSeverity;

  void submitAssessment() {
    if (_selectedSeverity == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Provide a detailed description of your symptoms'),
          backgroundColor: Colors.grey[200], 
        ),
      );
      return;
    }

    String recommendation;

    if (_selectedSeverity == "Mild") {
      recommendation = "You can take over-the-counter medicine. Rest and stay hydrated.";
    } else if (_selectedSeverity == "Moderate") {
      recommendation = "You should visit a doctor for further evaluation.";
    } else {
      recommendation = "Your symptoms are severe! Book an appointment with the doctor.";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Recommendation'),
        content: Text(recommendation),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () { 
              Navigator.of(context).pop();
              },
          ),
          if(_selectedSeverity == "Severe")
          TextButton(
            child: Text("Book an appointment"),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage(
                  onLoginSuccess: () {
                    print("Login successful");
                  },
                ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(title: Text('Assess your symptoms')),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selected Symptoms:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Wrap(
              spacing: 8.0,
              children: widget.selectedSymptoms
                  .map((symptom) => Chip(label: Text(symptom))) 
                  .toList(),
            ),

            SizedBox(height: 10),

            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(labelText: "Describe your symptoms in detail"),
            ),

            SizedBox(height: 10),

            Text(
              "Select Severity",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            DropdownButton<String> (
              value: _selectedSeverity,
              isExpanded: true,
              hint: Text("Select Severity Level"),
              items: ["Mild", "Moderate", "Severe"]
                  .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      )) 
                  .toList(),
              onChanged: (value) => setState(() => _selectedSeverity = value),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: submitAssessment,
              child: Text("Submit & Get Recommendation"),
            ),
          ],
        ),
      ),
    );
  }
}
