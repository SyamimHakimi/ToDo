import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:to_do/db/database.dart';
import 'package:to_do/function/task_repository.dart';
import 'package:to_do/screen/todo_form_screen.dart';

import '../bloc/todo_bloc.dart';
import '../component/appbar/general_appbar.dart';
import '../component/form/form_checkbox.dart';
import '../component/widget/date_countdown.dart';
import '../component/widget/todo_list.dart';
import '../utils/app_constant.dart';
import '../utils/app_string.dart';

/// List all To-Do Tasks
class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => ToDoListScreenState();
}

class ToDoListScreenState extends State<ToDoListScreen> {

  TaskRepository taskRepository = TaskRepository();

  /// PagingController<index, ReturnObject> for controlling the list
  final PagingController<int, TaskData> _pagingController = PagingController(firstPageKey: 0);

  /// Add listeners on screen creation
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  /// Dispose controllers
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  /// Refresh List
  void refresh() {
    _pagingController.refresh();
  }

  /// On Quit
  Future<bool> onQuit() async {
    return await showAppDialog(context,
        alertDialog(context, dialogQuitTitle, dialogQuitSubTitle, () => exit(0)));
  }

  /// Fetch To-Do List
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await taskRepository.getList(context, pageSize, pageKey);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  /// Create To-Do List
  void goToDoForm() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ToDoFormScreen(taskData: null)));
    if (result is bool && result) {
      refresh();
    }
  }

  /// To-Do List Widget
  Widget _listView() {
    return PagedListView<int, TaskData>.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<TaskData>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return ToDoList(item: item, refreshAction: refresh);
        },
      ),
      separatorBuilder: (context, index) => SizedBox(height: padding20),
    );
  }

  /// Build Screen
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onQuit,

      child: Scaffold(
        appBar: appButton(toDoListScreenTitle),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(padding20),
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(() => refresh()), // Refresh method
                  child: _listView()
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: goToDoForm,
          backgroundColor: tertiaryColor,
          child: const Icon(Icons.add),
        ), // Create Task Button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}