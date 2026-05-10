import 'package:anekdots_b/app/cubit/notifications/notifications_cubit.dart';
import 'package:anekdots_b/app/cubit/theme/theme_cubit.dart';
import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_loader_service_interface.dart';
import 'package:anekdots_b/core/services/notifications/notification_service_interface.dart';
import 'package:anekdots_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:anekdots_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:anekdots_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:anekdots_b/repositories/settings/settings_repository_interface.dart';
import 'package:anekdots_b/router/router.dart';
import 'package:anekdots_b/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnekdotsBApp extends StatefulWidget {
  const AnekdotsBApp({super.key});

  @override
  State<AnekdotsBApp> createState() => _AnekdotsBAppState();
}

class _AnekdotsBAppState extends State<AnekdotsBApp> {
  final _router = AppRouter();

  @override
  void initState() {
    super.initState();

    _startFirebaseSync();
  }

  Future<void> _startFirebaseSync() async {
    try {
      await getIt<AnekdotLoaderServiceInterface>().syncFirebaseIfNeeded();
    } on Exception {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GenerateAnekdotBloc(
            loaderService: getIt<AnekdotLoaderServiceInterface>(),
            favoritesRepository: getIt<FavoritesRepositoryInterface>(),
          ),
        ),
        BlocProvider(
          create: (context) => FavoriteAnekdotsBloc(
            favoritesRepository: getIt<FavoritesRepositoryInterface>(),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(
            settingsRepository: getIt<SettingsRepositoryInterface>(),
          ),
        ),
        BlocProvider(
          create: (context) => NotificationsCubit(
            notificationService: getIt<NotificationServiceInterface>(),
            settingsRepository: getIt<SettingsRepositoryInterface>(),
          ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'anekdotsB',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
