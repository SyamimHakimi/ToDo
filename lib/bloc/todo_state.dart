part of 'todo_bloc.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();
}

class ToDoInitial extends ToDoState {
  @override
  List<Object> get props => [];
}

class ToDoLoading extends ToDoState {
  @override
  List<Object> get props => [];
}

class ToDoLoaded extends ToDoState {
  final String message;

  const ToDoLoaded(this.message);
  @override
  List<Object> get props => [message];
}

class ToDoError extends ToDoState {
  final String message;

  const ToDoError(this.message);
  @override
  List<Object> get props => [message];
}
