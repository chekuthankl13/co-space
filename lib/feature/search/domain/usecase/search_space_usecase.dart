import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/core/usecase/usecase.dart';
import 'package:co_workspace/feature/search/domain/repository/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchSpaceUsecase extends Usecase<List<SpaceEntity>, String> {
  final SearchRepository repository;

  SearchSpaceUsecase({required this.repository});
  @override
  Future<Either<Failure, List<SpaceEntity>>> call(String param) async {
    return await repository.search(args: param);
  }
}
