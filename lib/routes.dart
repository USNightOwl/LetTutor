import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_in_screen.dart';

class Routes {
  static const String signInScreen = '/sign_in_screen';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      default:
        return MaterialPageRoute(builder: (_) => const UnknownScreen());
    }
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
