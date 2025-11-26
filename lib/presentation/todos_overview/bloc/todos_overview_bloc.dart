import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/domain/repositories/todos_repository.dart';

part 'todos_overview_event.dart';
part 'todos_overview_state.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  final TodosRepository _todosRepository;

  TodosOverviewBloc({required TodosRepository todosRepository})
    : _todosRepository = todosRepository,
      super(const TodosOverviewState()) {
    on<TodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosOverviewTodoDeleted>(_onTodoDeleted);
    on<TodosOverviewTodoMoved>(_onTodoMoved);
  }

  Future<void> _onTodoMoved(
    TodosOverviewTodoMoved event,
    Emitter<TodosOverviewState> emit,
  ) async {
    final statusByIndex = {
      0: TodoStatus.toBeCompleted,
      1: TodoStatus.inProgress,
      2: TodoStatus.underReview,
      3: TodoStatus.completed,
    };

    final lists = [
      state.toBeCompleted,
      state.inProgress,
      state.underReview,
      state.completed,
    ];

    final todo = lists[event.oldListIndex][event.oldItemIndex];
    final newStatus = statusByIndex[event.newListIndex]!;

    final updatedTodo = todo.copyWith(status: newStatus);
    try {
      await _todosRepository.saveTodo(
        todo: updatedTodo,
        index: event.newItemIndex,
      );
    } catch (_) {
      emit(state.copyWith(status: () => TodosOverviewStatus.failure));
    }
  }

  Future<void> _onSubscriptionRequested(
    TodosOverviewSubscriptionRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));

    await emit.forEach<List<Todo>>(
      _todosRepository.getTodos(),
      onData: (todos) {
        final toBeCompleted = todos
            .where((t) => t.status == TodoStatus.toBeCompleted)
            .toList();

        final inProgress = todos
            .where((t) => t.status == TodoStatus.inProgress)
            .toList();

        final underReview = todos
            .where((t) => t.status == TodoStatus.underReview)
            .toList();

        final completed = todos
            .where((t) => t.status == TodoStatus.completed)
            .toList();

        return state.copyWith(
          status: () => TodosOverviewStatus.success,
          toBeCompleted: () => toBeCompleted,
          inProgress: () => inProgress,
          underReview: () => underReview,
          completed: () => completed,
        );
      },
      onError: (_, __) =>
          state.copyWith(status: () => TodosOverviewStatus.failure),
    );
  }

  Future<void> _onTodoDeleted(
    TodosOverviewTodoDeleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    try {
      await _todosRepository.deleteTodo(event.todo.id);
    } catch (_) {
      emit(state.copyWith(status: () => TodosOverviewStatus.failure));
    }
  }
}
