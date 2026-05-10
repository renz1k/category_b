import 'dart:math';

import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_firebase_sync_service.dart';
import 'package:anekdots_b/core/services/anekdot/anekdot_pool_service.dart';
import 'package:anekdots_b/core/services/anekdot/firebase_anekdot_service.dart';
import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';
import 'package:anekdots_b/repositories/local_anekdots/local_anekdots_repository.dart';
import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';

class FixedRandom implements Random {
  FixedRandom(this.value);

  final int value;

  @override
  int nextInt(int max) => value % max;

  @override
  bool nextBool() => false;

  @override
  double nextDouble() => 0;
}

class FakeLocalAnekdotsRepository implements LocalAnekdotsRepository {
  FakeLocalAnekdotsRepository({List<LocalAnekdot>? initial})
    : _items = List<LocalAnekdot>.from(initial ?? const []);

  final List<LocalAnekdot> _items;
  DateTime? Function()? lastUpdateTimeProvider;
  int addBatchCalls = 0;
  int setLastUpdateCalls = 0;

  @override
  Future<List<LocalAnekdot>> getAll() async => List<LocalAnekdot>.from(_items);

  @override
  Future<void> addBatchFromFirebase(List<LocalAnekdot> batch) async {
    addBatchCalls += 1;
    for (final item in batch) {
      _items
        ..removeWhere((existing) => existing.id == item.id)
        ..add(item);
    }
  }

  @override
  Future<void> clear() async {
    _items.clear();
  }

  @override
  Future<int> getTotal() async => _items.length;

  @override
  Future<DateTime?> getLastUpdateTime() async => lastUpdateTimeProvider?.call();

  @override
  Future<void> setLastUpdateTime(DateTime time) async {
    setLastUpdateCalls += 1;
  }
}

class FakeFirebaseAnekdotService extends FirebaseAnekdotService {
  FakeFirebaseAnekdotService(this.result);

  final List<Anekdot> result;
  int calls = 0;

  @override
  Future<List<Anekdot>> getRandomAnekdots({int limit = 200}) async {
    calls += 1;
    return result;
  }
}

void main() {
  setUpAll(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(
      Talker(settings: TalkerSettings(enabled: false)),
    );
  });

  tearDownAll(() async {
    await getIt.reset();
  });

  group('AnekdotPoolService', () {
    test(
      'deduplicates by text and returns deterministic random item',
      () async {
        final repository = FakeLocalAnekdotsRepository(
          initial: const [
            LocalAnekdot(id: 'local-1', text: 'local unique'),
            LocalAnekdot(id: 'shared-1', text: 'shared text'),
          ],
        );

        final service = AnekdotPoolService(
          localRepo: repository,
          embeddedLoader: () async => const [
            Anekdot(
              id: 'embedded-1',
              anekdotText: 'embedded unique',
              source: 'embedded',
            ),
            Anekdot(
              id: 'embedded-2',
              anekdotText: 'shared text',
              source: 'embedded',
            ),
          ],
          random: FixedRandom(2),
        );

        final anekdot = await service.getRandomAnekdot();

        expect(anekdot.anekdotText, 'local unique');
        expect(anekdot.source, 'local');
      },
    );
  });

  group('AnekdotFirebaseSyncService', () {
    test('updates local cache and timestamp when cache is stale', () async {
      final repository = FakeLocalAnekdotsRepository(
        initial: List.generate(
          150,
          (index) => LocalAnekdot(id: '$index', text: 'old $index'),
        ),
      );
      final firebaseService = FakeFirebaseAnekdotService([
        const Anekdot(id: 'new-1', anekdotText: 'new one', source: 'firebase'),
        const Anekdot(id: 'new-2', anekdotText: 'new two', source: 'firebase'),
      ]);
      final service = AnekdotFirebaseSyncService(
        firebaseService: firebaseService,
        localRepo: repository,
      );

      repository.lastUpdateTimeProvider = () =>
          DateTime.now().subtract(const Duration(minutes: 31));

      final updated = await service.syncIfNeeded();
      final all = await repository.getAll();

      expect(updated, isTrue);
      expect(firebaseService.calls, 1);
      expect(repository.addBatchCalls, 1);
      expect(repository.setLastUpdateCalls, 1);
      expect(all.any((item) => item.id == 'new-1'), isTrue);
      expect(all.any((item) => item.id == 'new-2'), isTrue);
    });
  });
}
