
import 'package:flutter/material.dart';

class Task {
  String title;
  bool isDone;
  Task({required this.title, required this.isDone});
}

class TaskData extends ChangeNotifier{
  List<Task> listTask = [
    Task(title: 'Buy milk', isDone: false),
    Task(title: 'Buy ColdDrink', isDone: false),
    Task(title: 'Buy Cloth', isDone: false),
  ];

  toggle(int index, bool value){
    listTask[index].isDone = value;
    notifyListeners(); // changes reach every where
  }
}