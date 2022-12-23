import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../utils/app_constant.dart';
import '../../utils/app_string.dart';
//
// import '../../utils/app_constant.dart';
// import '../../utils/app_widget_form.dart';
//
// /// Wrapper for stateful functionality to provide onInit calls in stateless widget
// class FormDateCupertinoGroupWrapper extends StatefulWidget {
//   const FormDateCupertinoGroupWrapper({
//     required this.formTitle,
//     required this.onClearAll,
//     required this.dateTime,
//     required this.textEditingController,
//     required this.onDateChange,
//     this.validatorsList = const [],
//     this.isEnabled = true,
//     this.isMandatory = false,
//     Key? key,
//   }) : super(key: key);
//
//   final String formTitle;
//   final VoidCallback onClearAll;
//   final Function(DateTime?) onDateChange;
//   final DateTime? dateTime;
//   final TextEditingController textEditingController;
//   final List<String? Function(DateTime?)> validatorsList;
//   final bool isEnabled;
//   final bool isMandatory;
//
//   @override
//   FormDateCupertinoGroupWrapperState createState() => FormDateCupertinoGroupWrapperState();
// }
// class FormDateCupertinoGroupWrapperState extends State<FormDateCupertinoGroupWrapper> {
//   @override
//   void initState() {
//     if (widget.dateTime != null) {
//       widget.textEditingController.text = AppConstant.dateFormat.format(widget.dateTime!);
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FormDateCupertinoGroup(
//       formTitle: widget.formTitle,
//       onClearAll: widget.onClearAll,
//       dateTime: widget.dateTime,
//       textEditingController: widget.textEditingController,
//       onDateChange: widget.onDateChange,
//       isEnabled: widget.isEnabled,
//       isMandatory: widget.isMandatory,
//       validatorsList: widget.validatorsList,
//     );
//   }
// }
//
//
// /// Groups choice chips and assigns a label to the group.
// class FormDateCupertinoGroup extends StatelessWidget {
//   const FormDateCupertinoGroup({
//     required this.formTitle,
//     required this.onClearAll,
//     required this.dateTime,
//     required this.textEditingController,
//     required this.onDateChange,
//     this.validatorsList = const [],
//     this.isEnabled = true,
//     this.isMandatory = false,
//     Key? key,
//   })  : super(key: key);
//
//   final String formTitle;
//   final VoidCallback onClearAll;
//   final Function(DateTime?) onDateChange;
//   final DateTime? dateTime;
//   final TextEditingController textEditingController;
//   final List<String? Function(DateTime?)> validatorsList;
//   final bool isEnabled;
//   final bool isMandatory;
//
//   bool get _hasSelectedItems {
//     return dateTime != null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppConstant.paddingTextDouble,
//           vertical: AppConstant.paddingDouble),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           formHeader(context, formTitle, iconCalendar, isMandatory, isEnabled,
//               hasSelectedItem: _hasSelectedItems, onClearAll: onClearAll),
//           const SizedBox(height: AppConstant.paddingGridDouble),
//           FormDate(
//             formTitle: formTitle,
//             textEditingController: textEditingController,
//             onDateChange: onDateChange,
//             dateTime: dateTime,
//             validatorsList: validatorsList,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
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
