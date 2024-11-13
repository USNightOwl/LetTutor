import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/app_logo.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/custom_label.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/custom_text_field.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/social_login.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      // TODO: Bloc
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
                      // TODO: Bloc
                    },
                    showIcon: true,
                    errorText: passwordErrorText,
                    icon: Icons.lock,
                  ),
                  _navigateToForgotPass(context),
                  _loginButton(context),
                  _labelLoginWithSocial(),
                  const SocialLogin(),
                  _navigateToSignUp(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _navigateToSignUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'not_a_member_yet'.tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'sign_up'.tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
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

  MyElevatedButton _loginButton(BuildContext context) {
    return MyElevatedButton(
      text: 'login'.tr(),
      height: 52,
      radius: 8,
      onPressed: () {},
    );
  }

  TextButton _navigateToForgotPass(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(top: 20, bottom: 15),
      ),
      child: Text(
        'forgot_password'.tr(),
        style: const TextStyle(
          fontWeight: FontWeight.normal,
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
}
