import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/core/usecase/usecase.dart';
import 'package:co_workspace/feature/booking/domain/entity/booking_entity.dart';
import 'package:co_workspace/feature/booking/domain/repository/booking_repository.dart';
import 'package:dartz/dartz.dart';

class LoadBookingUsecase extends Usecase<List<BookingEntity>, NoParam> {
  final BookingRepository repository;

  LoadBookingUsecase({required this.repository});
  @override
  Future<Either<Failure, List<BookingEntity>>> call(NoParam param) async {
    return await repository.getBookings();
  }
}
