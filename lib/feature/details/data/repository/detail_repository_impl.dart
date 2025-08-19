import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/core/error/exceptions.dart';
import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/feature/details/data/source/detail_local_data_source.dart';
import 'package:co_workspace/feature/details/domain/repository/detail_repository.dart';
import 'package:dartz/dartz.dart';

class DetailRepositoryImpl extends DetailRepository {
  final DetailLocalDataSource localDataSource;

  DetailRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, SpaceEntity>> getSpaceDetail({required String id})async {
   try {
      var res = await localDataSource.getDetail(id: id);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(error: e.error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> book({required Map<String, dynamic> details})async {
     try {
      var res = await localDataSource.book(param: details);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(error: e.error.toString()));
    }
  }
}
