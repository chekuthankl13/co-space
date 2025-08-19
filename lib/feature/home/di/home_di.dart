import 'package:co_workspace/feature/home/data/repository/home_repository_impl.dart';
import 'package:co_workspace/feature/home/data/source/home_local_data_source.dart';
import 'package:co_workspace/feature/home/domain/repository/home_repository.dart';
import 'package:co_workspace/feature/home/domain/usecase/load_space_usecase.dart';
import 'package:co_workspace/feature/home/logic/cubit/home_cubit.dart';
import 'package:co_workspace/feature/home/logic/scroll_cubit.dart';
import 'package:co_workspace/feature/home/logic/slider_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initHome(GetIt sl)async{
 sl.registerFactory(()=>ScrollCubit());
 sl.registerFactory(()=>SliderCubit());

 sl.registerFactory(() => HomeCubit(sl()));

  sl.registerLazySingleton(() => LoadSpaceUsecase(repository: sl()));


 sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(dbService: sl()),
  );


}