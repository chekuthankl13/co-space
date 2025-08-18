import 'package:co_workspace/core/error/failure.dart';
import 'package:dartz/dartz.dart';



abstract class Usecase<Type,Params> {
 Future<Either<Failure,Type>> call(Params param);
}

abstract class Usecase2<Type,Params> {
 Future<Type> call(Params param);
}

class NoParam  {
}