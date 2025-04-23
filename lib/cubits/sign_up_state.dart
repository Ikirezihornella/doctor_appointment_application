
class SignUpState {
  final bool isLoading;
  final String errorMessage;

  SignUpState({
    this.isLoading = false,
    this.errorMessage = '',
  });

  SignUpState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
