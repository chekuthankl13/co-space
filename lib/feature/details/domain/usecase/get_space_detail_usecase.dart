import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/core/usecase/usecase.dart';
import 'package:co_workspace/feature/details/domain/repository/detail_repository.dart';
import 'package:dartz/dartz.dart';

class GetSpaceDetailUsecase extends Usecase<SpaceEntity, String> {
  final DetailRepository repository;

  GetSpaceDetailUsecase({required this.repository});
  @override
  Future<Either<Failure, SpaceEntity>> call(String param) async {
    return await repository.getSpaceDetail(id: param);
  }
}
