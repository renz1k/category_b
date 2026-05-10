import 'dart:async';

import 'package:anekdots_b/core/services/anekdot/anekdot_loader_service_interface.dart';
import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';
import 'package:anekdots_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:anekdots_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'generate_anekdot_event.dart';
part 'generate_anekdot_state.dart';

class GenerateAnekdotBloc
    extends Bloc<GenerateAnekdotEvent, GenerateAnekdotState> {
  GenerateAnekdotBloc({
    required AnekdotLoaderServiceInterface loaderService,
    required FavoritesRepositoryInterface favoritesRepository,
  }) : _favoritesRepository = favoritesRepository,
       _loaderService = loaderService,
       super(GenerateAnekdotInitial()) {
    on<GenerateRandomAnekdot>(_onSearch);
    on<ToggleFavoriteAnekdot>(_onToggle);
    on<FavoritesListDirty>(_favoriteListReload);
  }

  final AnekdotLoaderServiceInterface _loaderService;
  final FavoritesRepositoryInterface _favoritesRepository;

  Future<void> _onSearch(
    GenerateRandomAnekdot event,
    Emitter<GenerateAnekdotState> emit,
  ) async {
    try {
      emit(GenerateAnekdotLoading());
      final results = await Future.wait([
        _loaderService.getRandomAnekdot(),
        _favoritesRepository.getAnekdotsList(),
      ]);
      final anekdot = results[0] as Anekdot;
      final favoriteAnekdots = results[1] as List<FavoriteAnekdots>;
      emit(
        GenerateAnekdotLoaded(
          anekdot: anekdot,
          favoriteAnekdots: favoriteAnekdots,
        ),
      );
    } on Object catch (e) {
      emit(GenerateAnekdotFailure(e));
    }
  }

  Future<void> _onToggle(
    ToggleFavoriteAnekdot event,
    Emitter<GenerateAnekdotState> emit,
  ) async {
    try {
      final prevState = state;

      final favoriteAnekdots = await _favoritesRepository
          .createOrDeleteAnekdots(
            event.anekdot.toFavorite(),
          );

      if (prevState is GenerateAnekdotLoaded) {
        emit(prevState.copyWith(favoriteAnekdot: favoriteAnekdots));
      } else {
        emit(
          GenerateAnekdotLoaded(
            favoriteAnekdots: favoriteAnekdots,
            anekdot: event.anekdot,
          ),
        );
      }
    } on Object catch (e) {
      emit(GenerateAnekdotFailure(e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _favoriteListReload(
    FavoritesListDirty event,
    Emitter<GenerateAnekdotState> emit,
  ) async {
    if (state is GenerateAnekdotLoaded) {
      final current = state as GenerateAnekdotLoaded;
      final newFavorites = await _favoritesRepository.getAnekdotsList();
      emit(current.copyWith(favoriteAnekdot: newFavorites));
    }
  }
}
