import 'package:anekdots_b/core/constants/app_constants.dart';

class AnekdotCacheManager {
  static const int maxCached = AppConstants.anekdotMaxCached;
  static const int fetchSize = AppConstants.anekdotFetchSize;
  static const int minBeforeFetch = AppConstants.anekdotMinBeforeFetch;
  static const Duration updateInterval = AppConstants.anekdotUpdateInterval;

  // Проверить нужно ли обновлять Firebase
  static bool shouldUpdate({
    required int currentHiveCount,
    required DateTime? lastUpdateTime,
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();

    // Условие 1: Hive < 100
    if (currentHiveCount < minBeforeFetch) {
      return true;
    }

    // Условие 2: прошло > 30 минут с последнего обновления
    if (lastUpdateTime == null) {
      return true;
    }

    final timeSinceUpdate = currentTime.difference(lastUpdateTime);
    // Если время устройства «открутилось» назад и timestamp оказался в будущем,
    // принудительно обновляем кэш, чтобы не зависнуть без синка.
    if (timeSinceUpdate.isNegative) {
      return true;
    }

    return timeSinceUpdate > updateInterval;
  }
}
