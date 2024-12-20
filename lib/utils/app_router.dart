import 'package:flutter/material.dart';

import '../presentation/screens/home_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/signup_screen.dart';
import '../presentation/screens/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case SplashScreen.id:
            return const SplashScreen();
          case LoginScreen.id:
            return const LoginScreen();
          case SignupScreen.id:
            return const SignupScreen();
          case HomeScreen.id:
            return const HomeScreen();
          default:
            return const SplashScreen();
        }
      },
      // settings: RouteSettings(name: settings.name),
    );
  }
}
