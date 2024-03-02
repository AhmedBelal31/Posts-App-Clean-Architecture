import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/core/constants/api_constants.dart';
import 'package:posts_app_clean_architecture/core/error/exceptions.dart';
import 'package:posts_app_clean_architecture/core/web_services/web_services.dart';
import 'package:posts_app_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost({required int postId});

  Future<Unit> updatePost({required PostModel post});

  Future<Unit> addPost({required PostModel post});
}

class PostsRemoteDataSourceImpl extends PostsRemoteDataSource {
  // final http.Client client;
  //
  // PostsRemoteDataSourceImpl({required this.client});

  // @override
  // Future<List<PostModel>> getAllPosts() async {
  //   final response = await client.get(Uri.parse('$baseUrl$postsEndPoint'));
  //   if (response.statusCode == 200) {
  //     final List data = json.decode(response.body) as List;
  //
  //     List<PostModel> allPosts =data.map<PostModel>((postMap) => PostModel.fromJson(postMap)).toList();
  //     // client.close();
  //     return allPosts;
  //   } else {
  //     throw ServerException();
  //   }
  //
  // }

  WebServices webServices;

  PostsRemoteDataSourceImpl({required this.webServices});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await webServices.getData(endPoint: postsEndPoint);
    final List data = json.decode(response.body) as List;

    List<PostModel> allPosts =
        data.map<PostModel>((postMap) => PostModel.fromJson(postMap)).toList();
    return allPosts;
    // client.close();
  }

  @override
  Future<Unit> addPost({required PostModel post}) async {
    final body = {
      'id': post.id,
      'title': post.title,
      'body': post.body,
    };
    final response = webServices.postData(body: body, endPoint: postsEndPoint);

    return response;
  }

  @override
  Future<Unit> deletePost({required int postId}) async {
    final response = webServices.deleteData(endPoint: '$postsEndPoint/$postId');
    return response;
  }

  @override
  Future<Unit> updatePost({required PostModel post}) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response = webServices.updateData(
        endPoint: '$postsEndPoint/${post.id}', body: body);
    return response;
  }
}
