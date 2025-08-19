import 'package:co_workspace/common/cubits/int_cubit.dart';
import 'package:co_workspace/core/db/db_service.dart';
import 'package:co_workspace/feature/booking/di/booking_di.dart';
import 'package:co_workspace/feature/details/di/detail_di.dart';
import 'package:co_workspace/feature/home/di/home_di.dart';
import 'package:co_workspace/feature/search/di/search_di.dart';
import 'package:get_it/get_it.dart';

var sl = GetIt.instance;

Future<void> diInit() async {
  //db
  sl.registerFactory(() => DbService());
  // sl.registerFactory(() => DbService().initDb());

  //common
  sl.registerFactory(() => IntCubit());
  //home
  await initHome(sl);
  //detail
  await initDetail(sl);
  //booking
  await initBooking(sl);
  //SEARCH
  await initSearch(sl);
}
