import 'package:flutter/material.dart';
import 'symptom_description.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomsPage extends StatefulWidget {
  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  Map<String, bool> symptomsCheckboxes = {
    'Headache': false,
    'Back Pain': false,
    'Muscle Pain': false,
    'Abdominal Pain': false,
    'Chest Pain': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Symptom Selection')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...symptomsCheckboxes.keys.map((key) {
              return CheckboxListTile(
                title: Text(key),
                value: symptomsCheckboxes[key],
                onChanged: (bool? value) {
                  setState(() {
                    symptomsCheckboxes[key] = value ?? false;
                  });
                },
              );
            }).toList(),
            SizedBox(height: 14),
            
            ElevatedButton(
              onPressed: () {
                List<String> selectedSymptoms = symptomsCheckboxes.entries
                    .where((e) => e.value)
                    .map((e) => e.key)
                    .toList();

                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SymptomsDescriptionPage(selectedSymptoms: selectedSymptoms),
                  ),
                );
              },
              child: Text('Advance'),
            ),
          ],
        ),
      ),
    );
  }
}
