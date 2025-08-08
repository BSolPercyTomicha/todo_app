import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/generate_description.usecase.dart';

part 'ia.event.dart';
part 'ia.state.dart';

class IABloc extends Bloc<IAEvent, IAState> {
  final GenerateDescriptionUseCase generateDescription;

  IABloc(this.generateDescription) : super(IAState.initial()) {
    on<GenerateDescription>(_onGenerateDescription);
  }

  Future<void> _onGenerateDescription(
    GenerateDescription event,
    Emitter<IAState> emit,
  ) async {
    emit(state.copyWith(status: IAStatus.loading));

    try {
      final description = await generateDescription(event.task);
      emit(state.copyWith(
        status: IAStatus.success,
        description: description,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: IAStatus.error,
        errorMessage: 'No se pudo generar la descripción',
      ));
    }
  }
}
