import 'package:flutter/material.dart';
import 'package:todo_list/app/todolist/todolist.dart';

class Root extends StatelessWidget {
  const Root({ super.key });

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: AppBody(),
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
    );
  }
}

class AppBody extends StatelessWidget{
  const AppBody({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Todolist(),
        ),
      )
    );
  }
}     