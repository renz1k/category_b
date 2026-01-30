part of 'favorite_anekdots_bloc.dart';

sealed class FavoriteAnekdotsEvent extends Equatable {
  const FavoriteAnekdotsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadFavoriteAnekdots extends FavoriteAnekdotsEvent {}

final class ClearFavoriteAnekdots extends FavoriteAnekdotsEvent {
  const ClearFavoriteAnekdots({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}
