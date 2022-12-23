import 'package:drift/drift.dart';

// ignore_for_file: non_constant_identifier_names

class Task extends Table {
  // autoIncrement automatically sets this to be the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get task_title => text().withLength(min: 0, max: 200)();
  DateTimeColumn get start_date => dateTime().nullable()();
  DateTimeColumn get end_date => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false)).nullable()();
}