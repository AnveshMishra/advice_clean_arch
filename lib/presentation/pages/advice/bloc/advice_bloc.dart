import 'package:advice_clean_arch/domain/usecases/advice_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  final AdviceUseCases adviceUseCases;

  /// could also use other use cases
  AdviceBloc({required this.adviceUseCases}) : super(AdviceInitial()) {
    on<AdviceRequestEvent>((event, emit) async {
      emit(AdviceRequestLoading());
      debugPrint("AdviceRequestLoading");
      final advice = await adviceUseCases.getAdvice();
      debugPrint("loaded");
      advice.fold((l) => emit(AdviceRequestFailed()),
          (r) => emit(AdviceRequestLoaded(r.advice)));
    });
  }
}
