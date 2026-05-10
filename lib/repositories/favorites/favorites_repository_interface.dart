import 'package:anekdots_b/repositories/favorites/model/favorite_anekdots.dart';

abstract interface class FavoritesRepositoryInterface {
  Future<List<FavoriteAnekdots>> getAnekdotsList();
  Future<List<FavoriteAnekdots>> createOrDeleteAnekdots(
    FavoriteAnekdots anekdot,
  );
  Future<void> addOrUpdateAnekdot(FavoriteAnekdots anekdot);
  Future<void> clear();
}
