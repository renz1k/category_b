import 'package:category_b/core/services/anekdot/models/anekdots.dart';

abstract interface class AnekdotServiceInterface {
  Future<Anekdot> getRandomAnekdot({int maxRetries = 3});
}
