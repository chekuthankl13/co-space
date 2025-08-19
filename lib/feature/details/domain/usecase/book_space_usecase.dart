import 'package:co_workspace/core/error/failure.dart';
import 'package:co_workspace/core/usecase/usecase.dart';
import 'package:co_workspace/feature/details/domain/repository/detail_repository.dart';
import 'package:dartz/dartz.dart';

class BookSpaceUsecase extends Usecase<String, Map<String, dynamic>> {
  final DetailRepository repository;

  BookSpaceUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> param) async {
    return await repository.book(details: param);
  }
}
