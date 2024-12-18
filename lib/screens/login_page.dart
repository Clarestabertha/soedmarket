import 'package:flutter/material.dart';
import 'package:soedmarket/screens/register_page.dart';
import 'package:soedmarket/screens/reset_password.dart';
import 'package:soedmarket/services/auth_service.dart'; // Import the AuthService

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    final user = await _authService.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      // Login successful, navigate to home page
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Login failed, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Gagal. Silahkan coba lagi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Elemen dekoratif lingkaran di sudut kanan bawah
            Positioned(
              bottom: -110,
              right: -90,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFF44027), Color(0xFFFFC857)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Elemen dekoratif lingkaran di sudut kiri atas
            Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFF44027), Color(0xFFFFC857)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Konten utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo dan judul (bersebelahan)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png', // Path logo Anda
                        height: 50,
                      ),
                      const SizedBox(width: 8), // Spasi antara logo dan teks
                      const Text(
                        'SOEDMARKET',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Promote Easily, Sell Quickly with Soedmarket',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Form input email
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Alamat Email',
                      hintText: 'email@unsoed.ac.id',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Form input password
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      hintText: 'masukkan kata sandi',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tombol Lupa Kata Sandi
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Masuk
                  GestureDetector(
                    onTap: _login,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF6F00), Color(0xFFFFD54F)], // Warna gradasi
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white, // Warna teks putih
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Daftar
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman RegisterPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Belum punya akun? Daftar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue, // Warna teks biru
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}