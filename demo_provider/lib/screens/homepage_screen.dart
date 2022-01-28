import '../providers/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Provider'),
      ),
      body: ListView.builder(
        itemCount: taskData.listTask.length,
        itemBuilder: (ctx, index) {
          return Card(
            // ignore: prefer_const_constructors
            margin: EdgeInsets.all(5),
            child: ListTile(
              title: Text(taskData.listTask[index].title),
              trailing: Checkbox(
                value: taskData.listTask[index].isDone,
                onChanged: (value) {
                  // taskData.listTask[index].isDone = value!;
                  taskData.toggle(index, value!);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
