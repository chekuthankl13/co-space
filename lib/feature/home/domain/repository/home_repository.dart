import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<SpaceEntity>>> loadSpaces();
}
