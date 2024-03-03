import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/core/error/failures.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/repos/posts_repo.dart';
import '../../../../core/usecase/usecase.dart';

class AddPostUseCase extends UseCase<Unit, PostEntity> {
  final PostsRepo postsRepo;

  AddPostUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, Unit>> call([PostEntity? parameter]) async {
    return await postsRepo.addPost(post: parameter!);
  }
}
