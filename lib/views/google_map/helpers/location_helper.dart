import 'package:geolocator/geolocator.dart';

class LocationHelper{
  static Future<Position> getCurrentLocation() async {
    bool isServeiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isServeiceEnabled)
      await Geolocator.requestPermission();

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


}