import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pagination/model/post_model.dart';
import 'package:pagination/repository/post_repository.dart';

class PostProvider with ChangeNotifier {
  final _postRepo = PostRepository();

  final List<PostModel> _posts = [];
  bool _isLoading = false;
  int _page = 1;
  final int _limit = 10;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchedPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<PostModel> newPosts = await _postRepo.fetchedPost(
        page: _page,
        limit: _limit,
      );
      if (newPosts.isEmpty) {
      } else {
        _posts.addAll(newPosts);
        _page++;
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
