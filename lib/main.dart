import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/router/router.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  setupDependencies(baseUrl: dotenv.env['BASE_URL']!);

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
    return BlocProvider(
      create: (context) => GenerateAnekdotBloc(),
      child: MaterialApp.router(
        title: 'categotyB',
        theme: themeData,
        routerConfig: _router.config(),
      ),
    );
  }
}
