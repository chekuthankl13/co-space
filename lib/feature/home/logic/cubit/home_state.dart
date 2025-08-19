part of 'home_cubit.dart';

@freezed
sealed class HomeState with _$HomeState {
  const HomeState._();
  const factory HomeState.initial() = Initial;
  const factory HomeState.loading() = Loading;
  const factory HomeState.error({required String error}) = Error;
  const factory HomeState.loaded({required List<SpaceEntity> spaces}) = Loaded;

}
