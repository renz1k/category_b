import 'dart:developer';

import 'package:category_b/core/constants/app_constants.dart';
import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/services/anekdot/anekdot_service_interface.dart';
import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/core/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;

class AnekdotService implements AnekdotServiceInterface {
  final Dio dio = getIt<DioService>().dio;

  @override
  Future<Anekdot> getRandomAnekdot({
    int maxRetries = AppConstants.anekdotMaxRetries,
  }) async {
    for (var attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final response = await dio.get<String>(
          '/random',
          options: Options(
            responseType: ResponseType.plain,
            followRedirects: true,
            receiveTimeout: AppConstants.anekdotRequestReceiveTimeout,
            sendTimeout: AppConstants.anekdotRequestSendTimeout,
          ),
        );

        final document = html_parser.parse(response.data ?? '');
        final article = document.querySelector('article');

        if (article != null) {
          final p = article.querySelector('p');
          final text = p?.text.trim().replaceAll(RegExp(r'<br\s*/?>'), '\n');
          if (text != null && text.length > AppConstants.anekdotMinimumLength) {
            return Anekdot(anekdotText: text);
          }
        }

        if (attempt < maxRetries) {
          await Future<void>.delayed(AppConstants.anekdotRetryDelay);
          continue;
        }

        return const Anekdot(
          anekdotText: 'Сервер занят, попробуйте через минуту',
        );
      } on Object catch (e) {
        log('Попытка $attempt/$maxRetries: $e');

        if (attempt < maxRetries) {
          await Future<void>.delayed(AppConstants.anekdotRetryDelay);
          continue;
        }

        return const Anekdot(anekdotText: 'Проверьте интернет-соединение');
      }
    }

    return const Anekdot(anekdotText: 'Неожиданная ошибка');
  }
}
