part of 'favorite_anekdots_bloc.dart';

sealed class FavoriteAnekdotsEvent extends Equatable {
  const FavoriteAnekdotsEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavoriteAnekdots extends FavoriteAnekdotsEvent {}
