import 'package:bloc/bloc.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/common/models/space_entity_model.dart';
import 'package:co_workspace/feature/details/domain/usecase/book_space_usecase.dart';
import 'package:co_workspace/feature/details/domain/usecase/get_space_detail_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_state.dart';
part 'detail_cubit.freezed.dart';

class DetailCubit extends Cubit<DetailState> {
  final GetSpaceDetailUsecase getSpaceDetailUsecase;
  final BookSpaceUsecase bookSpaceUsecase;
  DetailCubit(this.getSpaceDetailUsecase, this.bookSpaceUsecase)
    : super(DetailState.initial());

  getDetail(id) async {
    try {
      emit(DetailState.loading());
      var res = await getSpaceDetailUsecase(id);
      res.fold(
        (l) => emit(DetailState.error(error: l.error)),
        (r) => emit(DetailState.detail(detail: r)),
      );
    } catch (e) {
      emit(DetailState.error(error: e.toString()));
    }
  }

  Future<Map<String, dynamic>> book({
    required SpaceEntity detail,
    name,
    sdate,
    time,
    edate,
    noSeats,
  }) async {
    try {
      Map<String,dynamic> data = {
        "space": SpaceEntityModel.fromEntity(detail).toJson(),
        "name": name,
        "start_date": sdate,
        "end_date": edate,
        "time": time,
        "no_seats": noSeats,
      };

      var res = await bookSpaceUsecase(data);
    return  res.fold(
        (l) => {"status": "!ok", "error": l.error},
        (r) => {"status": "ok"},
      );
    } catch (e) {
      return {"status": "!ok", "error": e.toString()};
    }
  }
}
