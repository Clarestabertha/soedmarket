import 'package:flutter/material.dart';
import 'dart:io';

class PostItem extends StatefulWidget {
  final String name;
  final String time;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final bool isLiked;
  final VoidCallback? onDelete;
  final VoidCallback? onLike;
  final VoidCallback? onComment;

  const PostItem({
    Key? key,
    required this.name,
    required this.time,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    this.onDelete,
    this.onLike,
    this.onComment,
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    if (widget.onLike != null) {
      widget.onLike!();
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus postingan ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.onDelete != null) {
                  widget.onDelete!();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEmailModal() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Kirim Email ke ${widget.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Message',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Batal'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Kirim'),
            onPressed: () {
              // Implement email sending logic here
              Navigator.of(context).pop();
              _showEmailSentConfirmation();
            },
          ),
        ],
      );
    },
  );
}

void _showEmailSentConfirmation() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Email Terkirim'),
        content: Text('Email Anda telah berhasil dikirim ke ${widget.name}.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
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
                backgroundImage: AssetImage('../../assets/defaultpfp.png'),
                backgroundColor: Colors.black,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.time,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (widget.onDelete != null) Spacer(),
              if (widget.onDelete != null)
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: _showDeleteConfirmationDialog,
                ),
            ],
          ),
          if (widget.content.isNotEmpty) const SizedBox(height: 10),
          if (widget.content.isNotEmpty)
            Text(
              widget.content,
              style: const TextStyle(fontSize: 14),
            ),
          if (widget.imageUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.file(File(widget.imageUrl!)),
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleLike,
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(widget.likes.toString()),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.onComment,
                    child: Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline, size: 18),
                        const SizedBox(width: 5),
                        Text(widget.comments.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _showEmailModal,
                child: const Icon(Icons.mail_outline, size: 18, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}