import 'package:bloc/bloc.dart';
import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/services/anekdot_servise_interface.dart';
import 'package:category_b/core/services/models/anekdots.dart';
import 'package:equatable/equatable.dart';

part 'generate_anekdot_event.dart';
part 'generate_anekdot_state.dart';

class GenerateAnekdotBloc
    extends Bloc<GenerateAnekdotEvent, GenerateAnekdotState> {
  final _service = getIt<AnekdotServiceInterface>();
  GenerateAnekdotBloc() : super(GenerateAnekdotInitial()) {
    on<GenerateRandomAnekdot>(_onSearch);
  }

  Future<void> _onSearch(
    GenerateRandomAnekdot event,
    Emitter<GenerateAnekdotState> emit,
  ) async {
    try {
      emit(GenerateAnekdotLoading());
      final anekdot = await _service.getRandomAnekdot();
      emit(GenerateAnekdotLoaded(anekdot));
    } catch (e) {
      emit(GenerateAnekdotFailure(e));
    }
  }
}
