import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostsModel extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get reversedPosts => _posts.reversed.toList();

  int getCount() => _posts.length;

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }
}

@immutable
class Post {
  final String id;
  final File image;
  final DateTime dateTime;
  final String description;

  Post({
    required this.id,
    required this.image,
    required this.dateTime,
    required this.description,
  });
}