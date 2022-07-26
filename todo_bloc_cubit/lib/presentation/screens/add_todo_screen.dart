// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_bloc_cubit/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is AddTodoLoaded) {
            Navigator.pop(context);
            //it will remove the addto screen from stack.
          } else if (state is AddTodoError) {
            Toast.show(
              state.error,
              context,
              duration: 3,
              backgroundColor: Colors.red,
              gravity: Toast.CENTER,
            );
          }
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(hintText: "Enter todo message"),
        ),
        SizedBox(height: 15.0),
        InkWell(
            onTap: () {
              final message = _controller.text;
              BlocProvider.of<AddTodoCubit>(context).addTodo(message);
            },
            child: _addButton(context)),
      ],
    );
  }

  Widget _addButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddTodoLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Text(
              'Add Todo',
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
