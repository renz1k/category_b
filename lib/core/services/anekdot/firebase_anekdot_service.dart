import 'dart:math';

import 'package:anekdots_b/core/constants/app_constants.dart';
import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fb;
import 'package:talker/talker.dart';

class FirebaseAnekdotService {
  // Получить 200 случайных анекдотов из Firebase
  Future<List<Anekdot>> getRandomAnekdots({
    int limit = AppConstants.anekdotFetchSize,
  }) async {
    try {
      getIt<Talker>().info('Firebase fetch starting (limit=$limit)...');
      final randomValue = Random().nextDouble();

      final snapshot = await fb.FirebaseFirestore.instance
          .collection('jokes')
          .where('randomKey', isGreaterThanOrEqualTo: randomValue)
          .limit(limit)
          .get();

      final docs = snapshot.docs.toList();

      // Если < limit → берём с начала
      if (docs.length < limit) {
        final remainingSnapshot = await fb.FirebaseFirestore.instance
            .collection('jokes')
            .where('randomKey', isLessThan: randomValue)
            .limit(limit - docs.length)
            .get();

        docs.addAll(remainingSnapshot.docs);
      }

      getIt<Talker>().info(
        'Firebase fetched: ${docs.length} anekdots (randomKey=$randomValue)',
      );

      return docs
          .map(
            (doc) => Anekdot(
              id: doc.data()['id'] as String?,
              anekdotText: doc['text'] as String,
              source: 'firebase',
            ),
          )
          .toList();
    } on Exception catch (e) {
      getIt<Talker>().error('Firebase fetch error: $e');
      return [];
    }
  }

  // Получить последнее время обновления из metadata
  Future<DateTime?> getLastUpdateTime() async {
    try {
      final doc = await fb.FirebaseFirestore.instance
          .collection('sync_metadata')
          .doc('main')
          .get();

      if (doc.exists) {
        final timestamp = doc['lastUpdated'] as fb.Timestamp?;
        return timestamp?.toDate();
      }
      return null;
    } on Exception catch (e) {
      getIt<Talker>().error('Get last update error: $e');
      return null;
    }
  }
}
