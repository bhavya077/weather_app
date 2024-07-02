part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class Homeloading extends HomeState {}

final class Homefailure extends HomeState {}

final class HomeSuccess extends HomeState {
  final Weather weather;

  const HomeSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}

final class WeatherFetchSuccessState extends HomeState {
  final Weather weather;
  final String city;
  final String state;
  final String country;

  const WeatherFetchSuccessState(
      {required this.weather,
      required this.city,
      required this.state,
      required this.country});

  @override
  List<Object> get props => [weather];
}
