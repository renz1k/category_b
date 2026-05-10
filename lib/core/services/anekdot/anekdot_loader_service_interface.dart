import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';

abstract interface class AnekdotLoaderServiceInterface {
  Future<Anekdot> getRandomAnekdot();

  Future<void> syncFirebaseIfNeeded();
}
