import 'package:co_workspace/core/error/exceptions.dart';
import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/feature/booking/data/source/booking_local_source.dart';
import 'package:co_workspace/feature/booking/domain/entity/booking_entity.dart';
import 'package:co_workspace/feature/booking/domain/repository/booking_repository.dart';
import 'package:dartz/dartz.dart';

class BookingRepositoryImpl extends BookingRepository {
  final BookingLocalSource localSource;

  BookingRepositoryImpl({required this.localSource});
  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings()async {
     try {
      var res = await localSource.bookings();
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(error: e.error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> delete({required String id})async {
  try {
      var res = await localSource.delete(id: id);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(error: e.error.toString()));
    }
  }
}
