import 'package:co_workspace/core/error/exceptions.dart';
import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/feature/home/data/source/home_local_data_source.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/feature/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, List<SpaceEntity>>> loadSpaces()async {
     try {
      var res = await localDataSource.loadSpaces();
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(error: e.error.toString()));
    }
  }
}
