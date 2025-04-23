part of 'appointment_cubit.dart';

class AppointmentState {
  final bool isBooking;
  final String errorMessage;

  AppointmentState({this.isBooking = false, this.errorMessage = ''});

  AppointmentState copyWith({bool? isBooking, String? errorMessage}) {
    return AppointmentState(
      isBooking: isBooking ?? this.isBooking,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
