import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../utils/app_constant.dart';
import '../../utils/app_string.dart';

class FormDate extends StatelessWidget {
  const FormDate({
    required this.formTitle,
    // required this.textEditingController,
    required this.onDateChange,
    this.validatorsList = const [],
    this.dateTime,
    Key? key,
  })  : super(key: key);

  final String formTitle;
  // final TextEditingController textEditingController;
  final Function(DateTime?) onDateChange;
  final List<String? Function(DateTime?)> validatorsList;
  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(formTitle, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: padding),
        FormBuilderDateTimePicker(
          name: formTitle,
          // controller: textEditingController,
          inputType: InputType.date,
          decoration: formDecoration(toDoFormDateHint),
          format: dateFormat,
          onChanged: onDateChange,
          initialValue: dateTime,
          validator: FormBuilderValidators.compose(validatorsList),
        ),
      ],
    );
  }
}
