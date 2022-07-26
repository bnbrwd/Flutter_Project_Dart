part of 'add_todo_cubit.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}

class AddTodoError extends AddTodoState {
  final String error;

  AddTodoError({required this.error});
}

//AddingTodo
class AddTodoLoading extends AddTodoState {}

//TodoAdded
class AddTodoLoaded extends AddTodoState {}

