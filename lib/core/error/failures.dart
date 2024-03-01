import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class OfflineFailure extends Failure {
  const OfflineFailure({required super.errorMessage});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errorMessage});

  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({required super.errorMessage});

  @override
  List<Object?> get props => [];
}
