// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchCurrentWeather extends HomeEvent{
}


class FetchCityWeather extends HomeEvent {
  final String city;
  final String state;
  final String country;

  const FetchCityWeather({
    required this.city,
    required this.state,
    required this.country,
  });
}
