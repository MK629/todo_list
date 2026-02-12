import 'package:flutter/material.dart';
import 'package:todo_list/db/actions/db_worker.dart';
import 'package:todo_list/db/dtos/todo_item.dart';

class Todolist extends StatefulWidget {
  const Todolist({ super.key });

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {

  late Future<List<TodoItem>> todos;

  @override
  void initState() {
    super.initState();
    todos = DbWorker.getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: todos, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else{
          if(snapshot.hasData){
            return ListView(
              children: [
                for(TodoItem todoItem in snapshot.requireData)
                Row(
                  children: [
                    Text(todoItem.description),
                    Checkbox(
                      value: todoItem.done, 
                      onChanged: (value) {
                        todoItem.changeStatus(value!);
                        checkBoxClick(todoItem);
                      }, 
                    ),
                    IconButton(
                      onPressed: () {
                        deleteTodo(todoItem.id as int);
                      }, 
                      icon: Icon(Icons.delete)
                    )
                  ],
                )
              ]
            );
          }
          else{
            return Text("Nothing...");
          }
        }
      },
    );
  }

  //==============[ Internal helper functions ]==============

  void addTodo(String todoDesc) async {
    await DbWorker.insertNewTodo(TodoItem.makeInsertReadyObject(todoDesc));
    resetState();
  }

  void checkBoxClick(TodoItem updatedTodoItem) async {
    await DbWorker.updateTodo(updatedTodoItem);
    resetState();
  }

  void deleteTodo(int idToDelete) async {
    await DbWorker.deleteTodo(idToDelete);
    resetState();
  }

  void resetState(){
    setState(() {
      todos = DbWorker.getAllTodos();
    });
  }
}