import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_event.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_state.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/app_logo.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/custom_label.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/custom_text_field.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/social_login.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;
  String? retypePasswordErrorText;
  bool _obscureText = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            handleState(context, state);
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const AppLogo(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabel(text: 'email'.tr()),
                        CustomTextField(
                          hintText: 'mail@example.com',
                          controller: _emailController,
                          onChanged: (value) {
                            context
                                .read<SignUpBloc>()
                                .add(EmailChanged(email: value));
                          },
                          errorText: emailErrorText,
                          icon: Icons.mail,
                        ),
                        const SizedBox(height: 10),
                        CustomLabel(text: 'password'.tr()),
                        CustomTextField(
                          hintText: 'password'.tr(),
                          controller: _passwordController,
                          obscureText: _obscureText,
                          onPressedHidePass: _togglePasswordVisibility,
                          onChanged: (value) {
                            context
                                .read<SignUpBloc>()
                                .add(PasswordChanged(password: value));
                          },
                          showIcon: true,
                          errorText: passwordErrorText,
                          icon: Icons.lock,
                        ),
                        const SizedBox(height: 10),
                        CustomLabel(text: 'retype_password'.tr()),
                        CustomTextField(
                          hintText: 'retype_password'.tr(),
                          controller: _retypePasswordController,
                          obscureText: _obscureText2,
                          onPressedHidePass: _togglePasswordVisibility2,
                          onChanged: (value) {
                            context.read<SignUpBloc>().add(
                                RetypePasswordChanged(retypePassword: value));
                          },
                          showIcon: true,
                          errorText: retypePasswordErrorText,
                          icon: Icons.lock,
                        ),
                        const SizedBox(height: 20),
                        _signUpButton(context),
                        _labelLoginWithSocial(),
                        const SocialLogin(),
                        _navigateToSignIn(context),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void handleState(BuildContext context, SignUpState state) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    switch (state.runtimeType) {
      case const (EmailInvalid):
        emailErrorText = (state as EmailInvalid).error;
        break;
      case const (EmailValid):
        emailErrorText = null;
        break;
      case const (PasswordInvalid):
        passwordErrorText = (state as PasswordInvalid).error;
        break;
      case const (PasswordValid):
        passwordErrorText = null;
        break;
      case const (RetypePasswordInvalid):
        retypePasswordErrorText = (state as RetypePasswordInvalid).error;
        break;
      case const (RetypePasswordValid):
        retypePasswordErrorText = null;
        break;
      case const (PasswordsDoNotMatch):
        retypePasswordErrorText = (state as PasswordsDoNotMatch).error;
        break;
      case const (SignUpLoading):
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Signing up...'),
          ),
        );
        break;
      case const (SignUpSuccess):
        scaffoldMessenger.hideCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Sign up success!'),
          ),
        );
        Routes.navigateToReplacement(context, Routes.signInScreen);
        break;
      case const (SignUpFailure):
        scaffoldMessenger.hideCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text((state as SignUpFailure).error),
          ),
        );
        break;
    }
  }

  Row _navigateToSignIn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'already_have_an_account'.tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        TextButton(
          onPressed: () {
            Routes.navigateToReplacement(context, Routes.signInScreen);
          },
          child: Text(
            'login'.tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  MyElevatedButton _signUpButton(BuildContext context) {
    return MyElevatedButton(
      text: 'sign_up'.tr(),
      height: 52,
      radius: 8,
      onPressed: () {
        context.read<SignUpBloc>().add(
              SignUpSubmitted(
                email: _emailController.text,
                password: _passwordController.text,
                retypePassword: _retypePasswordController.text,
              ),
            );
      },
    );
  }

  Container _labelLoginWithSocial() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      child: Text(
        'or_continue_with'.tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }
}
