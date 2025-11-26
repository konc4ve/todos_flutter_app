import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/data/services/todo_local_storage_service.dart';
import 'package:todo/domain/repositories/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {
  TodosRepositoryImpl({required TodoLocalStorageService localStorageService})
    : _localStorageService = localStorageService {
    _init();
  }

  void _init() {
    final todosJson = _localStorageService.getString();
    if (todosJson != null) {
      final todos =
          List<Map<dynamic, dynamic>>.from(json.decode(todosJson) as List)
              .map(
                (jsonMap) => Todo.fromJson(Map<String, dynamic>.from(jsonMap)),
              )
              .toList();
      _todoStreamController.add(todos);
    } else {
      _todoStreamController.add(const []);
    }
  }

  final TodoLocalStorageService _localStorageService;

  late final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(
    const [],
  );
  @override
  Future<void> saveTodo({required Todo todo, int? index}) async {
    final todos = [..._todoStreamController.value];

    final existingIndex = todos.indexWhere((t) => t.id == todo.id);

    if (existingIndex >= 0) {
      todos[existingIndex] = todo;

      if (index != null && index != existingIndex) {
        todos.removeAt(existingIndex);
        final insertIndex = index.clamp(0, todos.length);
        todos.insert(insertIndex, todo);
      }
    } else {
      final insertIndex = index?.clamp(0, todos.length) ?? todos.length;
      todos.insert(insertIndex, todo);
    }

    _todoStreamController.add(todos);
    await _localStorageService.setString(json.encode(todos));
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);
    if (todoIndex == -1) {
      throw TodoNotFoundException();
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      return _localStorageService.setString(json.encode(todos));
    }
  }

  @override
  Stream<List<Todo>> getTodos() => _todoStreamController.asBroadcastStream();

  @override
  Future<void> dispose() {
    return _todoStreamController.close();
  }
}
