import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Parameter> {
  Future<Either<Failure, Type>> call([Parameter parameter]);
}
