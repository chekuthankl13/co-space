import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/feature/booking/domain/entity/booking_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getBookings();
  Future<Either<Failure, String>> delete({required String id});

}
