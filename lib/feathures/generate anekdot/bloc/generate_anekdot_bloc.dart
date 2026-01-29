import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:category_b/core/services/anekdot/anekdot_service_interface.dart';
import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:equatable/equatable.dart';

part 'generate_anekdot_event.dart';
part 'generate_anekdot_state.dart';

class GenerateAnekdotBloc
    extends Bloc<GenerateAnekdotEvent, GenerateAnekdotState> {
  GenerateAnekdotBloc({
    required AnekdotServiceInterface service,
    required FavoritesRepositoryInterface favoritesRepository,
  }) : _favoritesRepository = favoritesRepository,
       _service = service,
       super(GenerateAnekdotInitial()) {
    on<GenerateRandomAnekdot>(_onSearch);
    on<ToggleFavoriteAnekdot>(_onToggle);
  }

  final AnekdotServiceInterface _service;
  final FavoritesRepositoryInterface _favoritesRepository;

  Future<void> _onSearch(
    GenerateRandomAnekdot event,
    Emitter<GenerateAnekdotState> emit,
  ) async {
    try {
      emit(GenerateAnekdotLoading());
      final anekdot = await _service.getRandomAnekdot();
      final favoriteAnekdots = await _favoritesRepository.getAnekdotsList();
      emit(
        GenerateAnekdotLoaded(
          anekdot: anekdot,
          favoriteAnekdots: favoriteAnekdots,
        ),
      );
    } catch (e) {
      emit(GenerateAnekdotFailure(e));
    }
  }

  Future<void> _onToggle(
    ToggleFavoriteAnekdot event,
    Emitter<GenerateAnekdotState> emit,
  ) async {
    try {
      final prevState = state;

      await _favoritesRepository.createOrDeleteAnekdots(
        event.anekdot.toFavorite(),
      );
      final favoriteAnekdots = await _favoritesRepository.getAnekdotsList();

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
    } catch (e) {
      emit(GenerateAnekdotFailure(e));
    } finally {
      event.completer?.complete();
    }
  }
}
