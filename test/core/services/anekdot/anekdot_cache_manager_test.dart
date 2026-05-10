import 'package:anekdots_b/core/services/anekdot/anekdot_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnekdotCacheManager.shouldUpdate', () {
    test('returns true when Hive cache is below minimum', () {
      expect(
        AnekdotCacheManager.shouldUpdate(
          currentHiveCount: 0,
          lastUpdateTime: DateTime.now(),
        ),
        isTrue,
      );
    });

    test('returns true when last update is null', () {
      expect(
        AnekdotCacheManager.shouldUpdate(
          currentHiveCount: 150,
          lastUpdateTime: null,
        ),
        isTrue,
      );
    });

    test('returns false when cache is fresh and large enough', () {
      final lastUpdate = DateTime.now().subtract(const Duration(minutes: 10));

      expect(
        AnekdotCacheManager.shouldUpdate(
          currentHiveCount: 150,
          lastUpdateTime: lastUpdate,
        ),
        isFalse,
      );
    });

    test('returns true when cache is stale', () {
      final lastUpdate = DateTime.now().subtract(const Duration(minutes: 31));

      expect(
        AnekdotCacheManager.shouldUpdate(
          currentHiveCount: 150,
          lastUpdateTime: lastUpdate,
        ),
        isTrue,
      );
    });

    test('returns true when last update is in the future', () {
      final lastUpdate = DateTime.now().add(const Duration(minutes: 5));

      expect(
        AnekdotCacheManager.shouldUpdate(
          currentHiveCount: 150,
          lastUpdateTime: lastUpdate,
        ),
        isTrue,
      );
    });
  });
}
