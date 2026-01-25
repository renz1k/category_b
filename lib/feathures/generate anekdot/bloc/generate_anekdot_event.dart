part of 'generate_anekdot_bloc.dart';

sealed class GenerateAnekdotEvent extends Equatable {
  const GenerateAnekdotEvent();

  @override
  List<Object> get props => [];
}

class GenerateRandomAnekdot extends GenerateAnekdotEvent {}
