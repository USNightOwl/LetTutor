import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/auth/auth_providers.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/configs/app_localizations.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_in_screen.dart';
import 'package:let_tutor/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.readCountriesFromJson();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [
        AppLocalizations.engLocale,
        AppLocalizations.vieLocale,
      ],
      path: AppLocalizations.translationFilePath,
      fallbackLocale: AppLocalizations.engLocale, // default locale
      startLocale: AppLocalizations.engLocale, // default locale
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'LetTutor',
        // Easy Localization
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        // ------------------
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0058C6),
            secondary: Colors.blueAccent,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        onGenerateRoute: Routes.generateRoute,
        home: MultiBlocProvider(
          providers: buildAuthBlocs(context),
          child: const SignInScreen(),
        ),
      ),
    );
  }
}
