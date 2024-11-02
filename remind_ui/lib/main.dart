import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_observer.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/auth_event.dart';
import 'features/authentication/presentation/pages/home.dart';
import 'features/authentication/presentation/pages/login.dart';
import 'features/authentication/presentation/pages/signup.dart';
import 'features/authentication/presentation/pages/welcome.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        sl(),
        sl(),
        sl(),
        sl(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: FutureBuilder<String?>(
          future: _getInitialRoute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading screen while checking the token
              return const Welcome(); // Temporary Welcome page
            } else {
              final initialRoute = snapshot.data ?? '/';
              if (initialRoute == '/home') {
                // Dispatch GetMeEvent if navigating to home
                context.read<AuthBloc>().add(GetMeEvent());
              }
              return _buildHome(initialRoute);
            }
          },
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return _buildPageRoute(const Welcome());
            case '/login':
              return _buildPageRoute(Login());
            case '/signup':
              return _buildPageRoute(const SignUp());
            case '/home':
              return _buildPageRoute(Home());
            default:
              return null;
          }
        },
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 63, 81, 243),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 81, 243),
          ),
        ),
      ),
    );
  }

  Future<String?> _getInitialRoute() async {
    // Retrieve the token from shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('CACHED_Token');
    print('-------------------------------------token: $token');
    if (token != null) {
      // If a token exists, route to the home page
      return '/home';
    } else {
      // If no token is found, route to the login page
      return '/';
    }
  }

  PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        var tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _buildHome(String initialRoute) {
    if (initialRoute == '/home') {
      return Home(); // Navigate to home page
    } else {
      return const Welcome(); // Navigate to welcome page
    }
  }
}
