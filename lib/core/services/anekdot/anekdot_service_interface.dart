import 'package:category_b/core/constants/app_constants.dart';
import 'package:category_b/core/services/anekdot/models/anekdots.dart';

abstract interface class AnekdotServiceInterface {
  Future<Anekdot> getRandomAnekdot({
    int maxRetries = AppConstants.anekdotMaxRetries,
  });
}
