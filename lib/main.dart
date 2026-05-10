import 'dart:ui';

import 'package:anekdots_b/app/anekdots_b_app.dart';
import 'package:anekdots_b/core/di/app_initializer.dart';
import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await setupDependencies();

  await getIt<AppInitializer>().init();

  getIt<Talker>().info('App fully initialized');

  runApp(const AnekdotsBApp());
}
