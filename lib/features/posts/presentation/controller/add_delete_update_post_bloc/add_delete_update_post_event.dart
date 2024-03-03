part of 'add_delete_update_post_bloc.dart';

@immutable
abstract class AddDeleteUpdatePostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostEvent {
  final PostEntity post;

  AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  final PostEntity post;

  UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdatePostEvent {
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
