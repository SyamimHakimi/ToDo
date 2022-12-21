import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:to_do/db/database.dart';
import 'package:to_do/function/task_repository.dart';

import '../component/appbar/general_appbar.dart';
import '../component/button/general_button.dart';
import '../utils/app_constant.dart';
import '../utils/app_string.dart';

/// List all To-Do Tasks
class ToDoFormScreen extends StatefulWidget {
  const ToDoFormScreen({Key? key}) : super(key: key);

  @override
  State<ToDoFormScreen> createState() => _ToDoFormScreenState();
}

class _ToDoFormScreenState extends State<ToDoFormScreen> {

  /// Build Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appButton(toDoFormScreenTitle),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: Container(
            color: Colors.white,
              child: Text("Form")
          )),
          textButton(toDoFormCreateTitle, () => print("LOL")),
        ],
      ),
    );
  }
}