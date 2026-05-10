import 'package:anekdots_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:uuid/uuid.dart';

class Anekdot {
  const Anekdot({
    required this.anekdotText,
    this.id,
    this.source = 'unknown',
    this.isError = false,
  });

  final String? id;
  final String anekdotText;
  final String source;
  final bool isError;

  FavoriteAnekdots toFavorite() => FavoriteAnekdots(
    id: const Uuid().v4(),
    createdAt: DateTime.now(),
    anekdotText: anekdotText,
  );
}
