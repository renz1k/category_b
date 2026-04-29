import 'package:category_b/core/di/app_initializer.dart';
import 'package:category_b/core/services/anekdot/anekdot_service.dart';
import 'package:category_b/core/services/anekdot/anekdot_service_interface.dart';
import 'package:category_b/core/services/dio_service.dart';
import 'package:category_b/core/services/hive_service.dart';
import 'package:category_b/core/services/notifications/notification_service.dart';
import 'package:category_b/repositories/favorites/favorites_repository.dart';
import 'package:category_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:category_b/repositories/settings/settings_repository.dart';
import 'package:category_b/repositories/settings/settings_repository_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies({required String baseUrl}) async {
  getIt.registerLazySingleton<DioService>(DioService.new);
  getIt<DioService>().init(baseUrl: baseUrl);

  getIt
    ..registerLazySingleton<AnekdotServiceInterface>(AnekdotService.new)
    ..registerLazySingleton<HiveService>(HiveService.new);
  await getIt<HiveService>().init();

  final sharedPrefs = await SharedPreferences.getInstance();
  getIt
    ..registerSingleton<SharedPreferences>(sharedPrefs)
    ..registerLazySingleton<SettingsRepositoryInterface>(
      () => SettingsRepository(preferences: getIt<SharedPreferences>()),
    )
    ..registerLazySingleton<NotificationService>(NotificationService.new)
    ..registerLazySingleton<AppInitializer>(
      () => AppInitializer(
        notificationService: getIt<NotificationService>(),
        settingsRepository: getIt<SettingsRepositoryInterface>(),
      ),
    )
    ..registerSingleton<Box<FavoriteAnekdots>>(
      await getIt<HiveService>().getFavoritesBox(),
    )
    ..registerLazySingleton<FavoritesRepositoryInterface>(
      () => FavoritesRepository(favoriteBox: getIt<Box<FavoriteAnekdots>>()),
    );
}
