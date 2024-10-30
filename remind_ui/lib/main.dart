import 'package:flutter/material.dart';

import 'features/authentication/presentation/pages/login.dart';
import 'features/authentication/presentation/pages/signup.dart';
import 'features/authentication/presentation/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _buildPageRoute(const Welcome());

          case '/login':
            return _buildPageRoute(Login());
          case '/signup':
            return _buildPageRoute(const SignUp());

          default:
            return null;
        }
      },
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 63, 81, 243),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 81, 243))),
    );
  }

  PageRouteBuilder _buildPageRoute(Widget page, {bool fromMiddleDown = false}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin =
            fromMiddleDown ? const Offset(0.0, 0.0) : const Offset(1.0, 0.0);
        final end = fromMiddleDown ? const Offset(0.0, 1.0) : Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
