import 'package:category_b/core/services/anekdot_service.dart';
import 'package:category_b/core/services/anekdot_servise_interface.dart';
import 'package:category_b/core/services/dio_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies({required String baseUrl}) {
  getIt.registerLazySingleton<DioService>(() => DioService());
  getIt<DioService>().init(baseUrl: baseUrl);

  getIt.registerLazySingleton<AnekdotServiceInterface>(() => AnekdotService());
}
