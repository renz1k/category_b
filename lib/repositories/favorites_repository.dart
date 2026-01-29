import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:category_b/repositories/favorites_repository_interface.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class FavoritesRepository implements FavoritesRepositoryInterface {
  final favoriteBox = getIt<Box<FavoriteAnekdots>>();

  @override
  Future<List<FavoriteAnekdots>> getAnekdotsList() async {
    return favoriteBox.values.toList();
  }

  @override
  Future<void> createOrDeleteAnekdots(FavoriteAnekdots anekdot) async {
    final matches = favoriteBox.values
        .where((item) => item.anekdotText == anekdot.anekdotText)
        .toList();

    if (matches.isNotEmpty) {
      for (var match in matches) {
        await favoriteBox.delete(match.id);
      }
      return;
    }

    await favoriteBox.put(anekdot.id, anekdot);
  }

  @override
  Future<void> clear() async {
    await favoriteBox.clear();
  }
}
