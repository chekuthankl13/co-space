import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/core/error/exceptions.dart';
import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/feature/search/data/source/search_local_data_source.dart';
import 'package:co_workspace/feature/search/domain/repository/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchLocalDataSource localDataSource;

  SearchRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<SpaceEntity>>> search({
    required String args,
  }) async {
    try {
      var res = await localDataSource.search( search: args);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(error: e.error.toString()));
    }
  }
}
