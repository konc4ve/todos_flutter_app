import 'package:todo/data/models/todo.dart';

abstract interface class TodosRepository {
  Stream<List<Todo>> getTodos();

  Future<void> saveTodo({required Todo todo, int? index});

  Future<void> deleteTodo(String id);

  Future<void> dispose();
}

class TodoNotFoundException implements Exception {}
