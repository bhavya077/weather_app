// ignore_for_file: file_names

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home.dart/bloc/home_bloc.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  void initState() {
    homeBloc.add(FetchCurrentWeather());
    super.initState();
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/images/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/images/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/images/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/images/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/images/5.png');
      case == 800:
        return Image.asset('assets/images/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/images/7.png');
      default:
        return Image.asset('assets/images/7.png');
    }
  }

  String? countryValue;
  String? stateValue;
  String? cityValue;

  HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case Homeloading:
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Hi Welcome",
                    style: GoogleFonts.aBeeZee(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset(
                      'assets/images/7.png',
                      scale: 10,
                    ),
                  )
                ],
                backgroundColor: const Color.fromARGB(255, 19, 33, 63),
              ),
              backgroundColor: const Color.fromARGB(255, 19, 33, 63),
              body: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );

          case HomeSuccess:
            final successState = state as HomeSuccess;
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 19, 33, 63),
              appBar: AppBar(
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Hi Welcome",
                    style: GoogleFonts.aBeeZee(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset(
                      'assets/images/7.png',
                      scale: 10,
                    ),
                  )
                ],
                backgroundColor: const Color.fromARGB(255, 19, 33, 63),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CSCPicker(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                          
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    cityValue!=null?
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                         
                          homeBloc.add(FetchCityWeather(
                              city: cityValue!,
                              state: stateValue!,
                              country: countryValue!));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 32, 118, 188)),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'CHECK WEATHER',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ): Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                         
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'CHECK WEATHER',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍 ${successState.weather.areaName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          Center(
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: getWeatherIcon(
                                  successState.weather.weatherConditionCode!),
                            ),
                          ),
                          Center(
                            child: Text(
                                '${successState.weather.temperature!.celsius!.round()}°C',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                                successState.weather.weatherMain!.toUpperCase(),
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          const SizedBox(height: 6),
                          Center(
                            child: Text(
                                DateFormat('EEEE dd •')
                                    .add_jm()
                                    .format(successState.weather.date!),
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                )),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        'assets/images/11.png',
                                        scale: 10,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Sunrise',
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            )),
                                        const SizedBox(height: 3),
                                        Text(
                                            DateFormat().add_jm().format(
                                                successState.weather.sunrise!),
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/12.png',
                                      scale: 10,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Sunset',
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            )),
                                        const SizedBox(height: 3),
                                        Text(
                                            DateFormat().add_jm().format(
                                                successState.weather.sunset!),
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                    'assets/images/13.png',
                                    scale: 10,
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Temp Max',
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          )),
                                      const SizedBox(height: 3),
                                      Text(
                                          "${successState.weather.tempMax!.celsius!.round()} °C",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ],
                                  )
                                ]),
                                Row(children: [
                                  Image.asset(
                                    'assets/images/14.png',
                                    scale: 10,
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Temp Min',
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          )),
                                      const SizedBox(height: 3),
                                      Text(
                                          "${successState.weather.tempMin!.celsius!.round()} °C",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ],
                                  )
                                ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

          case WeatherFetchSuccessState:
            final successState = state as WeatherFetchSuccessState;

            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 19, 33, 63),
              appBar: AppBar(
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Hi Welcome",
                    style: GoogleFonts.aBeeZee(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset(
                      'assets/images/7.png',
                      scale: 10,
                    ),
                  )
                ],
                backgroundColor: const Color.fromARGB(255, 19, 33, 63),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CSCPicker(
                        currentCountry: successState.country,
                        currentState: successState.state,
                        currentCity: successState.city,
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                         
                          homeBloc.add(FetchCityWeather(
                              city: cityValue ?? successState.city,
                              state: stateValue ?? successState.state,
                              country: countryValue ?? successState.country));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 32, 118, 188)),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'CHECK WEATHER',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍 ${successState.weather.areaName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          Center(
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: getWeatherIcon(
                                  successState.weather.weatherConditionCode!),
                            ),
                          ),
                          Center(
                            child: Text(
                                '${successState.weather.temperature!.celsius!.round()}°C',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                                successState.weather.weatherMain!.toUpperCase(),
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          const SizedBox(height: 6),
                          Center(
                            child: Text(
                                DateFormat('EEEE dd •')
                                    .add_jm()
                                    .format(successState.weather.date!),
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                )),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        'assets/images/11.png',
                                        scale: 10,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Sunrise',
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            )),
                                        const SizedBox(height: 3),
                                        Text(
                                            DateFormat().add_jm().format(
                                                successState.weather.sunrise!),
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/12.png',
                                      scale: 10,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Sunset',
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            )),
                                        const SizedBox(height: 3),
                                        Text(
                                            DateFormat().add_jm().format(
                                                successState.weather.sunset!),
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                    'assets/images/13.png',
                                    scale: 10,
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Temp Max',
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          )),
                                      const SizedBox(height: 3),
                                      Text(
                                          "${successState.weather.tempMax!.celsius!.round()} °C",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ],
                                  )
                                ]),
                                Row(children: [
                                  Image.asset(
                                    'assets/images/14.png',
                                    scale: 10,
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Temp Min',
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          )),
                                      const SizedBox(height: 3),
                                      Text(
                                          "${successState.weather.tempMin!.celsius!.round()} °C",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ],
                                  )
                                ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          case Homefailure:
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 19, 33, 63),
              appBar: AppBar(
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Hi Welcome",
                    style: GoogleFonts.aBeeZee(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset(
                      'assets/images/7.png',
                      scale: 10,
                    ),
                  )
                ],
                backgroundColor: const Color.fromARGB(255, 19, 33, 63),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CSCPicker(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    cityValue!=null?
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          homeBloc.add(FetchCityWeather(
                              city: cityValue!,
                              state: stateValue!,
                              country: countryValue!));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 32, 118, 188)),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'CHECK WEATHER',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ):Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                         
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration:const  BoxDecoration(
                              color: Colors.grey),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'CHECK WEATHER',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
