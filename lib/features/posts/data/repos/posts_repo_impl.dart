import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/core/error/exceptions.dart';
import 'package:posts_app_clean_architecture/core/error/failures.dart';
import 'package:posts_app_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/repos/posts_repo.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/posts_local_data_source.dart';
import '../data_sources/posts_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepoImpl extends PostsRepo {
  PostsRemoteDataSource postsRemoteDataSource;

  PostsLocalDataSource postsLocalDataSource;

  NetworkInfo networkInfo;

  PostsRepoImpl(
      {required this.postsRemoteDataSource,
      required this.postsLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postsRemoteDataSource.getAllPosts();
        postsLocalDataSource.cachePosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postsLocalDataSource.getCachedPosts();
        return right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost({required PostEntity post}) async {
    final PostModel postModel =
        PostModel(title: post.title, body: post.body);
    return await _getMessage(
        () => postsRemoteDataSource.addPost(post: postModel));
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required PostEntity post}) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(
        () => postsRemoteDataSource.updatePost(post: postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    return await _getMessage(
        () => postsRemoteDataSource.deletePost(postId: postId));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
