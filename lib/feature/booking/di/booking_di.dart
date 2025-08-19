import 'package:co_workspace/feature/booking/data/repository/booking_repository_impl.dart';
import 'package:co_workspace/feature/booking/data/source/booking_local_source.dart';
import 'package:co_workspace/feature/booking/domain/repository/booking_repository.dart';
import 'package:co_workspace/feature/booking/domain/usecase/delete_booking_usecase.dart';
import 'package:co_workspace/feature/booking/domain/usecase/load_booking_usecase.dart';
import 'package:co_workspace/feature/booking/logic/booking_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initBooking(GetIt sl) async {
  sl.registerFactory(() => BookingCubit(sl(),sl()));

  sl.registerLazySingleton(() => LoadBookingUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteBookingUsecase(repository: sl()));

 

  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(localSource: sl()),
  );

  sl.registerLazySingleton<BookingLocalSource>(
    () => BookingLocalSourceImpl(dbService: sl()),
  );
}
