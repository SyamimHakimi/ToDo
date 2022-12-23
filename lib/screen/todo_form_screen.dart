import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:to_do/db/database.dart';

import '../bloc/todo_bloc.dart';
import '../component/appbar/general_appbar.dart';
import '../component/button/general_button.dart';
import '../component/form/form_date.dart';
import '../component/form/form_text.dart';
import '../utils/app_constant.dart';
import '../utils/app_string.dart';

/// List all To-Do toDos
class ToDoFormScreen extends StatefulWidget {
  const ToDoFormScreen({Key? key}) : super(key: key);

  @override
  State<ToDoFormScreen> createState() => _ToDoFormScreenState();
}

class _ToDoFormScreenState extends State<ToDoFormScreen> {

  /// Bloc Context for Bloc Function
  BuildContext? _blocMainContext;

  /// Form Key
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  /// Value Holder for Form
  final TextEditingController _controllerTitle = TextEditingController();
  DateTime? _dateTimeStart;
  DateTime? _dateTimeEnd;
  
  @override
  void dispose(){
    _controllerTitle.dispose();
    super.dispose();
  }

  // /// Get Data from Object
  // Future<void> fromObject(toDoScreenModel toDoScreenModel) async {
  //   DprData? toDoData = toDoScreenModel.toDoData;
  //
  //   _toDoData = toDoData;
  //   _toDoDataActivity = toDoScreenModel.toDoDataActivity;
  //   _toDoDataInspection = toDoScreenModel.toDoDataInspectionView;
  //   _toDoDataRectification = toDoScreenModel.toDoDataRectificationView;
  //   _toDoDataEquipment = toDoScreenModel.toDoDataEquipmentView;
  //   _toDoDataRemark = toDoScreenModel.toDoDataRemark;
  //
  //   isNewObject = toDoScreenModel.isNewObject;
  //   rebuildSaveState(toDoScreenModel.authorizedAction);
  //
  //   if (toDoData != null) {
  //     /// Date Picker
  //     reportDateHolder = toDoData.report_date != null ? AppConstant.dateDatabaseToMobile(toDoData.report_date !) : null;
  //     lastUploadedDateHolder = toDoData.last_uploaded_date != null ? AppConstant.dateDatabaseToMobile(toDoData.last_uploaded_date !) : null;
  //   }
  // }
  /// Validate To-Do List
  /// Wrapper Function
  Future<bool> validateSave() async {
    if (_formKey.currentState!.validate()) {
      await saveObject();
      return true;
    } else {
      showToastError(context, formValidateError);
      return false;
    }
  }

  /// Save To-Do List
  Future<void> saveObject() async {

    TaskCompanion taskCompanion = TaskCompanion(
      task_title: drift.Value(_controllerTitle.text),
      start_date: drift.Value(_dateTimeStart),
      end_date: drift.Value(_dateTimeEnd),
    );

    if (_blocMainContext != null) {
      final toDoBloc = BlocProvider.of<ToDoBloc>(_blocMainContext!);
      toDoBloc.add(ToDoSaveEvent(buildContext: _blocMainContext!,
          taskId: null, taskCompanion: taskCompanion));
    }
  }

  /// Form Widget
  Widget formWidget() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding20),
      physics: const BouncingScrollPhysics(),
      child: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
            children: [
              FormText(
                  formTitle: toDoFormTitle,
                  textEditingController: _controllerTitle,
                  validatorsList: [FormBuilderValidators.required()]
              ), // To-Do List
              SizedBox(height: padding20),
              FormDate(
                formTitle: toDoFormStartDate,
                dateTime: _dateTimeStart,
                validatorsList: [FormBuilderValidators.required()],
                onDateChange: (dateTime) => _dateTimeStart = dateTime,
              ), // Start Date
              SizedBox(height: padding20),
              FormDate(
                formTitle: toDoFormEndDate,
                dateTime: _dateTimeEnd,
                validatorsList: [FormBuilderValidators.required(),
                      (value) =>
                      dateTimeLessThan(value, _dateTimeStart, toDoFormStartDate)
                ],
                onDateChange: (dateTime) => _dateTimeEnd = dateTime,
              ), // End Date
            ]
        ),
      ),
    );
  }

  /// Build Screen
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        appBar: appButton(toDoFormScreenTitle),
        body: BlocProvider(
          create: (context) => ToDoBloc(),
          child: BlocConsumer<ToDoBloc, ToDoState>(
            listener: (context, state) {
              if (state is ToDoLoaded) {
                showToastSuccess(context, state.message);
              } else if (state is ToDoError) {
                showToastError(context, state.message);
              }
            },
            builder: (blocContext, state) {
              _blocMainContext = blocContext;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(child: formWidget()),
                  textButton(toDoFormCreateTitle, validateSave),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}