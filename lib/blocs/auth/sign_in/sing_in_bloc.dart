import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_event.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  void _onSignInSubmitted(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
      return;
    }

    if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
      return;
    }

    if (event.password.isEmpty) {
      emit(PasswordInvalid('Password cannot be empty!'));
      return;
    }

    emit(SignInLoading());
    try {
      // TODO: handle login
    } catch (e) {
      log('error from bloc: $e');
      emit(SignInFailure(e.toString()));
    }
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

  void _onPasswordChanged(PasswordChanged event, Emitter<SignInState> emit) {
    if (event.password.isEmpty) {
      emit(PasswordInvalid('Password cannot be empty!'));
    } else {
      emit(PasswordValid());
    }
  }
}

bool isValidEmail(String email) {
  return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
      .hasMatch(email);
}
