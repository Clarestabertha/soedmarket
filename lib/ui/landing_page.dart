import 'package:flutter/material.dart';
import 'package:soedmarket/ui/login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Bagian atas dengan gradasi dan logo
          Expanded(
  flex: 2,
  child: Stack(
    children: [
      // Gradasi yang digeser ke atas menggunakan Positioned
      Positioned(
        top: -10, // Menggeser segi empat ke atas
        left: 0,
        right: 0,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF44027), Color(0xFFEDC537)], // Warna gradasi
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
              bottomRight: Radius.circular(150),
            ),
          ),
          height: 350, // Sesuaikan dengan ukuran gradasi yang diinginkan
        ),
      ),
      // Logo dengan posisi yang diatur
      Positioned(
        top: 280, // Geser logo lebih ke atas
        left: 0,
        right: 0,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/logo.png', // Path logo
            height: 100,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image_not_supported,
              size: 40,
            ),
          ),
        ),
      ),
    ],
  ),
),


          // Bagian tengah: judul dan deskripsi
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'SOEDMARKET',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Marketplace sosial untuk komunitas UNSOED.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Tombol Mulai
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman berikutnya
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Color(0xFFF44027),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text(
                  'Mulai',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


  
