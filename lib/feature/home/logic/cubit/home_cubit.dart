import 'package:bloc/bloc.dart';
import 'package:co_workspace/core/usecase/usecase.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/feature/home/domain/usecase/load_space_usecase.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final LoadSpaceUsecase loadSpaceUsecase;

  HomeCubit(this.loadSpaceUsecase) : super(HomeState.initial());

  fetch() async {
    try {
      emit(HomeState.loading());
      var res = await loadSpaceUsecase(NoParam());
      res.fold(
        (l) => emit(HomeState.error(error: l.error)),
        (r) => emit(HomeState.loaded(spaces: r)),
      );
    } catch (e) {
      emit(HomeState.error(error: e.toString()));
    }
  }
}
