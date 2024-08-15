part of 'login_form_bloc.dart';

final class LoginFormState extends Equatable {
  const LoginFormState({
    this.status = FormzSubmissionStatus.initial,
  });

  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [status];

  LoginFormState copyWith({
    FormzSubmissionStatus? status,
  }) {
    return LoginFormState(
      status: status ?? this.status,
    );
  }
}
