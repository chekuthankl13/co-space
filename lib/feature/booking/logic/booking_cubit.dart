import 'package:bloc/bloc.dart';
import 'package:co_workspace/core/usecase/usecase.dart';
import 'package:co_workspace/feature/booking/domain/entity/booking_entity.dart';
import 'package:co_workspace/feature/booking/domain/usecase/delete_booking_usecase.dart';
import 'package:co_workspace/feature/booking/domain/usecase/load_booking_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_state.dart';
part 'booking_cubit.freezed.dart';

class BookingCubit extends Cubit<BookingState> {
  final LoadBookingUsecase loadBookingUsecase;
  final DeleteBookingUsecase deleteBookingUsecase;
  BookingCubit(this.loadBookingUsecase, this.deleteBookingUsecase)
    : super(BookingState.initial());

  loadBooking() async {
    try {
      emit(BookingState.loading());
      var res = await loadBookingUsecase(NoParam());
      res.fold(
        (l) => emit(BookingState.error(error: l.error)),
        (r) => emit(BookingState.loaded(bookings: r)),
      );
    } catch (e) {
      emit(BookingState.error(error: e.toString()));
    }
  }

  Future<Map<String, dynamic>> delete(id) async {
    try {
      var res = await deleteBookingUsecase(id);
      return res.fold(
        (l) => {"status": "!ok", "error": l.error},
        (r) => {"status": "ok"},
      );
    } catch (e) {
      return {"status": "!ok", "error": e.toString()};
    }
  }
}
