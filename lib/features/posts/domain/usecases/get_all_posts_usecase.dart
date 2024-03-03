import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/core/error/failures.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/repos/posts_repo.dart';
import '../../../../core/usecase/usecase.dart';

class GetAllPostsUseCase extends UseCase<List<PostEntity>, void> {
  final PostsRepo postsRepo;

  GetAllPostsUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, List<PostEntity>>> call([void parameter]) async {
    return await postsRepo.getAllPosts();
  }
}
