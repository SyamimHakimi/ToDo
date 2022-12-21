import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database.dart';
import '../db/database_provider.dart';

class TaskRepository implements Exception {

  /// Throws [Exception].
  Future<List<TaskData>> getData(BuildContext buildContext, int limit, int offset) async {
    DatabaseProvider db = Provider.of<DatabaseProvider>(buildContext, listen: false);

    try {
      return await db.db.taskDao.getListPagination(limit, offset);
    } catch(e){
      throw Exception("Failed to get Campaign List");
    }
  }
}