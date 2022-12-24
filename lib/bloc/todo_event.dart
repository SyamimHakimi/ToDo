part of 'todo_bloc.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
}

class ToDoSaveEvent extends ToDoEvent {
  final BuildContext buildContext;
  final int? taskId;
  final TaskCompanion taskCompanion;

  const ToDoSaveEvent({
    required this.buildContext,
    required this.taskId,
    required this.taskCompanion,
  });

  @override
  List<Object> get props => [buildContext, taskCompanion];

}

class ToDoToggleEvent extends ToDoEvent {
  final BuildContext buildContext;
  final int taskId;
  final bool value;

  const ToDoToggleEvent({
    required this.buildContext,
    required this.taskId,
    required this.value,
  });

  @override
  List<Object> get props => [buildContext, taskId, value];

}

class ToDoDeleteEvent extends ToDoEvent {
  final BuildContext buildContext;
  final int taskId;

  const ToDoDeleteEvent({
    required this.buildContext,
    required this.taskId,
  });

  @override
  List<Object> get props => [buildContext, taskId];

}
