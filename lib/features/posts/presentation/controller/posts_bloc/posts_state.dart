part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsSuccessState extends PostsState {
  final List<PostEntity> posts;

  PostsSuccessState({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostsFailureState extends PostsState {
  final String errorMessage;

  PostsFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
