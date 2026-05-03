import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:uuid/uuid.dart';

class Anekdot {
  const Anekdot({required this.anekdotText, this.isError = false});

  final String anekdotText;
  final bool isError;

  FavoriteAnekdots toFavorite() => FavoriteAnekdots(
    id: const Uuid().v4(),
    createdAt: DateTime.now(),
    anekdotText: anekdotText,
  );
}
