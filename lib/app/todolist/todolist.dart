import 'package:flutter/material.dart';
import 'package:todo_list/db/actions/db_worker.dart';
import 'package:todo_list/db/dtos/todo_item.dart';
import 'package:todo_list/ui/styles.dart';

class Todolist extends StatefulWidget {
  const Todolist({ super.key });

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {

  late Future<List<TodoItem>> todos;

  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todos = DbWorker.getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: Colors.white,
                style: textStyle(),
                decoration: inputDecoration(),
                autocorrect: true,
                controller: inputController,
                textInputAction: TextInputAction.none,
              ),
            ),
            IconButton(
              onPressed: (){
                final text = inputController.text;
                if(text.isEmpty) return;
                addTodo(text);
                inputController.clear();
              },
              style: buttonStyle(),
              icon: Icon(Icons.add)
            )
          ],
        ),
        Expanded(
          child: FutureBuilder(
            future: todos, 
            builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView(
                    children: [
                      for(TodoItem todoItem in snapshot.requireData)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${snapshot.requireData.indexOf(todoItem) + 1}. ${todoItem.description}',
                                  style: textStyle(),
                                )),
                              Checkbox(
                                checkColor: Colors.black,
                                fillColor: WidgetStateProperty.resolveWith((state){
                                  if(state.contains(WidgetState.selected)){
                                    return Colors.white;
                                  }
                                  else{
                                    return Colors.black;
                                  }
                                }),
                                value: todoItem.done, 
                                onChanged: (value) {
                                  todoItem.changeStatus(value!);
                                  checkBoxClick(todoItem);
                                }, 
                              ),
                              IconButton(
                                style: buttonStyle(),
                                onPressed: () {
                                  deleteTodo(todoItem.id as int);
                                }, 
                                icon: Icon(Icons.delete)
                              )
                            ],
                          ),
                          Divider(color: Colors.white, thickness: 1, height: 1,)
                        ],
                      )
                    ]
                  );
                }
                else{
                  return Text("Nothing...");
                }
              }
          ),
        ),
      ],
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
