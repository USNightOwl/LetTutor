import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_in_screen.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_up_screen.dart';
import 'package:let_tutor/presentation/screen/home.dart';

class Routes {
  static const String signInScreen = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        return MaterialPageRoute(builder: (_) => const UnknownScreen());
    }
  }

  static Future<void> navigateToReplacement(
      BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed(context, routeName);
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown Screen'),
      ),
      body: const Center(
        child: Text('Unknown Screen'),
      ),
    );
  }
}
