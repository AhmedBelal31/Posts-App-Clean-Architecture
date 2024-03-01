import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import '../../../../core/error/failures.dart';

abstract class PostsRepo {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();

  Future<Either<Failure, Unit>> deletePost({required int postId});

  Future<Either<Failure, Unit>> updatePost({required PostEntity post});

  Future<Either<Failure, Unit>> addPost({required PostEntity post});
}
