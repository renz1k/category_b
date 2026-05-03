import 'dart:developer';

import 'package:category_b/app/anekdots_b_app.dart';
import 'package:category_b/core/di/app_initializer.dart';
import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupDependencies(baseUrl: dotenv.env['BASE_URL']!);

  await getIt<AppInitializer>().init();

  log('App fully initialized');

  runApp(const AnekdotsBApp());
}
