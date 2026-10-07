/// Task data model representing a productivity task item.
class TaskModel {
  const TaskModel({
    required this.id,
    required this.title,
    required this.time,
    required this.tag,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String time;
  final String tag;
  final bool isCompleted;

  /// Creates a [TaskModel] from a JSON map.
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      time: json['time'] as String,
      tag: json['tag'] as String,
      isCompleted: json['is_completed'] as bool? ?? false,
    );
  }

  /// Converts this [TaskModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'tag': tag,
      'is_completed': isCompleted,
    };
  }

  /// Creates a copy of this [TaskModel] with the given fields replaced.
  TaskModel copyWith({
    String? id,
    String? title,
    String? time,
    String? tag,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      tag: tag ?? this.tag,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
