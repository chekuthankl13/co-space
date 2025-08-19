import 'package:co_workspace/feature/search/data/repository/search_repository_impl.dart';
import 'package:co_workspace/feature/search/data/source/search_local_data_source.dart';
import 'package:co_workspace/feature/search/domain/repository/search_repository.dart';
import 'package:co_workspace/feature/search/domain/usecase/search_space_usecase.dart';
import 'package:co_workspace/feature/search/logic/search_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initSearch(GetIt sl) async {
  sl.registerFactory(() => SearchCubit(sl()));

  sl.registerLazySingleton(() => SearchSpaceUsecase(repository: sl()));


  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(dbService: sl()),
  );
}
