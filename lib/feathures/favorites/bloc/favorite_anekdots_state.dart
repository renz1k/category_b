part of 'favorite_anekdots_bloc.dart';

sealed class FavoriteAnekdotsState extends Equatable {
  const FavoriteAnekdotsState();

  @override
  List<Object> get props => [];
}

final class FavoriteAnekdotsInitial extends FavoriteAnekdotsState {}

final class FavoriteAnekdotsLoading extends FavoriteAnekdotsState {}

final class FavoriteAnekdotsLoaded extends FavoriteAnekdotsState {
  const FavoriteAnekdotsLoaded({required this.anekdots});

  final List<FavoriteAnekdots> anekdots;

  @override
  List<Object> get props => super.props..add(anekdots);
}

final class FavoriteAnekdotsFailure extends FavoriteAnekdotsState {
  const FavoriteAnekdotsFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
