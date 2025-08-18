import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<Map<int,int>> {
  SliderCubit():super({});

  void changeIndex(int itemIndex, int imageIndex) {
    emit({...state, itemIndex: imageIndex});
  }

  int getIndex(int itemIndex) {
    return state[itemIndex] ?? 0;
  }
  
}