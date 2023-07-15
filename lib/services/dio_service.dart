import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../model/post_model.dart';

class DioService extends GetxController {
  final String apiUrl = "http://jsonplaceholder.typicode.com/posts";
  final Dio _dio = Dio();

  Future<List<Post>> getPosts() async {
    try {
      var response = await _dio.get(apiUrl);
      List<Post> posts = (response.data as List)
          .map((postJson) => Post.fromJson(postJson))
          .toList();
      return posts;
    } catch (error) {
      throw Exception('Failed to get posts: $error');
    }
  }

  Future<Post> getPost(int postId) async {
    try {
      var response = await _dio.get('$apiUrl/$postId');
      Post post = Post.fromJson(response.data);
      return post;
    } catch (error) {
      throw Exception('Failed to get post: $error');
    }
  }

  Future<void> createPost(Post post) async {
    try {
      await _dio.post(apiUrl, data: post.toJson());
    } catch (error) {
      throw Exception('Failed to create post: $error');
    }
  }

  Future<void> updatePost(int postId, Post post) async {
    try {
      await _dio.put('$apiUrl/$postId', data: post.toJson());
    } catch (error) {
      throw Exception('Failed to update post: $error');
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      await _dio.delete('$apiUrl/$postId');
    } catch (error) {
      throw Exception('Failed to delete post: $error');
    }
  }
}
