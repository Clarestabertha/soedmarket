import 'package:flutter/material.dart';
import 'package:soedmarket/services/post_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _contentController = TextEditingController();
  final PostService _postService = PostService();
  final User? user = FirebaseAuth.instance.currentUser;
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = path.join(directory.path, 'images', path.basename(pickedFile.path));
      final imageFile = File(pickedFile.path);
      await imageFile.copy(imagePath);

      setState(() {
        _selectedImagePath = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Postingan Baru'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Masukkan isi konten postingan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 10),
            IconButton(
              onPressed: _pickImage,
              icon: Icon(Icons.image, color: Colors.orange),
            ),
            Text(
              'Pilih gambar yang akan di upload',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            if (_selectedImagePath != null)
              Image.file(File(_selectedImagePath!)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (user != null) {
                  await _postService.createPost(
                    userId: user!.uid,
                    content: _contentController.text,
                    imagePath: _selectedImagePath,
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Text('Kirim'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}