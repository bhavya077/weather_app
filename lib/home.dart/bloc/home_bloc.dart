import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/mydata.dart';
import 'package:weather_app/home.dart/screens/currentLocation.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchCityWeather>(fetchCityWeather);
    on<FetchCurrentWeather>(fetchCurrentWeather);
  }

  FutureOr<void> fetchCityWeather(
      FetchCityWeather event, Emitter<HomeState> emit) async {
    emit(Homeloading());
    try {
      WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);

      Weather weather = await wf.currentWeatherByCityName(event.city);

      emit(WeatherFetchSuccessState(
          weather: weather,
          city: event.city,
          state: event.state,
          country: event.country));
    } catch (e) {
      emit(Homefailure());
    }
  }

  FutureOr<void> fetchCurrentWeather(
      FetchCurrentWeather event, Emitter<HomeState> emit) async {
    emit(Homeloading());

    try {
      final Position message = await CurrentLocation.getLongitudeAndLatitude();

      WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
      Weather weather = await wf.currentWeatherByLocation(
          message.latitude, message.longitude);

      emit(HomeSuccess(weather));
    } catch (e) {
      if (e is Exception) {
        emit(Homefailure());
      } else {
        emit(Homefailure());
      }
    }
  }
}
