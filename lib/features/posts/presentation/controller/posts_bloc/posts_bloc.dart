import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_app_clean_architecture/core/constants/failures.dart';
import 'package:posts_app_clean_architecture/core/error/failures.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/get_all_posts_usecase.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>(
      (event, emit) async {
        if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
          emit(PostsLoadingState());
          final allPostsOrFailure = await getAllPostsUseCase();
          allPostsOrFailure.fold((failure) {
            emit(
                PostsFailureState(errorMessage: _mapFailureToMessage(failure)));
          }, (posts) {
            print(posts);
            emit(PostsSuccessState(posts: posts));
          });
        }
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (EmptyCacheFailure):
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'Unexpected Error , Please try again later .';
    }
  }
}
