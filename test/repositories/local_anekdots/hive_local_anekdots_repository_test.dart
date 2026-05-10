import 'dart:io';

import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/hive/hive_registrar.g.dart';
import 'package:anekdots_b/repositories/local_anekdots/hive_local_anekdots_repository.dart';
import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:talker/talker.dart';

void main() {
  late Directory tempDir;
  late HiveLocalAnekdotsRepository repository;
  late Box<LocalAnekdot> localBox;
  late Box<dynamic> metadataBox;

  setUpAll(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(
      Talker(settings: TalkerSettings(enabled: false)),
    );

    tempDir = await Directory.systemTemp.createTemp(
      'hive_local_anekdots_repository_test',
    );
    Hive
      ..init(tempDir.path)
      ..registerAdapters();

    localBox = await Hive.openBox<LocalAnekdot>('local_anekdots');
    metadataBox = await Hive.openBox<dynamic>('metadata');
    repository = HiveLocalAnekdotsRepository(localBox, metadataBox);
  });

  tearDown(() async {
    await localBox.clear();
    await metadataBox.clear();
  });

  tearDownAll(() async {
    await localBox.close();
    await metadataBox.close();
    await Hive.close();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
    await getIt.reset();
  });

  test('merges batch by id without duplicating existing items', () async {
    await repository.addBatchFromFirebase([
      const LocalAnekdot(id: '1', text: 'one'),
      const LocalAnekdot(id: '2', text: 'two'),
    ]);

    await repository.addBatchFromFirebase([
      const LocalAnekdot(id: '2', text: 'two changed'),
      const LocalAnekdot(id: '3', text: 'three'),
    ]);

    final all = await repository.getAll();

    expect(all, hasLength(3));
    expect(all.any((item) => item.id == '1' && item.text == 'one'), isTrue);
    expect(all.any((item) => item.id == '2' && item.text == 'two'), isTrue);
    expect(all.any((item) => item.id == '3' && item.text == 'three'), isTrue);
  });

  test('clears cache when the batch would exceed the max size', () async {
    await repository.addBatchFromFirebase([
      for (var i = 0; i < 550; i++) LocalAnekdot(id: '$i', text: 'old $i'),
    ]);

    await repository.addBatchFromFirebase([
      for (var i = 0; i < 200; i++) LocalAnekdot(id: 'new_$i', text: 'new $i'),
    ]);

    final all = await repository.getAll();

    expect(all, hasLength(200));
    expect(all.every((item) => item.id.startsWith('new_')), isTrue);
  });

  test('stores and reads last update timestamp', () async {
    final now = DateTime.now().toUtc();

    await repository.setLastUpdateTime(now);
    final loaded = await repository.getLastUpdateTime();

    expect(loaded, isNotNull);
    expect(
      loaded!.toIso8601String(),
      now.toIso8601String(),
    );
  });
}
