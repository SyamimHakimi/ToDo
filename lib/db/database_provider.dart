import 'database.dart';

class DatabaseProvider implements Exception {
  final AppDatabase db;

  DatabaseProvider() : db = AppDatabase.connect(createDriftIsolateAndConnect());

  void close() {
    db.close();
  }
}