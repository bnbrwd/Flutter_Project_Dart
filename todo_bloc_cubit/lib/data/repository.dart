import 'package:todo_bloc_cubit/data/models/todo.dart';
import 'package:todo_bloc_cubit/data/network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future<List<Todo>> fetchTodos() async {
    //  final todosRaw =await networkService.fetchTodos();
    final tosoRaw = await networkService.fetchTodos();
    //  return todosRaw.map((e) => Todo.fromJson(e).toList());
    return tosoRaw.map((element) => Todo.fromJson(element)).toList();
  }

  //PUT call update entire data. but PATCH call update attribure.
  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await networkService.pathTodo(patchObj, id);
  }

  Future<Todo> addTodo(String message) async {
    final todoObj = {"todo": message, "isCompleted": "false"};
    final todoMap = await networkService.addTodo(todoObj);
    return Todo.fromJson(todoMap);
  }

  Future<bool> deleteTodo(int id) async{
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async{
    final patchObj = {"todo": message};
    return await networkService.pathTodo(patchObj, id);
  }
}
