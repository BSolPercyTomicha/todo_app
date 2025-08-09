import 'package:equatable/equatable.dart';

class UserTaskStatsEntity extends Equatable {
  final String userName;
  final int completed;
  final int total;

  const UserTaskStatsEntity({
    required this.userName,
    required this.completed,
    required this.total,
  });

  @override
  List<Object?> get props => [userName, completed, total];
}
