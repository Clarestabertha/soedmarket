import 'package:flutter/material.dart';
import 'home_page.dart';  // Import halaman HomePage
import 'chat_screen.dart'; // Import halaman ChatScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MessagesPage(),
    );
  }
}

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Arahkan ke HomePage saat tombol kembali ditekan
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Menggunakan pushReplacement
            );
          },
        ),
        title: const Text(
          'Pesan',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Kolom Pencarian
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF6F00),
                    Color(0xFFFFD54F),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.search, color: Colors.white),
                  const SizedBox(width: 8),
                  const Text(
                    'Cari Pesan....',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.black,
          ),
          // Daftar Pesan
          Expanded(
            child: ListView(
              children: [
                _buildMessageTile(
                  context,
                  name: 'Claresta Berthalita Jatmika',
                  message: 'Terimakasih kembali kak...',
                  date: '18/11/2024',
                ),
                _buildMessageTile(
                  context,
                  name: 'Nabilla Tsani Ayasi',
                  message: 'Haloo',
                  date: '17/11/2024',
                ),
                _buildMessageTile(
                  context,
                  name: 'Fawwaz Afkar Muzakky',
                  message: 'Test',
                  date: '18/11/2024',
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFF6F00),
              Color(0xFFFFD54F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Pesan Baru',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Text(
                                  'foto',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: const Text('Claresta Berthalita Jatmika'),
                            ),
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Text(
                                  'foto',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: const Text('Nabilla Tsani Ayasi'),
                            ),
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Text(
                                  'foto',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: const Text('Fawwaz Afkar Muzakky'),
                            ),
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Text(
                                  'foto',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: const Text('Zayn Malik'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageTile(BuildContext context, {
    required String name,
    required String message,
    required String date,
  }) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.orange,
        child: Text(
          'foto',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(message),
      trailing: Text(date, style: const TextStyle(color: Colors.grey)),
      onTap: () {
        // Navigasi ke ChatScreen saat kontak di tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      },
    );
  }
}
