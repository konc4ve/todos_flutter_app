part of 'edit_todo_bloc.dart';

enum EditTodoStatus { initial, loading, success, failure }

class EditTodoState extends Equatable {
  final String title;
  final DateTime? completionDate;
  final bool isValid; 
  final EditTodoStatus status;

  EditTodoState({
    this.title = '',
    this.completionDate,
    this.status = EditTodoStatus.initial,
  }) : isValid = title.isNotEmpty && completionDate != null;

  EditTodoState copyWith({
    String? title,
    DateTime? completionDate,
    EditTodoStatus? status,
  }) {
    return EditTodoState(
      title: title ?? this.title,
      completionDate: completionDate ?? this.completionDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [title, completionDate, isValid, status];
}
