// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class TaskData extends DataClass implements Insertable<TaskData> {
  final int id;
  final String task_title;
  final DateTime? start_date;
  final DateTime? end_date;
  const TaskData(
      {required this.id,
      required this.task_title,
      this.start_date,
      this.end_date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_title'] = Variable<String>(task_title);
    if (!nullToAbsent || start_date != null) {
      map['start_date'] = Variable<DateTime>(start_date);
    }
    if (!nullToAbsent || end_date != null) {
      map['end_date'] = Variable<DateTime>(end_date);
    }
    return map;
  }

  TaskCompanion toCompanion(bool nullToAbsent) {
    return TaskCompanion(
      id: Value(id),
      task_title: Value(task_title),
      start_date: start_date == null && nullToAbsent
          ? const Value.absent()
          : Value(start_date),
      end_date: end_date == null && nullToAbsent
          ? const Value.absent()
          : Value(end_date),
    );
  }

  factory TaskData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<int>(json['id']),
      task_title: serializer.fromJson<String>(json['task_title']),
      start_date: serializer.fromJson<DateTime?>(json['start_date']),
      end_date: serializer.fromJson<DateTime?>(json['end_date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'task_title': serializer.toJson<String>(task_title),
      'start_date': serializer.toJson<DateTime?>(start_date),
      'end_date': serializer.toJson<DateTime?>(end_date),
    };
  }

  TaskData copyWith(
          {int? id,
          String? task_title,
          Value<DateTime?> start_date = const Value.absent(),
          Value<DateTime?> end_date = const Value.absent()}) =>
      TaskData(
        id: id ?? this.id,
        task_title: task_title ?? this.task_title,
        start_date: start_date.present ? start_date.value : this.start_date,
        end_date: end_date.present ? end_date.value : this.end_date,
      );
  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('task_title: $task_title, ')
          ..write('start_date: $start_date, ')
          ..write('end_date: $end_date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, task_title, start_date, end_date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.task_title == this.task_title &&
          other.start_date == this.start_date &&
          other.end_date == this.end_date);
}

class TaskCompanion extends UpdateCompanion<TaskData> {
  final Value<int> id;
  final Value<String> task_title;
  final Value<DateTime?> start_date;
  final Value<DateTime?> end_date;
  const TaskCompanion({
    this.id = const Value.absent(),
    this.task_title = const Value.absent(),
    this.start_date = const Value.absent(),
    this.end_date = const Value.absent(),
  });
  TaskCompanion.insert({
    this.id = const Value.absent(),
    required String task_title,
    this.start_date = const Value.absent(),
    this.end_date = const Value.absent(),
  }) : task_title = Value(task_title);
  static Insertable<TaskData> custom({
    Expression<int>? id,
    Expression<String>? task_title,
    Expression<DateTime>? start_date,
    Expression<DateTime>? end_date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (task_title != null) 'task_title': task_title,
      if (start_date != null) 'start_date': start_date,
      if (end_date != null) 'end_date': end_date,
    });
  }

  TaskCompanion copyWith(
      {Value<int>? id,
      Value<String>? task_title,
      Value<DateTime?>? start_date,
      Value<DateTime?>? end_date}) {
    return TaskCompanion(
      id: id ?? this.id,
      task_title: task_title ?? this.task_title,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (task_title.present) {
      map['task_title'] = Variable<String>(task_title.value);
    }
    if (start_date.present) {
      map['start_date'] = Variable<DateTime>(start_date.value);
    }
    if (end_date.present) {
      map['end_date'] = Variable<DateTime>(end_date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskCompanion(')
          ..write('id: $id, ')
          ..write('task_title: $task_title, ')
          ..write('start_date: $start_date, ')
          ..write('end_date: $end_date')
          ..write(')'))
        .toString();
  }
}

class $TaskTable extends Task with TableInfo<$TaskTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _task_titleMeta =
      const VerificationMeta('task_title');
  @override
  late final GeneratedColumn<String> task_title = GeneratedColumn<String>(
      'task_title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _start_dateMeta =
      const VerificationMeta('start_date');
  @override
  late final GeneratedColumn<DateTime> start_date = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _end_dateMeta =
      const VerificationMeta('end_date');
  @override
  late final GeneratedColumn<DateTime> end_date = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, task_title, start_date, end_date];
  @override
  String get aliasedName => _alias ?? 'task';
  @override
  String get actualTableName => 'task';
  @override
  VerificationContext validateIntegrity(Insertable<TaskData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_title')) {
      context.handle(
          _task_titleMeta,
          task_title.isAcceptableOrUnknown(
              data['task_title']!, _task_titleMeta));
    } else if (isInserting) {
      context.missing(_task_titleMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
          _start_dateMeta,
          start_date.isAcceptableOrUnknown(
              data['start_date']!, _start_dateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_end_dateMeta,
          end_date.isAcceptableOrUnknown(data['end_date']!, _end_dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      task_title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_title'])!,
      start_date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      end_date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
    );
  }

  @override
  $TaskTable createAlias(String alias) {
    return $TaskTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $TaskTable task = $TaskTable(this);
  late final TaskDao taskDao = TaskDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [task];
}
