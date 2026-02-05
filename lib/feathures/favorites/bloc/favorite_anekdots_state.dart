part of 'favorite_anekdots_bloc.dart';

sealed class FavoriteAnekdotsState extends Equatable {
  const FavoriteAnekdotsState();

  @override
  List<Object> get props => [];
}

final class FavoriteAnekdotsInitial extends FavoriteAnekdotsState {}

final class FavoriteAnekdotsLoading extends FavoriteAnekdotsState {}

final class FavoriteAnekdotsLoaded extends FavoriteAnekdotsState {
  const FavoriteAnekdotsLoaded({
    required this.anekdots,
    List<FavoriteAnekdots>? filteredAnekdots,
    this.searchQuery = '',
  }) : filteredAnekdots = filteredAnekdots ?? anekdots;

  final List<FavoriteAnekdots> anekdots;
  final List<FavoriteAnekdots> filteredAnekdots;
  final String searchQuery;

  @override
  List<Object> get props =>
      super.props..addAll([anekdots, filteredAnekdots, searchQuery]);

  FavoriteAnekdotsLoaded copyWith({
    List<FavoriteAnekdots>? anekdots,
    String? searchQuery,
  }) {
    final newAnekdots = anekdots ?? this.anekdots;
    final newQuery = searchQuery ?? this.searchQuery;

    final newFiltered = newQuery.isEmpty
        ? newAnekdots
        : newAnekdots
              .where(
                (e) => e.anekdotText.toLowerCase().contains(
                  newQuery.toLowerCase(),
                ),
              )
              .toList();

    return FavoriteAnekdotsLoaded(
      anekdots: newAnekdots,
      filteredAnekdots: newFiltered,
      searchQuery: newQuery,
    );
  }
}

final class FavoriteAnekdotsFailure extends FavoriteAnekdotsState {
  const FavoriteAnekdotsFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
