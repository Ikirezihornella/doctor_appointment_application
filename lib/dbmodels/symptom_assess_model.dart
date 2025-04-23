class SymptomAssessment {
  final List<String> selectedSymptoms;
  final String description;
  final String severity;

  SymptomAssessment({
    required this.selectedSymptoms,
    required this.description,
    required this.severity,
  });

  Map<String, dynamic> toJson() {
    return {
      'selectedSymptoms': selectedSymptoms,
      'description': description,
      'severity': severity,
    };
  }
}
