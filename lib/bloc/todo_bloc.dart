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
    /// On Save
    on<ToDoSaveEvent>((event, emit) async {
      try {
        emit(ToDoLoading());
        await taskRepository.saveToDo(event.buildContext, event.taskId, event.taskCompanion);
        emit(const ToDoLoaded(toDoFormSuccess));
      } on Exception catch (e) {
        emit(ToDoError(e.toString()));
      }
    });

    /// On Toggle Status
    on<ToDoToggleEvent>((event, emit) async {
      try {
        emit(ToDoLoading());
        /// Select the message appropriate to the action
        String successMessage;
        if (event.value) {
          successMessage = toDoTaskCompleted;
        } else { successMessage = toDoTaskIncomplete; }

        await taskRepository.toggleCompleted(event.buildContext, event.taskId, event.value);
        emit(ToDoLoaded(successMessage));
        emit(ToDoToggled(event.value));
      } on Exception catch (e) {
        emit(ToDoError(e.toString()));
      }
    });

    /// On Delete
    on<ToDoDeleteEvent>((event, emit) async {
      try {
        emit(ToDoLoading());
        await taskRepository.deleteToDo(event.buildContext, event.taskId);
        emit(const ToDoLoaded(toDoFormSuccessDelete));
        emit(ToDoDeleted());
      } on Exception catch (e) {
        emit(ToDoError(e.toString()));
      }
    });
  }
}
