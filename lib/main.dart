import 'package:anekdots_b/app/anekdots_b_app.dart';
import 'package:anekdots_b/core/di/app_initializer.dart';
import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupDependencies();

  await getIt<AppInitializer>().init();

  getIt<Talker>().info('App fully initialized');

  runApp(const AnekdotsBApp());
}
