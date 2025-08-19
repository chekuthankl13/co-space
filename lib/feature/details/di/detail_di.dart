import 'package:co_workspace/feature/details/data/repository/detail_repository_impl.dart';
import 'package:co_workspace/feature/details/data/source/detail_local_data_source.dart';
import 'package:co_workspace/feature/details/domain/repository/detail_repository.dart';
import 'package:co_workspace/feature/details/domain/usecase/book_space_usecase.dart';
import 'package:co_workspace/feature/details/domain/usecase/get_space_detail_usecase.dart';
import 'package:co_workspace/feature/details/logic/detail_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initDetail(GetIt sl) async {


  sl.registerFactory(() => DetailCubit(sl(),sl()));

  sl.registerLazySingleton(() => GetSpaceDetailUsecase(repository: sl()));
  sl.registerLazySingleton(() => BookSpaceUsecase(repository: sl()));


  sl.registerLazySingleton<DetailRepository>(
    () => DetailRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<DetailLocalDataSource>(
    () => DetailLocalDataSourceImpl(dbService: sl()),
  );
}
