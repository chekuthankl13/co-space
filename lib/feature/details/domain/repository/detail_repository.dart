import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DetailRepository {
  Future<Either<Failure, SpaceEntity>> getSpaceDetail({required String id});

  Future<Either<Failure, String>> book({required Map<String,dynamic> details});


}
