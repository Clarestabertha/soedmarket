import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../models/post_model.dart';
import '../models/user_model.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<PostModel?> createPost({
    required String userId,
    required String content,
    String? imagePath,
  }) async {
    try {
      // Ambil data pengguna
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final username = userDoc.data()?['username'] ?? '';

      final postRef = _firestore.collection('posts').doc();
      final newPost = PostModel(
        id: postRef.id,
        userId: userId,
        content: content,
        imageUrl: imagePath,
        createdAt: DateTime.now(),
        username: username,
      );

      await postRef.set(newPost.toMap());
      return newPost;
    } catch (e) {
      print('Error creating post: $e');
      return null;
    }
  }

  Future<List<PostModel>> getPosts() async {
    try {
      final querySnapshot = await _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        try {
          return PostModel.fromFirestore(doc);
        } catch (e) {
          print('Error converting document ${doc.id}: $e');
          return null;
        }
      }).where((post) => post != null).cast<PostModel>().toList();
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  Future<void> likePost(String postId, String userId) async {
    final postRef = _firestore.collection('posts').doc(postId);
    
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(postRef);
      final post = PostModel.fromFirestore(snapshot);
      
      final List<String> updatedLikes = List.from(post.likes);
      if (updatedLikes.contains(userId)) {
        updatedLikes.remove(userId);
      } else {
        updatedLikes.add(userId);
      }

      transaction.update(postRef, {
        'likes': updatedLikes
      });
    });
  }

  Future<void> addComment({
    required String postId,
    required String userId,
    required String content,
  }) async {
    final postRef = _firestore.collection('posts').doc(postId);
    
    final commentData = {
      'userId': userId,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await postRef.update({
      'comments': FieldValue.arrayUnion([commentData])
    });
  }


  Future<void> updatePost({
  required String postId,
  required String content,
  File? imageFile,
}) async {
  try {
    String? imageUrl;

    if (imageFile != null) {
      final storageRef = _storage.ref().child('posts/$postId/${DateTime.now().toIso8601String()}');
      await storageRef.putFile(imageFile);
      imageUrl = await storageRef.getDownloadURL();
    }

    final postRef = _firestore.collection('posts').doc(postId);
    final updateData = {
      'content': content,
      'imageUrl': imageUrl,
      'updatedAt': DateTime.now(),
    };

    await postRef.update(updateData);
  } catch (e) {
    print('Error updating post: $e');
    rethrow;
  }
}

  Future<void> deletePost(String postId, String userId) async {
    try {
      final postRef = _firestore.collection('posts').doc(postId);
      final snapshot = await postRef.get();
      
      if (snapshot.exists) {
        final post = PostModel.fromFirestore(snapshot);
        
        // Pastikan yang menghapus adalah pemilik post
        if (post.userId == userId) {
          // Hapus gambar dari storage jika ada
          if (post.imageUrl != null) {
            await FirebaseStorage.instance.refFromURL(post.imageUrl!).delete();
          }
          
          // Hapus dokumen dari Firestore
          await postRef.delete();
        } else {
          throw Exception('Anda tidak memiliki izin menghapus post ini');
        }
      }
    } catch (e) {
      print('Error deleting post: $e');
      rethrow;
    }
  }
}