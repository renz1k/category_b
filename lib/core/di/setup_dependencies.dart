// ignore_for_file: cascade_invocations, avoid_redundant_argument_values, document_ignores, prefer_const_constructors
// These diagnostics are suppressed for DI wiring and build-mode Talker setup.

import 'package:anekdots_b/core/di/app_initializer.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_firebase_sync_service.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_loader_service.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_loader_service_interface.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_pool_service.dart';
import 'package:anekdots_b/core/services/anekdot/firebase_anekdot_service.dart';
import 'package:anekdots_b/core/services/hive_service.dart';
import 'package:anekdots_b/core/services/notifications/notification_service.dart';
import 'package:anekdots_b/core/services/notifications/notification_service_interface.dart';
import 'package:anekdots_b/repositories/favorites/favorites_repository.dart';
import 'package:anekdots_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:anekdots_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:anekdots_b/repositories/local_anekdots/hive_local_anekdots_repository.dart';
import 'package:anekdots_b/repositories/local_anekdots/local_anekdots_repository.dart';
import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';
import 'package:anekdots_b/repositories/settings/settings_repository.dart';
import 'package:anekdots_b/repositories/settings/settings_repository_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Initialize Talker with production-safe settings
  final talker = Talker(
    settings: TalkerSettings(
      enabled: !bool.fromEnvironment('dart.vm.product'),
    ),
    logger: TalkerLogger(
      settings: TalkerLoggerSettings(enableColors: false),
    ),
  );
  getIt.registerSingleton<Talker>(talker);

  getIt.registerLazySingleton<HiveService>(HiveService.new);
  await getIt<HiveService>().init();

  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);
  getIt.registerLazySingleton<SettingsRepositoryInterface>(
    () => SettingsRepository(preferences: getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<NotificationServiceInterface>(
    NotificationService.new,
  );
  getIt.registerLazySingleton<AppInitializer>(
    () => AppInitializer(
      notificationService: getIt<NotificationServiceInterface>(),
      settingsRepository: getIt<SettingsRepositoryInterface>(),
    ),
  );

  // Favorites хранилище
  getIt.registerSingleton<Box<FavoriteAnekdots>>(
    await getIt<HiveService>().getFavoritesBox(),
  );
  getIt.registerLazySingleton<FavoritesRepositoryInterface>(
    () => FavoritesRepository(favoriteBox: getIt<Box<FavoriteAnekdots>>()),
  );

  // Local anekdots хранилище
  final localAnekdotsBox = await getIt<HiveService>().getLocalAnekdotsBox();
  final metadataBox = await getIt<HiveService>().getMetadataBox();

  getIt.registerSingleton<Box<LocalAnekdot>>(localAnekdotsBox);
  getIt.registerSingleton<Box<dynamic>>(metadataBox);

  getIt.registerLazySingleton<LocalAnekdotsRepository>(
    () => HiveLocalAnekdotsRepository(
      getIt<Box<LocalAnekdot>>(),
      getIt<Box<dynamic>>(),
    ),
  );

  // Firebase services
  getIt.registerLazySingleton<FirebaseAnekdotService>(
    FirebaseAnekdotService.new,
  );

  getIt.registerLazySingleton<AnekdotPoolService>(
    () => AnekdotPoolService(localRepo: getIt<LocalAnekdotsRepository>()),
  );

  getIt.registerLazySingleton<AnekdotFirebaseSyncService>(
    () => AnekdotFirebaseSyncService(
      firebaseService: getIt<FirebaseAnekdotService>(),
      localRepo: getIt<LocalAnekdotsRepository>(),
    ),
  );

  // Main loader service (координирует все источники)
  getIt.registerLazySingleton<AnekdotLoaderServiceInterface>(
    () => AnekdotLoaderService(
      poolService: getIt<AnekdotPoolService>(),
      syncService: getIt<AnekdotFirebaseSyncService>(),
    ),
  );
}
