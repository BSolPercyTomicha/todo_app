class TaskEntity {
  final int? id;
  final String title;
  final String description;
  final List<String> tags;
  final bool isCompleted;
  final String assignedUser;

  TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.isCompleted,
    required this.assignedUser,
  });
}
