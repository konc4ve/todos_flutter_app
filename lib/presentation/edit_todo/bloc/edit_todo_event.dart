part of 'edit_todo_bloc.dart';

sealed class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object> get props => [];
}

final class EditTodoTitleChanged extends EditTodoEvent {
  const EditTodoTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}



final class EditTodoCompletionDateChanged extends EditTodoEvent {
  const EditTodoCompletionDateChanged(this.completionDate);

  final DateTime completionDate;

  @override
  List<Object> get props => [completionDate];
}

final class EditTodoSubmitted extends EditTodoEvent {
  const EditTodoSubmitted();
}
