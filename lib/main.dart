import 'package:category_b/bloc/theme/theme_cubit.dart';
import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/services/anekdot/anekdot_service_interface.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:category_b/router/router.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await setupDependencies(baseUrl: dotenv.env['BASE_URL']!);

  runApp(const CategoryBApp());
}

class CategoryBApp extends StatefulWidget {
  const CategoryBApp({super.key});

  @override
  State<CategoryBApp> createState() => _CategoryBAppState();
}

class _CategoryBAppState extends State<CategoryBApp> {
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
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'categotyB',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
