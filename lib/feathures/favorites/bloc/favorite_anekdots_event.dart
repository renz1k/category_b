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

final class AddCustomAnekdot extends FavoriteAnekdotsEvent {
  const AddCustomAnekdot({required this.text});

  final String text;

  @override
  List<Object?> get props => super.props..add(text);
}

final class UpdateAnekdot extends FavoriteAnekdotsEvent {
  const UpdateAnekdot({required this.id, required this.newText});

  final String id;
  final String newText;

  @override
  List<Object?> get props => super.props..addAll([id, newText]);
}
