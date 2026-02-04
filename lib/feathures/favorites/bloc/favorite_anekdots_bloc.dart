import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:category_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'favorite_anekdots_event.dart';
part 'favorite_anekdots_state.dart';

class FavoriteAnekdotsBloc
    extends Bloc<FavoriteAnekdotsEvent, FavoriteAnekdotsState> {
  FavoriteAnekdotsBloc({
    required FavoritesRepositoryInterface favoritesRepository,
  }) : _favoritesRepository = favoritesRepository,
       super(FavoriteAnekdotsInitial()) {
    on<LoadFavoriteAnekdots>(_load);
    on<AddCustomAnekdot>(_onAddCustom);
    on<UpdateAnekdot>(_onUpdate);
    on<ClearFavoriteAnekdots>(_onClear);
  }
  final FavoritesRepositoryInterface _favoritesRepository;

  Future<void> _load(
    LoadFavoriteAnekdots event,
    Emitter<FavoriteAnekdotsState> emit,
  ) async {
    try {
      emit(FavoriteAnekdotsLoading());
      final anekdots = await _favoritesRepository.getAnekdotsList();
      emit(FavoriteAnekdotsLoaded(anekdots: anekdots));
    } catch (e) {
      emit(FavoriteAnekdotsFailure(error: e));
    }
  }

  Future<void> _onAddCustom(
    AddCustomAnekdot event,
    Emitter<FavoriteAnekdotsState> emit,
  ) async {
    try {
      final newAnekdot = FavoriteAnekdots(
        id: const Uuid().v4(),
        anekdotText: event.text,
        createdAt: DateTime.now(),
      );
      await _favoritesRepository.addOrUpdateAnekdot(newAnekdot);
      final anekdots = await _favoritesRepository.getAnekdotsList();
      emit(FavoriteAnekdotsLoaded(anekdots: anekdots));
    } catch (e) {
      emit(FavoriteAnekdotsFailure(error: e));
    }
  }

  Future<void> _onUpdate(
    UpdateAnekdot event,
    Emitter<FavoriteAnekdotsState> emit,
  ) async {
    try {
      final updatedAnekdot = FavoriteAnekdots(
        id: event.id,
        anekdotText: event.newText,
        createdAt: DateTime.now(),
      );

      await _favoritesRepository.addOrUpdateAnekdot(updatedAnekdot);

      final anekdots = await _favoritesRepository.getAnekdotsList();
      emit(FavoriteAnekdotsLoaded(anekdots: anekdots));
    } catch (e) {
      emit(FavoriteAnekdotsFailure(error: e));
    }
  }

  Future<void> _onClear(
    ClearFavoriteAnekdots event,
    Emitter<FavoriteAnekdotsState> emit,
  ) async {
    try {
      await _favoritesRepository.clear();

      final anekdots = await _favoritesRepository.getAnekdotsList();
      emit(FavoriteAnekdotsLoaded(anekdots: anekdots));

      event.completer?.complete();
    } catch (e) {
      emit(FavoriteAnekdotsFailure(error: e));
      event.completer?.completeError(e);
    }
  }
}
