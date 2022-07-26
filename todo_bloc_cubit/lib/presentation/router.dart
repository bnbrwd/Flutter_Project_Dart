import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_cubit/constant/strings.dart';
import 'package:todo_bloc_cubit/cubit/add_todo_cubit.dart';
import 'package:todo_bloc_cubit/cubit/edit_todo_cubit.dart';
import 'package:todo_bloc_cubit/cubit/todos_cubit.dart';
import 'package:todo_bloc_cubit/data/models/todo.dart';
import 'package:todo_bloc_cubit/data/network_service.dart';
import 'package:todo_bloc_cubit/data/repository.dart';
import 'package:todo_bloc_cubit/presentation/screens/add_todo_screen.dart';
import 'package:todo_bloc_cubit/presentation/screens/edit_todo_screen.dart';
import 'package:todo_bloc_cubit/presentation/screens/todos_screen.dart';

//note: if we use BlocProvider only
//let your app has few screens and all these screens share some data and data retrive from cubit.
//and if wrap with each widgets by BlocProvider having new instance of cubit and same data wii not be shared.
//because each of widget will have different instances of cubit and it will have different data
// so we can use BlocProvider.value, it provide copy of a cubit to different widgets

class AppRouter {
  // Repository repository = Repository(networkService: NetworkService());
  late Repository repository;
  late TodosCubit todosCubit;
  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            //by wraping with BlocProvider we can listen data that emitted by cubit
            builder: (_) => BlocProvider.value(
                  value: todosCubit,
                  child: TodosScreen(),
                ));
      // this is home screen / means default home screen. _ means context but not required now.
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          //by wraping with BlocProvider we can listen data that emitted by cubit
          builder: (_) => BlocProvider(
            create: (context) =>
                EditTodoCubit(repository: repository, todosCubit: todosCubit),
            //now TodosCubit is available for entire TodosScreen widget.
            child: EditTodoScreen(todo: todo),
          ),
        );
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
          //by wraping with BlocProvider we can listen data that emitted by cubit
          builder: (_) => BlocProvider(
            create: (context) =>
                AddTodoCubit(repository: repository, todosCubit: todosCubit),
            //now TodosCubit is available for entire TodosScreen widget.
            child: AddTodoScreen(),
          ),
        );
      default:
        return null;
    }
  }
}













// for reference
// Route? generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(
//             //by wraping with BlocProvider we can listen data that emitted by cubit
//             builder: (_) => BlocProvider(
//                   create: (context) => TodosCubit(repository: repository),
//                   //now TodosCubit is available for entire TodosScreen widget.
//                   child: TodosScreen(),
//                 ));
//       // this is home screen / means default home screen. _ means context but not required now.
//       case EDIT_TODO_ROUTE:
//         return MaterialPageRoute(builder: (_) => EditTodoScreen());
//       case ADD_TODO_ROUTE:
//         return MaterialPageRoute(
//             //by wraping with BlocProvider we can listen data that emitted by cubit
//             builder: (_) => BlocProvider(
//                   create: (context) => AddTodoCubit(repository: repository, todosCubit: ),
//                   //now TodosCubit is available for entire TodosScreen widget.
//                   child: AddTodoScreen(),
//                 ));
//       default:
//         return null;
//     }
//   }