part of 'generate_anekdot_bloc.dart';

sealed class GenerateAnekdotState extends Equatable {
  const GenerateAnekdotState();

  @override
  List<Object> get props => [];
}

final class GenerateAnekdotInitial extends GenerateAnekdotState {}

final class GenerateAnekdotLoading extends GenerateAnekdotState {}

final class GenerateAnekdotLoaded extends GenerateAnekdotState {
  const GenerateAnekdotLoaded(this.anekdot);

  final Anekdot anekdot;

  @override
  List<Object> get props => super.props..add([anekdot]);
}

final class GenerateAnekdotFailure extends GenerateAnekdotState {
  const GenerateAnekdotFailure(this.error);

  final Object error;

  @override
  List<Object> get props => super.props..addAll([error]);
}
