import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soedmarket/screens/post_item.dart';
import 'package:soedmarket/services/auth_service.dart';
import 'package:soedmarket/services/post_service.dart';
import 'package:soedmarket/services/user_service.dart';
import 'package:soedmarket/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soedmarket/screens/home_page.dart';
import 'package:soedmarket/screens/notif_page.dart';
import 'package:soedmarket/screens/add_post.dart';

class ProfilePage extends StatefulWidget {
  final AuthService _authService = AuthService();
  final PostService _postService = PostService();
  final UserService _userService = UserService();
  final User? user = FirebaseAuth.instance.currentUser;
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  final PostService _postService = PostService();
  final UserService _userService = UserService();
  final User? user = FirebaseAuth.instance.currentUser;

  String username = '';
  String email = '';
  int postCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      final userData = await _userService.getUserData(user!.uid);
      if (userData != null) {
        setState(() {
          username = userData['username'] ?? 'Mahasiswa';
          email = userData['email'] ?? 'mahasiswa@mhs.unsoed.ac.id';
        });
      }

      final userPosts = await _postService.getPosts();
      setState(() {
        postCount = userPosts.where((post) => post.userId == user!.uid).length;
      });
    }
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await _authService.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('../../assets/defaultpfp.png'),
              backgroundColor: Colors.black,
            ),
            const SizedBox(height: 16),
            Text(
              username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              email,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              postCount.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Postingan'),
            const SizedBox(height: 32),
            Expanded(
              child: FutureBuilder<List<PostModel>>(
                future: _postService.getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No posts available'));
                  } else {
                    final userPosts = snapshot.data!
                        .where((post) => post.userId == user!.uid)
                        .toList();
                    return ListView.builder(
                      itemCount: userPosts.length,
                      itemBuilder: (context, index) {
                        final post = userPosts[index];
                        return PostItem(
                          name: post.username,
                          time: post.createdAt.toString(),
                          content: post.content,
                          imageUrl: post.imageUrl,
                          likes: post.likes.length,
                          comments: post.comments.length,
                          onDelete: () async {
                            await _postService.deletePost(post.id, user!.uid);
                            setState(() {});
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
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
                onPressed: () {},
                icon: const Icon(Icons.person, color: Colors.white),
                iconSize: 28,
              ),
              IconButton(
                onPressed: _confirmLogout,
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                iconSize: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}