import 'package:category_b/app/cubit/notifications/notifications_cubit.dart';
import 'package:category_b/app/cubit/theme/theme_cubit.dart';
import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/services/anekdot/anekdot_service_interface.dart';
import 'package:category_b/core/services/notifications/notification_service_interface.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:category_b/repositories/settings/settings_repository_interface.dart';
import 'package:category_b/router/router.dart';
import 'package:category_b/ui/theme/theme.dart';
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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GenerateAnekdotBloc(
            service: getIt<AnekdotServiceInterface>(),
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
