import 'package:category_b/hive/hive_registrar.g.dart';
import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveService {
  static HiveService? _instance;
  factory HiveService() => _instance ??= HiveService._();

  HiveService._();

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
  }

  Future<Box<FavoriteAnekdots>> getFavoritesBox() async =>
      await Hive.openBox<FavoriteAnekdots>('favorite_anekdots');
}
