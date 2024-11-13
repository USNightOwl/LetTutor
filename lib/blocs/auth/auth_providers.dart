import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_in/sing_in_bloc.dart';

List<BlocProvider> buildAuthBlocs(BuildContext context) {
  return [
    BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
          // authenticationRepository: context.read<AuthenticationRepository>(),
          ),
    ),
  ];
}
