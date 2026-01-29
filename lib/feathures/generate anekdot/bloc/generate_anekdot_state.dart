// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'generate_anekdot_bloc.dart';

sealed class GenerateAnekdotState extends Equatable {
  const GenerateAnekdotState();

  @override
  List<Object> get props => [];
}

final class GenerateAnekdotInitial extends GenerateAnekdotState {}

final class GenerateAnekdotLoading extends GenerateAnekdotState {}

final class GenerateAnekdotLoaded extends GenerateAnekdotState {
  const GenerateAnekdotLoaded({
    required List<FavoriteAnekdots> favoriteAnekdots,
    required this.anekdot,
  }) : _favoriteAnekdots = favoriteAnekdots;

  final Anekdot anekdot;
  final List<FavoriteAnekdots> _favoriteAnekdots;

  bool isFavorite(String anekdotText) {
    return _favoriteAnekdots
        .where((e) => e.anekdotText == anekdotText)
        .isNotEmpty;
  }

  @override
  List<Object> get props => super.props..add([anekdot, _favoriteAnekdots]);

  GenerateAnekdotLoaded copyWith({
    Anekdot? anekdot,
    List<FavoriteAnekdots>? favoriteAnekdot,
  }) {
    return GenerateAnekdotLoaded(
      anekdot: anekdot ?? this.anekdot,
      favoriteAnekdots: favoriteAnekdot ?? _favoriteAnekdots,
    );
  }
}

final class GenerateAnekdotFailure extends GenerateAnekdotState {
  const GenerateAnekdotFailure(this.error);

  final Object error;

  @override
  List<Object> get props => super.props..addAll([error]);
}
