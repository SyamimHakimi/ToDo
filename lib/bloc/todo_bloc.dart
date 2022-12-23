import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../db/database.dart';
import '../function/task_repository.dart';
import '../utils/app_string.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  TaskRepository taskRepository = TaskRepository();

  ToDoBloc() : super(ToDoInitial()) {
    on<ToDoSaveEvent>((event, emit) async {

      try {
        emit(ToDoLoading());
        await taskRepository.saveToDo(event.buildContext, event.taskId, event.taskCompanion);
        emit(const ToDoLoaded(toDoFormSuccess));
      } on Exception catch (e) {
        emit(ToDoError(e.toString()));
      }
    });
  }
}
