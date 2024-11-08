import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:remind_ui/features/media/presentation/pages/add.dart';
import 'package:remind_ui/features/media/presentation/pages/detail.dart';
import 'package:remind_ui/features/media/presentation/pages/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_observer.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/auth_event.dart';
import 'features/authentication/presentation/pages/login.dart';
import 'features/authentication/presentation/pages/signup.dart';
import 'features/authentication/presentation/pages/welcome.dart';
import 'features/media/presentation/bloc/media_bloc.dart';
import 'features/media/presentation/bloc/media_event.dart';
import 'features/media/presentation/pages/home.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            sl(),
            sl(),
            sl(),
            sl(),
          ),
        ),
        BlocProvider(
          create: (context) => MediaBloc(
            sl(),
            sl(),
            sl(),
            sl(),
            sl(),
            sl(),
            sl(),
          )..add(LoadAllMediaEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: FutureBuilder<String?>(
          future: _getInitialRoute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Welcome(); // Temporary loading page
            } else if (snapshot.hasData) {
              if (snapshot.data == '/home') {
                // Emit events here after the MultiBlocProvider is in context
                context.read<AuthBloc>().add(GetMeEvent());

                return const Home(
                  from: 'login',
                ); // Navigate to Home page
              } else {
                return const Welcome(); // Navigate to Welcome/Login page
              }
            } else {
              return const Welcome(); // Fallback
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
              return _buildPageRoute(const Home(
                from: 'login',
              ));
            case '/add':
              return _buildPageRoute(const Add());
            case '/detail':
              return _buildPageRoute(Detail(
                id: '',
                category: 'defaultCategory',
                createdAt: DateTime.now().toString(),
              ));
            case '/edit':
              return _buildPageRoute(Edit(
                id: '',
                category: 'defaultCategory',
              ));
            default:
              return null;
          }
        },
        theme: ThemeData(
          primaryColor: const Color(0xFF0D1B2A), // Deep Navy
          scaffoldBackgroundColor:
              const Color(0xFFF0F4F8), // Soft Gray background
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black), // Black text color
            bodyMedium: TextStyle(color: Colors.black),
          ),
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(
                  0xFFFFC107)), // Set the default font family to Poppins
        ),
      ),
    );
  }

  Future<String?> _getInitialRoute() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('CACHED_Token');
      print('Token: $token');

      if (token != null && token.isNotEmpty) {
        if (JwtDecoder.isExpired(token)) {
          await prefs.remove('CACHED_Token');
          return '/';
        } else {
          return '/home';
        }
      } else {
        return '/';
      }
    } catch (e) {
      print('Error in _getInitialRoute: $e');
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
}
