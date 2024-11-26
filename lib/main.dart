import 'package:flutter/material.dart';
import 'package:soedmarket/ui/landing_page.dart';

void main() {
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
        fontFamily: 'Poppins', // Terapkan font Poppins di seluruh aplikasi
      ),
      home: LandingPage(), // Pastikan LandingPage adalah const
    );
  }
}
