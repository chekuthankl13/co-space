import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SpaceEntity>>> search({required String args});
}
