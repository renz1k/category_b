import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';

abstract interface class FavoritesRepositoryInterface {
  Future<List<FavoriteAnekdots>> getAnekdotsList();
  Future<void> createOrDeleteAnekdots(FavoriteAnekdots anekdot);
  Future<void> clear();
}
