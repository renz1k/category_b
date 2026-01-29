import 'package:bloc/bloc.dart';
import 'package:category_b/repositories/favorites/favorites_repository_interface.dart';
import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:equatable/equatable.dart';

part 'favorite_anekdots_event.dart';
part 'favorite_anekdots_state.dart';

class FavoriteAnekdotsBloc
    extends Bloc<FavoriteAnekdotsEvent, FavoriteAnekdotsState> {
  FavoriteAnekdotsBloc({
    required FavoritesRepositoryInterface favoritesRepository,
  }) : _favoritesRepository = favoritesRepository,
       super(FavoriteAnekdotsInitial()) {
    on<LoadFavoriteAnekdots>(_load);
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
}
