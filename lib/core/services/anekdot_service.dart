import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;

class AnekdotService {
  final Dio dio = getIt<DioService>().dio;

  Future<String> getRandomAnekdot({int maxRetries = 3}) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final response = await dio.get<String>(
          '/random',
          options: Options(
            responseType: ResponseType.plain,
            followRedirects: true,
            receiveTimeout: Duration(seconds: 20),
          ),
        );

        final document = html_parser.parse(response.data ?? '');
        final article = document.querySelector('article');

        if (article != null) {
          final p = article.querySelector('p');
          final text = p?.text.trim().replaceAll(RegExp(r'<br\s*/?>'), '\n');
          if (text != null && text.length > 10) {
            return text;
          }
        }

        if (attempt == maxRetries) {
          return 'Не удалось получить анекдот после $maxRetries попыток';
        }

        await Future.delayed(Duration(seconds: attempt * 2));
      } catch (e) {
        print('Попытка $attempt/3: $e');
        if (attempt == maxRetries) rethrow;
      }
    }
    throw Exception('Неизвестная ошибка');
  }
}
