import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // for JSON encoding/decoding

class TodoNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    _loadTodos();
    return [];
  }

  Future<void> _loadTodos() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final String? storedTodos = prefs.getString('todos');

    if (storedTodos != null) {
      state = (jsonDecode(storedTodos) as List)
          .map((item) => Todo.fromJson(item))
          .toList();
    }
  }

  void addTodo(String title) {
    state = [...state, Todo(title: title)];
    _saveTodos();
  }

  void toggleTodoStatus(int index) {
    state[index].isCompleted = !state[index].isCompleted;
    state = [...state]; // Just to notify listeners
    _saveTodos();
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('todos', jsonEncode(state.map((e) => e.toJson()).toList()));
  }
}

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(() {
  return TodoNotifier();
});
