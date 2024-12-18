import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soedmarket/services/post_service.dart';
import 'package:soedmarket/models/post_model.dart';
import 'package:soedmarket/screens/notif_page.dart';
import 'package:soedmarket/screens/add_post.dart';
import 'package:soedmarket/screens/profile_page.dart';
import 'package:soedmarket/screens/post_item.dart'; // Import the PostItem widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostService _postService = PostService();
  final User? user = FirebaseAuth.instance.currentUser;
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _postService.getPosts();
  }

  void _refreshPosts() {
    setState(() {
      _postsFuture = _postService.getPosts();
    });
  }

  void _showDevelopmentModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informasi'),
          content: Text('Fitur ini masih dalam pengembangan'),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showDevelopmentModal(context);
            },
            icon: const Icon(
              Icons.comment,
              color: Color.fromARGB(255, 97, 97, 97),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return PostItem(
                  name: post.username,
                  time: post.createdAt.toString(),
                  content: post.content,
                  imageUrl: post.imageUrl,
                  likes: post.likes.length,
                  comments: post.comments.length,
                  onLike: () async {
                    await _postService.likePost(post.id, 'currentUserId'); // Ganti dengan userId yang sesuai
                    _refreshPosts();
                  },
                  onComment: () {
                    _showCommentModal(context, post);
                  },
                );
              },
            );
          }
        },
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
                onPressed: () {},
                icon: const Icon(Icons.home, color: Colors.white),
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

  void _showCommentModal(BuildContext context, PostModel post) {
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
        final TextEditingController _commentController = TextEditingController();
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.6,
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
                    child: ListView.builder(
                      itemCount: post.comments.length,
                      itemBuilder: (context, index) {
                        final comment = post.comments[index];
                        return ListTile(
                          leading: CircleAvatar(child: Text(comment.userId[0].toUpperCase())),
                          title: Text(
                            comment.userId,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(comment.content),
                        );
                      },
                    ),
                  ),
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Tambahkan komentar...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          final commentContent = _commentController.text;
                          if (commentContent.isNotEmpty) {
                            await _postService.addComment(
                              postId: post.id,
                              userId: user!.uid, // Ganti dengan userId yang sesuai
                              content: commentContent,
                            );
                            _commentController.clear();
                            setState(() {
                              post.comments.add(CommentModel(
                                userId: user!.uid, // Ganti dengan userId yang sesuai
                                content: commentContent,
                                createdAt: DateTime.now(),
                              ));
                            });
                            _refreshPosts();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}