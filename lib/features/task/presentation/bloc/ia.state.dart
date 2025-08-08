part of 'ia.bloc.dart';

enum IAStatus { initial, loading, success, error }

class IAState extends Equatable {
  final IAStatus status;
  final String description;
  final String? errorMessage;

  const IAState({
    required this.status,
    required this.description,
    this.errorMessage,
  });

  factory IAState.initial() => const IAState(
        status: IAStatus.initial,
        description: '',
      );

  IAState copyWith({
    IAStatus? status,
    String? description,
    String? errorMessage,
  }) {
    return IAState(
      status: status ?? this.status,
      description: description ?? this.description,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        description,
        errorMessage,
      ];
}
