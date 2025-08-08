part of 'ia.bloc.dart';

sealed class IAEvent extends Equatable {
  const IAEvent();

  @override
  List<Object> get props => [];
}

class GenerateDescription extends IAEvent {
  final String task;

  const GenerateDescription(this.task);

  @override
  List<Object> get props => [task];
}
