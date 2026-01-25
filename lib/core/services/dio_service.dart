import 'package:dio/dio.dart';

class DioService {
  static DioService? _instance;
  factory DioService() => _instance ??= DioService._internal();

  DioService._internal();

  late final Dio dio;

  void init({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 15),
        sendTimeout: Duration(seconds: 15),
        followRedirects: true,
        validateStatus: (status) => status != null && status < 500,
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept': 'text/html,application/xhtml+xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'ru-RU,ru;q=0.9,en;q=0.8',
        },
      ),
    );
  }
}
