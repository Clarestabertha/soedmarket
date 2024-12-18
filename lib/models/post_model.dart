import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String content;
  final String? imageUrl;
  final List<String> likes;
  final List<CommentModel> comments;
  final DateTime createdAt;
  final String username;

  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrl,
    this.likes = const [],
    this.comments = const [],
    required this.createdAt,
    required this.username,
  });

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      userId: data['userId'],
      content: data['content'],
      imageUrl: data['imageUrl'],
      likes: List<String>.from(data['likes'] ?? []),
      comments: (data['comments'] as List<dynamic>?)
              ?.map((comment) => CommentModel.fromMap(comment as Map<String, dynamic>))
              .toList() ?? [],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      username: data['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'createdAt': createdAt,
      'username': username,
    };
  }
}

class CommentModel {
  final String userId;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromMap(Map<String, dynamic> data) {
    return CommentModel(
      userId: data['userId'],
      content: data['content'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'createdAt': createdAt,
    };
  }
}