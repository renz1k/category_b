import 'dart:convert';
import 'dart:math';

import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';
import 'package:anekdots_b/repositories/local_anekdots/local_anekdots_repository.dart';
import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';
import 'package:flutter/services.dart';
import 'package:talker/talker.dart';

class AnekdotPoolService {
  AnekdotPoolService({
    required this.localRepo,
    Future<List<Anekdot>> Function()? embeddedLoader,
    Random? random,
  }) : _embeddedLoader = embeddedLoader ?? _loadEmbeddedFromAssets,
       _random = random ?? Random();

  final LocalAnekdotsRepository localRepo;
  final Future<List<Anekdot>> Function() _embeddedLoader;
  final Random _random;

  List<Anekdot>? _embeddedCache;
  List<LocalAnekdot>? _localCache;

  Future<Anekdot> getRandomAnekdot() async {
    try {
      final cachedSources = await Future.wait([
        _getEmbeddedCached(),
        _getLocalCached(),
      ]);
      final embedded = cachedSources[0] as List<Anekdot>;
      final localAnekdots = cachedSources[1] as List<LocalAnekdot>;

      final allAnekdots = _buildPool(embedded, localAnekdots);
      if (allAnekdots.isEmpty) {
        return const Anekdot(
          anekdotText: 'No anekdots available',
          isError: true,
        );
      }

      final selected = allAnekdots[_random.nextInt(allAnekdots.length)];

      getIt<Talker>().info(
        'Random: id=${selected.id}, source=${selected.source}, '
        'pool=${embedded.length}+${localAnekdots.length}',
      );

      return selected;
    } on Exception catch (e) {
      getIt<Talker>().error('Anekdot pool error: $e');
      return const Anekdot(anekdotText: 'Error loading', isError: true);
    }
  }

  void invalidateLocalCache() {
    _localCache = null;
  }

  Future<List<Anekdot>> _getEmbeddedCached() async {
    if (_embeddedCache != null) {
      return _embeddedCache!;
    }

    final loaded = await _embeddedLoader();
    _embeddedCache = loaded;
    return loaded;
  }

  Future<List<LocalAnekdot>> _getLocalCached() async {
    final cached = _localCache;
    if (cached != null) {
      return cached;
    }

    final loaded = await localRepo.getAll();
    _localCache = loaded;
    return loaded;
  }

  List<Anekdot> _buildPool(
    List<Anekdot> embedded,
    List<LocalAnekdot> localAnekdots,
  ) {
    final pool = <Anekdot>[];
    final seenTexts = <String>{};

    void addIfUnique(Anekdot anekdot) {
      final normalizedText = _normalizeText(anekdot.anekdotText);
      if (seenTexts.add(normalizedText)) {
        pool.add(anekdot);
      }
    }

    for (final anekdot in embedded) {
      addIfUnique(anekdot);
    }

    for (final anekdot in localAnekdots) {
      addIfUnique(anekdot.toAnekdot());
    }

    return pool;
  }

  String _normalizeText(String text) => text.trim().toLowerCase();

  static Future<List<Anekdot>> _loadEmbeddedFromAssets() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/anekdots/jokes.json',
      );
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      return (jsonData['jokes'] as List).map((j) {
        final jMap = j as Map;
        return Anekdot(
          id: jMap['id'] as String?,
          anekdotText: jMap['text'] as String,
          source: 'embedded',
        );
      }).toList();
    } on Exception catch (e) {
      getIt<Talker>().error('Embedded JSON load error: $e');
      return [];
    }
  }
}
