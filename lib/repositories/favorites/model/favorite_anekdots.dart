import 'package:category_b/core/services/anekdot/models/anekdots.dart';

class FavoriteAnekdots {
  FavoriteAnekdots({
    required this.id,
    required this.createdAt,
    required this.anekdotText,
  });

  final String id;
  final String anekdotText;
  final DateTime createdAt;

  Anekdot toAnekdot() => Anekdot(anekdotText: anekdotText);
}
