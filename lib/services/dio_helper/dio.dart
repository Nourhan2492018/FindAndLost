import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static late String token;
  static init() {
    String baseUrl = 'https://fcm.googleapis.com/fcm/send';
    dio = Dio(BaseOptions(baseUrl: baseUrl, receiveDataWhenStatusError: true,
        //responseType: ResponseType.plain,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAXdyLw4A:APA91bHZiCCcOHghQaFNdV_g1CWiHs5IWC4UTZ5i11zJbtOWv-MGT57bEjUsEY6B2ZxlHOwdRXCaPhiS4Gx7hZ5jJ7500vQCElUqClzKuXjzy6PUCeXEFkviC-c-SiTtd4rDPOShoY_k'
        }));
    print(dio.hashCode);
  }

  static Future<Response> postNotification({
    required String url,
    //Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAXdyLw4A:APA91bHZiCCcOHghQaFNdV_g1CWiHs5IWC4UTZ5i11zJbtOWv-MGT57bEjUsEY6B2ZxlHOwdRXCaPhiS4Gx7hZ5jJ7500vQCElUqClzKuXjzy6PUCeXEFkviC-c-SiTtd4rDPOShoY_k'
    };
    print(data.toString());
    return dio.post(url, data: data);
  }

  static Future<Response> putData({
    required String url,
    //Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAXdyLw4A:APA91bHZiCCcOHghQaFNdV_g1CWiHs5IWC4UTZ5i11zJbtOWv-MGT57bEjUsEY6B2ZxlHOwdRXCaPhiS4Gx7hZ5jJ7500vQCElUqClzKuXjzy6PUCeXEFkviC-c-SiTtd4rDPOShoY_k'
    };
    return dio.post(url, data: data);
  }
}
