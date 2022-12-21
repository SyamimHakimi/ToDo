import 'package:drift/drift.dart';

import '../database.dart';
import 'db_task.dart';

part 'db_task_dao.g.dart';

@DriftAccessor(tables: [Task])

class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {

  TaskDao(AppDatabase db) : super(db);

  Future<List<TaskData>> getListPagination(int limit, int offset) =>
      (select(task)..orderBy([(tbl) => OrderingTerm(expression: tbl.id, mode: OrderingMode.desc)])
        ..limit(limit, offset: offset)).get();

  Stream<List<TaskData>> watchAllObjects() => select(task).watch();

  Future insertObject(Insertable<TaskData> object) =>
      into(task).insert(object);

  Future updateObject(Insertable<TaskData> object) =>
      update(task).replace(object);

  Future deleteObject(Insertable<TaskData> object) =>
      delete(task).delete(object);

  Future deleteAllObjects() => delete(task).go();
}



