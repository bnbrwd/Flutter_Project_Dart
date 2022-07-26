import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_cubit/data/models/todo.dart';
import 'package:todo_bloc_cubit/data/repository.dart';

part 'todos_state.dart';

// here we can emits all state to ui.

class TodosCubit extends Cubit<TodosState> {
  final Repository repository;

  TodosCubit({required this.repository}) : super(TodosInitial());

  void fetchTodos() {
    Timer(const Duration(seconds: 3), () {
      repository.fetchTodos().then((todos) {
        todos.forEach((element) {
          print('data emmitted= ${element.todoMessage}');
        });
        emit(TodosLoaded(todos));
      });
    });

    // repository.fetchTodos().then((todos) {
    // todos.forEach((element) {print('data emmitted= ${element.todoMessage}');});
    //   emit(TodosLoaded(todos));
    // });
  }

  void changeCompletion(Todo todo) {
    repository.changeCompletion(!todo.isCompleted, todo.id).then((isChanged) {
      if (isChanged) {
        todo.isCompleted = !todo.isCompleted;
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodosLoaded(currentState.todos));
    }
  }

  void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodosLoaded(todoList));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos.where((element) => element.id != todo.id).toList();
      emit(TodosLoaded(todoList));
    }
  }
}
