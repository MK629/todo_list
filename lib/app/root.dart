import 'package:flutter/material.dart';
import 'package:todo_list/app/add_todo_button/add_todo_button.dart';
import 'package:todo_list/app/todolist/todolist.dart';

class Root extends StatelessWidget {
  const Root({ super.key });

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: AppBody(),
    );
  }
}

class AppBody extends StatelessWidget{
  const AppBody({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AddTodoButton(),
          Expanded(
            child: Todolist()
          )
        ],
      ),
    );
  }
}     