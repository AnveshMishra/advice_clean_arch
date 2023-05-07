part of 'advice_bloc.dart';

@immutable
abstract class AdviceState {}

class AdviceInitial extends AdviceState {}

class AdviceRequestLoading extends AdviceState {}

class AdviceRequestLoaded extends AdviceState {
  final String message;

  AdviceRequestLoaded(
    this.message,
  );
}

class AdviceRequestFailed extends AdviceState {}
