import 'package:annfsu_app/l10n/app_localizations.dart';
import 'package:annfsu_app/utils/constants.dart';
import 'package:annfsu_app/view/splash.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await ApiConstants.loadBaseUrl();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fade,
        supportedLocales: const [Locale("en", "US"), Locale("ne", "NP")],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizationsDelegate()
        ],
        locale: const Locale("en", "US"),
        theme: ThemeData(
          fontFamily: 'Inter',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.normal,
            ),
            bodyMedium: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.normal,
            ),
            titleLarge: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const SplashView());
  }
}
