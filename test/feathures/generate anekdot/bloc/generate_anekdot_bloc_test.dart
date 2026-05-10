import 'dart:async';

import 'package:anekdots_b/core/services/anekdot/anekdot_loader_service_interface.dart';
import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';
import 'package:anekdots_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:anekdots_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:anekdots_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAnekdotLoaderService implements AnekdotLoaderServiceInterface {
  FakeAnekdotLoaderService(this.anekdot);

  final Anekdot anekdot;
  int getRandomCalls = 0;
  int syncCalls = 0;

  @override
  Future<Anekdot> getRandomAnekdot() async {
    getRandomCalls += 1;
    return anekdot;
  }

  @override
  Future<void> syncFirebaseIfNeeded() async {
    syncCalls += 1;
  }
}

class FakeFavoritesRepository implements FavoritesRepositoryInterface {
  FakeFavoritesRepository({List<FavoriteAnekdots>? initial})
    : _favorites = List<FavoriteAnekdots>.from(initial ?? const []);

  final List<FavoriteAnekdots> _favorites;
  int getCalls = 0;
  int toggleCalls = 0;

  @override
  Future<List<FavoriteAnekdots>> getAnekdotsList() async {
    getCalls += 1;
    return List<FavoriteAnekdots>.unmodifiable(_favorites);
  }

  @override
  Future<List<FavoriteAnekdots>> createOrDeleteAnekdots(
    FavoriteAnekdots anekdot,
  ) async {
    toggleCalls += 1;
    final exists = _favorites.any(
      (item) => item.anekdotText == anekdot.anekdotText,
    );

    if (exists) {
      _favorites.removeWhere((item) => item.anekdotText == anekdot.anekdotText);
    } else {
      _favorites.add(anekdot);
    }

    return List<FavoriteAnekdots>.unmodifiable(_favorites);
  }

  @override
  Future<void> addOrUpdateAnekdot(FavoriteAnekdots anekdot) async {
    _favorites
      ..removeWhere((item) => item.id == anekdot.id)
      ..add(anekdot);
  }

  @override
  Future<void> clear() async {
    _favorites.clear();
  }
}

void main() {
  group('GenerateAnekdotBloc', () {
    test('loads anekdot and favorites in parallel flow', () async {
      final loader = FakeAnekdotLoaderService(
        const Anekdot(anekdotText: 'test anekdot', source: 'embedded'),
      );
      final favoritesRepository = FakeFavoritesRepository(
        initial: [
          FavoriteAnekdots(
            id: '1',
            createdAt: DateTime(2026),
            anekdotText: 'favorite',
          ),
        ],
      );

      final bloc = GenerateAnekdotBloc(
        loaderService: loader,
        favoritesRepository: favoritesRepository,
      );

      addTearDown(bloc.close);

      final states = <GenerateAnekdotState>[];
      final subscription = bloc.stream.listen(states.add);
      addTearDown(subscription.cancel);

      bloc.add(GenerateRandomAnekdot());
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      expect(loader.getRandomCalls, 1);
      expect(favoritesRepository.getCalls, 1);
      expect(states.whereType<GenerateAnekdotLoaded>().length, 1);

      final loaded = states.whereType<GenerateAnekdotLoaded>().single;
      expect(loaded.anekdot.anekdotText, 'test anekdot');
      expect(loaded.isFavorite('favorite'), isTrue);
    });

    test('toggle favorite uses repository result without extra read', () async {
      final loader = FakeAnekdotLoaderService(
        const Anekdot(anekdotText: 'test anekdot', source: 'embedded'),
      );
      final favoritesRepository = FakeFavoritesRepository();
      final bloc = GenerateAnekdotBloc(
        loaderService: loader,
        favoritesRepository: favoritesRepository,
      );

      addTearDown(bloc.close);

      final completer = Completer<void>();
      bloc.add(
        ToggleFavoriteAnekdot(
          anekdot: const Anekdot(anekdotText: 'test anekdot'),
          completer: completer,
        ),
      );

      await completer.future;
      await Future<void>.delayed(Duration.zero);

      expect(favoritesRepository.toggleCalls, 1);
      expect(favoritesRepository.getCalls, 0);
      expect(
        bloc.state,
        isA<GenerateAnekdotLoaded>().having(
          (state) => state.isFavorite('test anekdot'),
          'isFavorite',
          isTrue,
        ),
      );
    });
  });
}
