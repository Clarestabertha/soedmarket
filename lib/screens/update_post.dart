import 'package:flutter/material.dart';
import 'package:soedmarket/models/post_model.dart';
import 'package:soedmarket/services/post_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UpdatePostPage extends StatefulWidget {
  final PostModel post;

  const UpdatePostPage({Key? key, required this.post}) : super(key: key);

  @override
  _UpdatePostPageState createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  File? _imageFile;
  final PostService _postService = PostService();

  @override
  void initState() {
    super.initState();
    _contentController.text = widget.post.content;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _updatePost() async {
    if (_formKey.currentState!.validate()) {
      await _postService.updatePost(
        postId: widget.post.id,
        content: _contentController.text,
        imageFile: _imageFile,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : widget.post.imageUrl != null
                      ? Image.network(widget.post.imageUrl!)
                      : Container(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updatePost,
                child: Text('Update Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}