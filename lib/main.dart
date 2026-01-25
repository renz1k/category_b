import 'package:category_b/core/services/anekdot_service.dart';
import 'package:category_b/core/services/dio_service.dart';
import 'package:category_b/router/router.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  setupDio(baseUrl: dotenv.env['BASE_URL']!);

  final service = AnekdotService();

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
    return MaterialApp.router(
      title: 'categotyB',
      theme: themeData,
      routerConfig: _router.config(),
    );
  }
}
