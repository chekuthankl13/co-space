part of 'detail_cubit.dart';

@freezed
sealed class DetailState with _$DetailState {
  const DetailState._();
  const factory DetailState.initial() = Initial;
  const factory DetailState.loading() = Loading;
  const factory DetailState.error({required String error}) = Error;
  const factory DetailState.detail({required SpaceEntity detail}) = Detail;

}
