part of 'todos_overview_bloc.dart';

enum TodosOverviewStatus { initial, loading, success, failure }

final class TodosOverviewState extends Equatable {
  const TodosOverviewState({
    this.status = TodosOverviewStatus.initial,
    this.toBeCompleted = const [],
    this.inProgress = const [],
    this.underReview = const [],
    this.completed = const [],
  });

  final TodosOverviewStatus status;
  final List<Todo> toBeCompleted;
  final List<Todo> inProgress;
  final List<Todo> underReview;
  final List<Todo> completed;

  TodosOverviewState copyWith({
    TodosOverviewStatus Function()? status,
    List<Todo> Function()? toBeCompleted,
    List<Todo> Function()? inProgress,
    List<Todo> Function()? underReview,
    List<Todo> Function()? completed,
  }) {
    return TodosOverviewState(
      status: status != null ? status() : this.status,
      toBeCompleted: toBeCompleted != null ? toBeCompleted() : this.toBeCompleted,
      inProgress: inProgress != null ? inProgress() : this.inProgress,
      underReview: underReview != null ? underReview() : this.underReview,
      completed: completed != null ? completed() : this.completed,
    );
  }

  @override
  List<Object?> get props =>
      [status, toBeCompleted, inProgress, underReview, completed];
}