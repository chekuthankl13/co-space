import 'package:flutter_bloc/flutter_bloc.dart';

class IntCubit extends Cubit<int> {
  IntCubit():super(0);
  update(int val)=>emit(val);
}