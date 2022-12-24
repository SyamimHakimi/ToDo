import 'package:drift/drift.dart';

import '../database.dart';
import 'db_task.dart';

part 'db_task_dao.g.dart';

@DriftAccessor(tables: [Task])

class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {

  TaskDao(AppDatabase db) : super(db);

  Future<TaskData?> getObjectById(int id) => (select(task)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  /// Get List
  Future<List<TaskData>> getListPagination(int limit, int offset) =>
      (select(task)..orderBy([(tbl) => OrderingTerm(expression: tbl.id, mode: OrderingMode.desc)])
        ..limit(limit, offset: offset)).get();

  Stream<List<TaskData>> watchAllObjects() => select(task).watch();

  /// CRUD
  Future insertObject(Insertable<TaskData> object) =>
      into(task).insert(object);

  Future updateObject(Insertable<TaskData> object) =>
      update(task).replace(object);

  Future deleteObject(Insertable<TaskData> object) =>
      delete(task).delete(object);

  /// Save To-Do List
  Future<void> saveTaskData(int? taskId, TaskCompanion taskCompanion) async {
    try {
      TaskData? taskData = taskId != null ? await getObjectById(taskId) : null;

      if (taskData != null) {
        await updateObject(taskCompanion);
      } else {
        await insertObject(taskCompanion);
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Toggle Completed
  Future<void> toggleCompleted(int taskId, bool completed) async {
    try {
      await (update(task)..where((tbl) => tbl.id.equals(taskId))).write(TaskCompanion(
        completed: Value(completed),
      ));
    } catch (error) {
      rethrow;
    }
  }

  /// Delete Item
  Future<void> deleteTaskData(int taskId) async {
    try {
      TaskData? taskData = await getObjectById(taskId);

      if (taskData != null) {
        await deleteObject(taskData);
      }
    } catch (error) {
      rethrow;
    }
  }
}



