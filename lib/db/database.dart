import 'dart:isolate';

// import 'package:intellex/model/db/_db_dao.dart';
// import 'package:intellex/model/db/_db_model.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'dart:io';

import '../utils/app_constant.dart';
import 'model/db_task.dart';
import 'model/db_task_dao.dart';

part 'database.g.dart';

//Import all the table used
@DriftDatabase(
    tables: [Task],
    daos: [TaskDao]
)
// _$AppDatabase is the name of the generated class
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  // Bump this when changing tables and columns.
  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
      },

      beforeOpen: (details) async {
        // if (details.wasCreated) {
        //   // ...
        // }
        await customStatement('PRAGMA foreign_keys = ON');
      }
  );
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, databaseName));
    return NativeDatabase(file, logStatements: true);
  });
}

/// Isolate

Future<DriftIsolate> _createDriftIsolate() async {
  // this method is called from the main isolate. Since we can't use
  // getApplicationDocumentsDirectory on a background isolate, we calculate
  // the database path in the foreground isolate and then inform the
  // background isolate about the path.
  final dbFolder = await getApplicationDocumentsDirectory();
  final path = p.join(dbFolder.path, databaseName);
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  // _startBackground will send the DriftIsolate to this ReceivePort
  return await receivePort.first as DriftIsolate;
}

void _startBackground(_IsolateStartRequest request) {
  // this is the entry point from the background isolate! Let's create
  // the database from the path we received
  final executor = NativeDatabase(File(request.targetPath), logStatements: true);
  // we're using DriftIsolate.inCurrent here as this method already runs on a
  // background isolate. If we used DriftIsolate.spawn, a third isolate would be
  // started which is not what we want!
  final driftIsolate = DriftIsolate.inCurrent(
        () => DatabaseConnection(executor),
  );
  // inform the starting isolate about this, so that it can call .connect()
  request.sendDriftIsolate.send(driftIsolate);
}

DatabaseConnection createDriftIsolateAndConnect() {
  return DatabaseConnection.delayed(() async {
    final isolate = await _createDriftIsolate();
    return await isolate.connect();
  }());
}

// used to bundle the SendPort and the target path, since isolate entry point
// functions can only take one parameter.
class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

