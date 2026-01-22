import 'package:category_b/router/router.dart';
import 'package:flutter/material.dart';

void main() {
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
      routerConfig: _router.config(),
    );
  }
}
