import 'package:anekdots_b/hive/hive_registrar.g.dart';
import 'package:anekdots_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveService {
  HiveService();

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
  }

  Future<Box<FavoriteAnekdots>> getFavoritesBox() async =>
      Hive.openBox<FavoriteAnekdots>('favorite_anekdots');

  Future<Box<LocalAnekdot>> getLocalAnekdotsBox() async =>
      Hive.openBox<LocalAnekdot>('local_anekdots');

  Future<Box<dynamic>> getMetadataBox() async =>
      Hive.openBox<dynamic>('metadata');
}
