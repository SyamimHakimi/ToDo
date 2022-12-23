import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../utils/app_constant.dart';
import '../../utils/app_string.dart';

class FormText extends StatelessWidget {
  const FormText({
    required this.formTitle,
    required this.textEditingController,
    required this.validatorsList,
    Key? key,
  })  : super(key: key);

  final String formTitle;
  final TextEditingController textEditingController;
  final List<String? Function(String?)> validatorsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(formTitle, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: padding),
        FormBuilderTextField(
          name: formTitle,
          controller: textEditingController,
          validator: FormBuilderValidators.compose(validatorsList),
          decoration: formDecoration(toDoFormTextHint(formTitle)),
          keyboardType: TextInputType.text,
          maxLines: 4,
        ),
      ],
    );
  }
}
