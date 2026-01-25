import 'package:bloc/bloc.dart';
import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/services/anekdot_service.dart';
import 'package:equatable/equatable.dart';

part 'generate_anekdot_event.dart';
part 'generate_anekdot_state.dart';

class GenerateAnekdotBloc
    extends Bloc<GenerateAnekdotEvent, GenerateAnekdotState> {
  final AnekdotService _service = getIt<AnekdotService>();
  GenerateAnekdotBloc() : super(GenerateAnekdotInitial()) {
    on<GenerateRandomAnekdot>(_onSearch);
  }

  Future<void> _onSearch(
    GenerateRandomAnekdot event,
    Emitter<GenerateAnekdotState> emit,
  ) async {
    try {
      emit(GenerateAnekdotLoading());
      final anekdotText = await _service.getRandomAnekdot();
      emit(GenerateAnekdotLoaded(anekdotText));
    } catch (e) {
      emit(GenerateAnekdotFailure(e));
    }
  }
}
