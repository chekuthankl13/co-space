import 'package:co_workspace/feature/home/logic/scroll_cubit.dart';
import 'package:co_workspace/feature/home/logic/slider_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initHome(GetIt sl)async{
 sl.registerFactory(()=>ScrollCubit());
 sl.registerFactory(()=>SliderCubit());

}