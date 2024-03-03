part of 'add_delete_update_post_bloc.dart';

@immutable
abstract class AddDeleteUpdatePostState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

class AddDeleteUpdatePostLoadingState extends AddDeleteUpdatePostState {}

class AddDeleteUpdatePostSuccessState extends AddDeleteUpdatePostState {
  final String successMessage;

  AddDeleteUpdatePostSuccessState({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class AddDeleteUpdatePostFailureState extends AddDeleteUpdatePostState {
  final String errorMessage;

  AddDeleteUpdatePostFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
