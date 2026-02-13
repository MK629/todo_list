import 'package:flutter/material.dart';
import 'package:todo_list/app/root.dart';
import 'package:todo_list/db/actions/db_worker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbWorker.initDb();
  runApp(const Root());
}
