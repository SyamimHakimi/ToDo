import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database.dart';
import '../db/database_provider.dart';

class TaskRepository implements Exception {

  /// Get the To-Do List through pagination
  Future<List<TaskData>> getList(BuildContext buildContext, int limit, int offset) async {
    DatabaseProvider db = Provider.of<DatabaseProvider>(buildContext, listen: false);

    try {
      return await db.db.taskDao.getListPagination(limit, offset);
    } catch(e){
      throw Exception("Failed to get To-Do List");
    }
  }

  /// Save To-Do List Data
  Future<void> saveToDo(BuildContext buildContext, int? taskId, TaskCompanion item) async {
    DatabaseProvider db = Provider.of<DatabaseProvider>(buildContext, listen: false);

    try {
      await db.db.taskDao.saveTaskData(taskId, item);
    } catch (error) {
      rethrow;
    }
  }

  /// Toggle Status To-Do List Data
  Future<void> toggleCompleted(BuildContext buildContext, int taskId, bool value) async {
    DatabaseProvider db = Provider.of<DatabaseProvider>(buildContext, listen: false);

    try {
      await db.db.taskDao.toggleCompleted(taskId, value);
    } catch (error) {
      rethrow;
    }
  }
}