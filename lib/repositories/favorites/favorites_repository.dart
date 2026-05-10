import 'package:anekdots_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:anekdots_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class FavoritesRepository implements FavoritesRepositoryInterface {
  FavoritesRepository({required Box<FavoriteAnekdots> favoriteBox})
    : _favoriteBox = favoriteBox;

  final Box<FavoriteAnekdots> _favoriteBox;

  @override
  Future<List<FavoriteAnekdots>> getAnekdotsList() async {
    return _favoriteBox.values.toList();
  }

  @override
  Future<List<FavoriteAnekdots>> createOrDeleteAnekdots(
    FavoriteAnekdots anekdot,
  ) async {
    final matches = _favoriteBox.values
        .where((item) => item.anekdotText == anekdot.anekdotText)
        .toList();

    if (matches.isNotEmpty) {
      for (final match in matches) {
        await _favoriteBox.delete(match.id);
      }
      return _favoriteBox.values.toList();
    }

    await _favoriteBox.put(anekdot.id, anekdot);
    return _favoriteBox.values.toList();
  }

  @override
  Future<void> addOrUpdateAnekdot(FavoriteAnekdots anekdot) async {
    await _favoriteBox.put(anekdot.id, anekdot);
  }

  @override
  Future<void> clear() async {
    await _favoriteBox.clear();
  }
}
