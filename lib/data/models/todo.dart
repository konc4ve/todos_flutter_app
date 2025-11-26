import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable {
  final String title;
  final String id;
  final DateTime completionDate;
  final TodoStatus status;

  Todo({
    required this.title,
    String? id,
    this.status = TodoStatus.toBeCompleted,
    required this.completionDate,
  }) : assert(
         id == null || id.isNotEmpty,
         'id must either be null or not empty',
       ),
       id = id ?? const Uuid().v4();

   // в проде я бы написал 
   //bool get isOverdue => DateTime.now().isAfter(completionDate);
 
  bool get isOverdue => true;

  Todo copyWith({
    String? title,
    String? id,
    DateTime? completionDate,
    TodoStatus? status,
  }) {
    return Todo(
      title: title ?? this.title,
      id: id ?? this.id,
      completionDate: completionDate ?? this.completionDate,
      status: status ?? this.status,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [title, id, status, completionDate];
}

enum TodoStatus { toBeCompleted, inProgress, underReview, completed }
