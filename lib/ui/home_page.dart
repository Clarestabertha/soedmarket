import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'SOEDMARKET',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mail_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PostItem(
            name: "Claresta Berthalita Jatmika",
            time: "17/11/2024 11:46 AM",
            content:
                "Yang Mau Sewa Motor bisa DM aku, only 60k bisa sewa motor seharian",
            likes: 2,
            comments: 0,
          ),
          PostItem(
            name: "Nabilla Tsani Ayasi",
            time: "17/11/2024 09:00 AM",
            content: "Hayukk DM aja for order",
            imageUrl: "cemara.jpg",
            likes: 5,
            comments: 2,
          ),
          PostItem(
            name: "Fawwaz Afkar Muzakky",
            time: "16/11/2024 10:00 AM",
            content:
                "Yang Mau Sewa Handphone bisa DM aku, only 30k seharian",
            likes: 3,
            comments: 1,
          ),
          PostItem(
            name: "Zayn Malik",
            time: "15/11/2024 11:46 AM",
            content: "",
            likes: 0,
            comments: 0,
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF44027), Color(0xFFFFC857)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home_outlined, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_outline, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final String name;
  final String time;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;

  const PostItem({
    Key? key,
    required this.name,
    required this.time,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.orange,
                child: Text(
                  "foto",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          if (content.isNotEmpty) const SizedBox(height: 10),
          if (content.isNotEmpty)
            Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
          if (imageUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(imageUrl!),
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite_border, size: 18),
                  const SizedBox(width: 5),
                  Text(likes.toString()),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _showCommentModal(context),
                    child: Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline, size: 18),
                        const SizedBox(width: 5),
                        Text(comments.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              const Icon(Icons.mail_outline, size: 18),
              const Icon(Icons.bookmark_outline, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan modal komentar
  void _showCommentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.6, // Tinggi modal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Komentar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(
  child: ListView(
    children: const [
      ListTile(
        leading: CircleAvatar(child: Text("A")),
        title: Text(
          "User 1",
          style: TextStyle(fontWeight: FontWeight.bold), // Menebalkan nama User 1
        ),
        subtitle: Text("Komentar pertama!"),
      ),
      ListTile(
        leading: CircleAvatar(child: Text("B")),
title: Text(
          "User 2",
          style: TextStyle(fontWeight: FontWeight.bold), // Menebalkan nama User 1
        ),        subtitle: Text("Komentar kedua!"),
      ),
    ],
  ),
),
            ],
          ),
        );
      },
    );
  }
}
