import 'package:anekdots_b/core/services/anekdot/anekdot_firebase_sync_service.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_loader_service_interface.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_pool_service.dart';
import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';

class AnekdotLoaderService implements AnekdotLoaderServiceInterface {
  AnekdotLoaderService({
    required this.poolService,
    required this.syncService,
  });

  final AnekdotPoolService poolService;
  final AnekdotFirebaseSyncService syncService;

  @override
  Future<Anekdot> getRandomAnekdot() async {
    return poolService.getRandomAnekdot();
  }

  @override
  Future<void> syncFirebaseIfNeeded() async {
    final updated = await syncService.syncIfNeeded();
    if (updated) {
      poolService.invalidateLocalCache();
    }
  }
}
