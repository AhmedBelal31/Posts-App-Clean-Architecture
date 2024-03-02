import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/core/error/exceptions.dart';
import 'package:posts_app_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

const cachedPosts = 'CACHED_POSTS' ;
class PostsLocalDataSourceImpl extends PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    sharedPreferences.setString(cachedPosts, json.encode(postModelsToJson));

    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(cachedPosts);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
