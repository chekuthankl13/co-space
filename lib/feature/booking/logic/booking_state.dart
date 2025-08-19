part of 'booking_cubit.dart';

@freezed
sealed class BookingState with _$BookingState {
  const BookingState._();
  const factory BookingState.initial() = Initial;
  const factory BookingState.loading() = Loading;
  const factory BookingState.error({required String error}) = Error;
  const factory BookingState.loaded({required List<BookingEntity> bookings}) = Loaded;

}
