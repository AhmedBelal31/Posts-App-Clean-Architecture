import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/core/error/failures.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/repos/posts_repo.dart';
import '../../../../core/usecase/usecase.dart';

class DeletePostUseCase extends UseCase<Unit, int> {
  final PostsRepo postsRepo;

  DeletePostUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, Unit>> execute([int? parameter]) async {
    return await postsRepo.deletePost(postId: parameter!);
  }
}
