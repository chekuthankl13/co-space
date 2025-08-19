import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/core/usecase/usecase.dart';
import 'package:co_workspace/feature/booking/domain/repository/booking_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteBookingUsecase extends Usecase<String, String> {
  final BookingRepository repository;

  DeleteBookingUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(String param) async {
    return await repository.delete(id: param);
  }
}
