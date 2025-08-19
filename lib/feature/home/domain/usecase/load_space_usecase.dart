import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/core/usecase/usecase.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/feature/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class LoadSpaceUsecase extends Usecase<List<SpaceEntity>, NoParam> {
  final HomeRepository repository;

  LoadSpaceUsecase({required this.repository});

  @override
  Future<Either<Failure, List<SpaceEntity>>> call(NoParam param) async {
    return await repository.loadSpaces();
  }
}
