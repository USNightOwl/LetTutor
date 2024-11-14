import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_event.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_state.dart';
import 'package:let_tutor/data/models/user/authentication_response.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';
import 'package:let_tutor/data/sharedpref/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository authenticationRepository;
  late SharedPreferenceHelper sharedPrefsHelper;

  SignUpBloc({required this.authenticationRepository})
      : super(SignUpInitial()) {
    _getPres();
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RetypePasswordChanged>(_onRetypePasswordChanged);
  }

  void _getPres() async {
    sharedPrefsHelper =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
  }

  void _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
    } else if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
    } else if (event.password.isEmpty) {
      emit(PasswordInvalid('Password cannot be empty!'));
    } else if (event.retypePassword.isEmpty) {
      emit(RetypePasswordInvalid('Retyped password cannot be empty!'));
    } else if (event.password != event.retypePassword) {
      emit(RetypePasswordInvalid('Passwords do not match!'));
    } else {
      emit(SignUpLoading());
      try {
        AuthenticationResponse registerResponse =
            await authenticationRepository.signUp(event.email, event.password);

        String accessToken = registerResponse.tokens.access.token;
        String refreshToken = registerResponse.tokens.refresh.token;

        log('accessToken: $accessToken');
        log('refreshToken: $refreshToken');

        // Save the tokens for later use
        await saveTokens(accessToken, refreshToken);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    }
  }

  void _onRetypePasswordChanged(
      RetypePasswordChanged event, Emitter<SignUpState> emit) {
    if (event.retypePassword.isEmpty) {
      emit(RetypePasswordInvalid('Retyped password cannot be empty!'));
    } else {
      emit(RetypePasswordValid());
    }
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    if (event.password.isEmpty) {
      emit(PasswordInvalid('Password cannot be empty!'));
    } else {
      emit(PasswordValid());
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
    } else if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
    } else {
      emit(EmailValid());
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    sharedPrefsHelper.saveAcessToken(accessToken);
    sharedPrefsHelper.saveRefreshToken(refreshToken);
  }
}

bool isValidEmail(String email) {
  return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
      .hasMatch(email);
}
