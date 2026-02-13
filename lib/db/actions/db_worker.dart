import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/db/dtos/todo_item.dart';

class DbWorker {
  static late Database? database;

  static Future<void> initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'todoDatabase.db'),
      onCreate: (db, version){
        db.execute('''
        CREATE TABLE todos ( 
          id INTEGER PRIMARY KEY, 
          description TEXT NOT NULL, 
          done BOOLEAN NOT NULL CHECK (done IN (0, 1))
        );
        ''');
      },
      version: 1
    );
  }

  static Future<void> insertNewTodo(TodoItem newTodoItem) async {
    _dbAvailabilityCheck(database);

    database?.insert('todos', newTodoItem.toInsertMap());
  }

  static Future<void> updateTodo(TodoItem updatedTodoItem) async {
    _dbAvailabilityCheck(database);

    database?.update('todos', updatedTodoItem.toUpdateMap(), where: 'id = ?', whereArgs: [updatedTodoItem.id]);
  }

  static Future<void> deleteTodo(int idToDelete) async {
    _dbAvailabilityCheck(database);

    database?.delete('todos', where: 'id = ?', whereArgs: [idToDelete]);
  }

  static Future<List<TodoItem>> getAllTodos() async {
    _dbAvailabilityCheck(database);

    List<TodoItem> allTodos = [];

    List<Map<String, Object?>>? dbResult = await database?.query('todos');

    if(dbResult != null && dbResult.isNotEmpty){
      for(Map<String, Object?> dbItem in dbResult){
        allTodos.add(TodoItem.makeObjectFromMap(dbItem));
      }
    }

    return allTodos;
  }

  static void _dbAvailabilityCheck(Database? database){
    if(database == null){
      throw Exception("Database not initialised. Run initDb() first.");
    }
  }
}