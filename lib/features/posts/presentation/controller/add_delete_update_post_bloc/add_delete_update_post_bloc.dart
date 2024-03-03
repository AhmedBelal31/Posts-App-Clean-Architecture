import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';

import '../../../../../core/constants/failures.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/add_post_usecase.dart';
import '../../../domain/usecases/delete_postusecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';

part 'add_delete_update_post_event.dart';

part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  AddPostUseCase addPostUseCase;

  DeletePostUseCase deletePostUseCase;

  UpdatePostUseCase updatePostUseCase;

  AddDeleteUpdatePostBloc({
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(AddDeleteUpdatePostInitial()) {
    {
      on<AddDeleteUpdatePostEvent>(
        (event, emit) async {
          if (event is AddPostEvent) {
            emit(AddDeleteUpdatePostLoadingState());
            final failureOrDoneMessage = await addPostUseCase.call(event.post);
           emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
          } else if (event is UpdatePostEvent) {
            emit(AddDeleteUpdatePostLoadingState());
            final failureOrDoneMessage = await updatePostUseCase.call(event.post);
            emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
          } else if (event is DeletePostEvent) {
            emit(AddDeleteUpdatePostLoadingState());
            final failureOrDoneMessage =
                await deletePostUseCase.call(event.postId);
            emit(_eitherDoneMessageOrErrorState(
                failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
          }
        },
      );
    }
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
    Either<Failure, Unit> either,
    String successMessage,
  ) {
    return either.fold((failure) {
      return AddDeleteUpdatePostFailureState(
        errorMessage: _mapFailureToMessage(failure),
      );
    }, (_) {
      return AddDeleteUpdatePostSuccessState(
        successMessage: successMessage,
      );
    });
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
