part of 'generate_anekdot_bloc.dart';

sealed class GenerateAnekdotEvent extends Equatable {
  const GenerateAnekdotEvent();

  @override
  List<Object?> get props => [];
}

final class GenerateRandomAnekdot extends GenerateAnekdotEvent {}

final class ToggleFavoriteAnekdot extends GenerateAnekdotEvent {
  const ToggleFavoriteAnekdot({required this.anekdot, this.completer});

  final Anekdot anekdot;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([anekdot, completer]);
}

final class FavoritesListDirty extends GenerateAnekdotEvent {}
