import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/domain/repositories/todos_repository.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({required TodosRepository todosRepository})
    : _todosRepository = todosRepository,
      super(EditTodoState()) {
    on<EditTodoTitleChanged>(_onTitleChanged);
    on<EditTodoCompletionDateChanged>(_onCompletionDateChanged);
    on<EditTodoSubmitted>(_onSubmitted);
  }

  final TodosRepository _todosRepository;

  void _onTitleChanged(
    EditTodoTitleChanged event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onCompletionDateChanged(
    EditTodoCompletionDateChanged event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(completionDate: event.completionDate));
  }

  Future<void> _onSubmitted(
    EditTodoSubmitted event,
    Emitter<EditTodoState> emit,
  ) async {
    if (state.completionDate == null) {
      emit(state.copyWith(status: EditTodoStatus.failure));
      return;
    }

    emit(state.copyWith(status: EditTodoStatus.loading));

    final todo = Todo(
      title: state.title,
      completionDate: state.completionDate!,
    );

    try {
      await _todosRepository.saveTodo(todo: todo);
      emit(state.copyWith(status: EditTodoStatus.success));
    } catch (_) {
      emit(state.copyWith(status: EditTodoStatus.failure));
    }
  }
}
