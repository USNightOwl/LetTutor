import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_event.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<EmailChanged>(_onEmailChanged);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignInState> emit) {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
    } else if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
    } else {
      emit(EmailValid());
    }
  }
}

bool isValidEmail(String email) {
  return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
      .hasMatch(email);
}
