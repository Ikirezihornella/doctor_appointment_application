import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/appointment_repository.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepository _repository;

  AppointmentCubit(this._repository) : super(AppointmentState());

  Future<void> bookAppointment(Map<String, String> details) async {
    emit(state.copyWith(isBooking: true, errorMessage: ''));
    try {
      await _repository.bookAppointment(details);
      emit(state.copyWith(isBooking: false));
    } catch (e) {
      emit(state.copyWith(isBooking: false, errorMessage: e.toString()));
    }
  }
}
