import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_auth/src/authentication/authentication_repository.dart';
import 'package:formz/formz.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthenticationRepository authenticationRepository;

  LoginFormBloc({required this.authenticationRepository})
      : super(LoginFormState()) {
    on<SubmitLoginForm>(_onSubmitLoginForm);
  }

  void _onSubmitLoginForm(
    SubmitLoginForm event,
    Emitter<LoginFormState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await authenticationRepository.logIn(
      username: 'username',
      password: 'password',
    );
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
