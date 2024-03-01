import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/features/posts/data/models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost({required int postId});

  Future<Unit> updatePost({required PostModel post});

  Future<Unit> addPost({required PostModel post});
}

class PostsRemoteDataSourceImpl extends PostsRemoteDataSource {
  @override
  Future<Unit> addPost({required PostModel post}) async {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost({required int postId}) async {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost({required PostModel post}) async {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
