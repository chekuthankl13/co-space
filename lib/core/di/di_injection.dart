import 'package:co_workspace/common/int_cubit.dart';
import 'package:co_workspace/feature/home/di/home_di.dart';
import 'package:get_it/get_it.dart';

var sl = GetIt.instance;

Future<void> diInit()async{
  //common
  sl.registerFactory(()=>IntCubit());
  //home 
  await initHome(sl);
}