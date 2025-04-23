import 'package:flutter_bloc/flutter_bloc.dart';
import '../dbmodels/symptom_assess_model.dart';
import '../repository/symptom_repository.dart';


abstract class SymptomsEvent {}

class SubmitSymptoms extends SymptomsEvent {
  final SymptomAssessment assessment;

  SubmitSymptoms(this.assessment);
}

abstract class SymptomsState {}

class SymptomsInitial extends SymptomsState {}

class SymptomsSubmitting extends SymptomsState {}

class SymptomsSubmitted extends SymptomsState {}

class SymptomsError extends SymptomsState {
  final String message;
  SymptomsError(this.message);
}

class SymptomsBloc extends Bloc<SymptomsEvent, SymptomsState> {
  final SymptomsRepository repository = SymptomsRepository();

  SymptomsBloc() : super(SymptomsInitial()) {
    on<SubmitSymptoms>((event, emit) async {
      emit(SymptomsSubmitting());
      try {
        await repository.submitSymptoms(event.assessment);
        emit(SymptomsSubmitted());
      } catch (e) {
        emit(SymptomsError(e.toString()));
      }
    });
  }
}
