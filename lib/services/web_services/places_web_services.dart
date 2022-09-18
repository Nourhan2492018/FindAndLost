import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/settings.dart';


class PlacesWebServices {
  late Dio dio;

  PlacesWebServices() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> fetchSuggestions(
      String place, String sessionToken, LatLng orgin) async {
    try {
      Response response = await dio.get(suggestationBaseUrl, queryParameters: {
        'input': place,
        'orgin': orgin,
        'types': '(cities)',
        'components': 'country:eg',
        'sessiontoken': sessionToken,
        'key': googleAPIKey,
      });
      return response.data['predictions'];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(placeLocationBaseUrl, queryParameters: {
        'place_id': placeId,
        'fields': 'geometry',
        'sessiontoken': sessionToken,
        'key': googleAPIKey,
      });
      return response.data;
    } catch (e) {
      print(e);
      return Future.error(
          "Place location error: ", StackTrace.fromString('this is its trace'));
    }
  }
}
