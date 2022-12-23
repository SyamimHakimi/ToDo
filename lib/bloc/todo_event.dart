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
