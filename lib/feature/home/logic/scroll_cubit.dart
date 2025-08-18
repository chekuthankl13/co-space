import 'package:bloc/bloc.dart';

class ScrollCubit extends Cubit<bool> {
  ScrollCubit():super(true);

  update(bool val)=>emit(val);
  
}