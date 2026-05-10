import 'package:anekdots_b/core/constants/app_constants.dart';
import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/repositories/local_anekdots/local_anekdots_repository.dart';
import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:talker/talker.dart';

class HiveLocalAnekdotsRepository implements LocalAnekdotsRepository {
  HiveLocalAnekdotsRepository(this._box, this._metadataBox);
  final Box<LocalAnekdot> _box;
  final Box<dynamic> _metadataBox;

  static const String lastUpdateKey = 'anekdots_last_update';

  @override
  Future<List<LocalAnekdot>> getAll() async {
    final all = _box.values.toList();
    getIt<Talker>().debug('Local cache: ${all.length} anekdots');
    return all;
  }

  @override
  Future<void> addBatchFromFirebase(List<LocalAnekdot> batch) async {
    final currentCount = _box.length;
    final uniqueBatch = <String, LocalAnekdot>{
      for (final anekdot in batch) anekdot.id: anekdot,
    };
    final wouldExceed =
        currentCount + uniqueBatch.length > AppConstants.anekdotMaxCached;

    getIt<Talker>().info(
      'Add batch: current=$currentCount, batch=${batch.length}, '
      'wouldExceed=$wouldExceed',
    );

    // Если не превышаем лимит → просто добавляем (merge по id)
    if (!wouldExceed) {
      final toStore = <String, LocalAnekdot>{};
      for (final entry in uniqueBatch.entries) {
        if (!_box.containsKey(entry.key)) {
          toStore[entry.key] = entry.value;
        }
      }

      if (toStore.isNotEmpty) {
        await _box.putAll(toStore);
      }
      getIt<Talker>().info('Batch merged: now ${_box.length} total');
      return;
    }

    // Если превышаем → FIFO: clear все + add новые
    getIt<Talker>().warning(
      'Cache overflow! Clearing ${_box.length} and adding ${batch.length}',
    );
    await _box.clear();
    if (uniqueBatch.isNotEmpty) {
      await _box.putAll(uniqueBatch);
    }
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Future<int> getTotal() async {
    return _box.length;
  }

  @override
  Future<DateTime?> getLastUpdateTime() async {
    try {
      final timestamp = _metadataBox.get(lastUpdateKey);
      if (timestamp is String) {
        return DateTime.parse(timestamp);
      }
      return null;
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> setLastUpdateTime(DateTime time) async {
    try {
      await _metadataBox.put(lastUpdateKey, time.toIso8601String());
    } on Exception {
      // Ignore
    }
  }
}
