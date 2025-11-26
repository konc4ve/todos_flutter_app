part of 'todos_overview_bloc.dart';

sealed class TodosOverviewEvent extends Equatable {
  const TodosOverviewEvent();

  @override
  List<Object> get props => [];
}

final class TodosOverviewSubscriptionRequested extends TodosOverviewEvent {
  const TodosOverviewSubscriptionRequested();
}

class TodosOverviewTodoMoved extends TodosOverviewEvent {
  final int oldListIndex;
  final int oldItemIndex;
  final int newListIndex;
  final int newItemIndex;

  const TodosOverviewTodoMoved({
    required this.oldListIndex,
    required this.oldItemIndex,
    required this.newListIndex,
    required this.newItemIndex,
  });
}

final class TodosOverviewTodoDeleted extends TodosOverviewEvent {
  const TodosOverviewTodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}
