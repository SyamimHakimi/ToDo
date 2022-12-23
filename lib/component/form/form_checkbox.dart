import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../utils/app_constant.dart';
import '../../utils/app_string.dart';

class FormCheckBox extends StatelessWidget {
  const FormCheckBox({
    required this.formTitle,
    required this.onBoolChange,
    required this.initialValue,
    Key? key,
  })  : super(key: key);

  final String formTitle;
  final void Function(bool?)? onBoolChange;
  final bool? initialValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: formTitle,
      title: Text(toDoListTick, textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyMedium),
      activeColor: primaryColor,
      checkColor: Colors.black,
      controlAffinity: ListTileControlAffinity.trailing,
      decoration: const InputDecoration(border: InputBorder.none,
          contentPadding: EdgeInsets.zero),
      onChanged: onBoolChange,
      initialValue: initialValue,
    );
  }
}
