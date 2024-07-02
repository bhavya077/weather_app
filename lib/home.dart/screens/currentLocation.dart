// ignore_for_file: file_names, use_rethrow_when_possible

import 'package:geolocator/geolocator.dart';

class CurrentLocation {
  static Position? position;

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<Position> getLongitudeAndLatitude() async {
    try {
      position = await _determinePosition();
      return position!;
    } catch (e) {
      throw e;
    }
  }
}
