import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';  // Add this line
import 'package:soedmarket/screens/add_post.dart';
import 'package:soedmarket/screens/home_page.dart';
import 'package:soedmarket/screens/profile_page.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildNotificationItem(
            'Claresta Berthalita Jatmika',
            'menyukai postingan anda',
            'Baru Saja',
          ),
          _buildNotificationItem(
            'Claresta Berthalita Jatmika',
            'mengomentari postingan anda',
            'Baru Saja',
          ),
          _buildNotificationItem(
            'Nabilla Tsani Ayasi',
            'menyukai postingan anda',
            '1 Jam yang lalu',
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF44027), Color(0xFFFFC857)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.home_outlined, color: Colors.white),
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications, color: Colors.white),
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPostPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.person_outline, color: Colors.white),
                iconSize: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String name, String action, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.yellow,
            child: Text('foto'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                      TextSpan(
                        text: ' $action',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
