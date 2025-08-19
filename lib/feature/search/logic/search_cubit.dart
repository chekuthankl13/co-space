import 'package:bloc/bloc.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/feature/search/domain/usecase/search_space_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchSpaceUsecase searchSpaceUsecase;
  SearchCubit(this.searchSpaceUsecase) : super(SearchState.initial());

  search(args) async {
    try {
      emit(SearchState.loading());
      var res = await searchSpaceUsecase(args);
      res.fold(
        (l) => emit(SearchState.error(error: l.error)),
        (r) => emit(SearchState.loaded(data: r)),
      );
    } catch (e) {
      emit(SearchState.error(error: e.toString()));
    }
  }
}
