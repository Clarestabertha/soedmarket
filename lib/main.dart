import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soedmarket/screens/landing_page.dart';
import 'package:soedmarket/screens/home_page.dart';
import 'package:soedmarket/screens/login_page.dart';
import 'package:soedmarket/screens/register_page.dart';
import 'package:soedmarket/services/auth_service.dart';
import 'package:soedmarket/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';// Import your Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoedMarket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 235),
        primarySwatch: Colors.orange,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder( borderSide: BorderSide(color: Colors.orange)),
        ),
      textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const AuthWrapper(),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const LandingPage();
          } else {
            return const HomePage();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}