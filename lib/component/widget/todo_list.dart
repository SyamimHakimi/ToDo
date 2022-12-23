import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/screen/todo_list_screen.dart';

import '../../bloc/todo_bloc.dart';
import '../../db/database.dart';
import '../../screen/todo_form_screen.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_string.dart';
import '../form/form_checkbox.dart';
import 'date_countdown.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({
    required this.item,
    required this.refreshAction,
    Key? key,
  })  : super(key: key);

  final TaskData item;
  final VoidCallback refreshAction;

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {

  /// Bloc Context for Bloc Function
  BuildContext? _blocMainContext;
  bool? currentState;

  @override
  void initState() {
    currentState = widget.item.completed;

    super.initState();
  }

  /// Update To-Do List
  void goToDoForm(TaskData taskData) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ToDoFormScreen(taskData: taskData)));
    if (result is bool && result) {
      widget.refreshAction();
    }
  }
  
  /// Toggle completed status
  void toggleCompleted(int taskId, bool value) {
    if (_blocMainContext != null) {
      final toDoBloc = BlocProvider.of<ToDoBloc>(_blocMainContext!);
      toDoBloc.add(ToDoToggleEvent(buildContext: _blocMainContext!,
          taskId: taskId, value: value));
    }
  }

  /// Main Body
  Widget _mainBody(TaskData item) {
    String dateTimesStartString = item.start_date != null ? dateFormatWord.format(item.start_date!) : "-";
    String dateTimesEndString = item.end_date != null ? dateFormatWord.format(item.end_date!) : "-";

    return Container(
      padding: EdgeInsets.all(padding16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusCard)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(item.task_title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height:padding16),
          Row(
            children: [
              _itemTitle(toDoFormStartDate),
              _itemTitle(toDoFormEndDate),
              _itemTitle(toDoFormTimeLeft),
            ],
          ),
          Row(
            children: [
              _itemValue(dateTimesStartString),
              _itemValue(dateTimesEndString),
              Expanded(child: DateCountdown(dateEnd: item.end_date,
                  textStyle: Theme.of(context).textTheme.titleSmall!)),
            ],
          )
        ]
      ),
    );
  }

  Widget _trailingBody(TaskData item) {
    String completed = generalIncomplete;
    if (currentState != null && currentState!) {
      completed = generalCompleted;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding16),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusCard)),
      ),
      child: Row(
          children: [
            Text(generalStatus, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey)),
            SizedBox(width: padding),
            Text(completed, style: Theme.of(context).textTheme.titleMedium),
            Expanded(child: FormCheckBox(formTitle: toDoListTick,
              initialValue: item.completed,
              onBoolChange: (value) {
                if (value != null) toggleCompleted(item.id, value);
              },
            )),
          ]
      ),
    );
  }

  /// Row Child
  Widget _itemTitle(String title) => _itemRow(title, Theme.of(context).textTheme.titleSmall
      ?.copyWith(color: Colors.grey));
  Widget _itemValue(String title) => _itemRow(title, Theme.of(context).textTheme.titleSmall);

  Widget _itemRow(String title, TextStyle? textStyle) {
    return Expanded(child: Text(title, style: textStyle));
  }

  /// To-Do Task Widget
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToDoForm(widget.item),

      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radiusCard)),
            boxShadow: shadowCard
        ),
        child: BlocProvider(
          create: (context) => ToDoBloc(),
          child: BlocConsumer<ToDoBloc, ToDoState>(
            listener: (context, state) {
              if (state is ToDoLoaded) {
                showToastSuccess(context, state.message);
              } else if (state is ToDoError) {
                showToastError(context, state.message);
              } else if (state is ToDoToggled) {
                currentState = state.value;
              }
            },
            builder: (blocContext, state) {
              _blocMainContext = blocContext;

              return Column(
                children: [
                  _mainBody(widget.item),
                  _trailingBody(widget.item)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
