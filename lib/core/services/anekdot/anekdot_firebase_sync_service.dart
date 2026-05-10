import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_cache_manager.dart';
import 'package:anekdots_b/core/services/anekdot/firebase_anekdot_service.dart';
import 'package:anekdots_b/repositories/local_anekdots/local_anekdots_repository.dart';
import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';
import 'package:talker/talker.dart';

class AnekdotFirebaseSyncService {
  AnekdotFirebaseSyncService({
    required this.firebaseService,
    required this.localRepo,
  });

  final FirebaseAnekdotService firebaseService;
  final LocalAnekdotsRepository localRepo;

  Future<bool> syncIfNeeded() async {
    try {
      final count = await localRepo.getTotal();
      final lastUpdate = await localRepo.getLastUpdateTime();
      final now = DateTime.now();

      final shouldUpdate = AnekdotCacheManager.shouldUpdate(
        currentHiveCount: count,
        lastUpdateTime: lastUpdate,
        now: now,
      );
      final age = lastUpdate == null ? null : now.difference(lastUpdate);

      getIt<Talker>().info(
        'Cache check: now=$now, hive=$count, lastUpdate=$lastUpdate, '
        'age=${age?.inMinutes}m, shouldUpdate=$shouldUpdate',
      );

      if (!shouldUpdate) {
        return false;
      }

      final fbAnekdots = await firebaseService.getRandomAnekdots();
      if (fbAnekdots.isEmpty) {
        return false;
      }

      final localAnekdots = fbAnekdots
          .where((anekdot) => anekdot.id != null)
          .map(
            (anekdot) => LocalAnekdot(
              id: anekdot.id!,
              text: anekdot.anekdotText,
            ),
          )
          .toList();

      if (localAnekdots.isEmpty) {
        return false;
      }

      await localRepo.addBatchFromFirebase(localAnekdots);
      await localRepo.setLastUpdateTime(DateTime.now());

      getIt<Talker>().info(
        'Updated local cache: ${localAnekdots.length} new anekdots',
      );
      return true;
    } on Exception catch (e) {
      getIt<Talker>().error('Firebase update error: $e');
      return false;
    }
  }
}
