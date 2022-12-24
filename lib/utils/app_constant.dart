import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_string.dart';

/// Database
String databaseName = 'etiqaTodoDB.sqlite';
int pageSize = 20;

/// UI Helper
double padding = 8;
double padding16 = 16;
double padding20 = 20;

double radiusCard = 8;

List<BoxShadow> shadowCard = <BoxShadow>[
  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10.0),
];

DateFormat dateFormat = DateFormat.yMd('en_GB');
DateFormat dateFormatWord = DateFormat.yMMMd('en_GB');

/// Form UI
InputDecoration formDecoration(String hint) {

  return InputDecoration(
    hintText: hint,
    border: outlineBorderInputFieldBasicFilter,
  );
}

BorderRadius borderRadiusInputFieldFilter = BorderRadius.circular(4);

OutlineInputBorder outlineBorderInputFieldBasicFilter = OutlineInputBorder(
  borderRadius: borderRadiusInputFieldFilter,
);

/// Form Validation
String? dateTimeLessThan(DateTime? mainValue, DateTime? otherValue, String otherFieldName) {
  if (mainValue != null && otherValue != null && otherValue.isAfter(mainValue)) {
    return '$formValidationLessThan $otherFieldName';
  }
  return null;
}

/// Toast
void showToastError(BuildContext context, String text) {
  context.showErrorBar(
    duration: const Duration(seconds: 2),
    content: Text(text, overflow: TextOverflow.visible, textAlign: TextAlign.center),
  );
}

void showToastSuccess(BuildContext context, String text) {
  context.showSuccessBar(
    duration: const Duration(seconds: 2),
    content: Text(text, overflow: TextOverflow.visible, textAlign: TextAlign.center),
  );
}

/// Dialog
Future showAppDialog(BuildContext context, Widget targetDialog, {bool barrierDismissible = false}) {
  return showGeneralDialog(
      context: context,
      pageBuilder: (context, primaryAnimation, secondaryAnimation) => targetDialog,
      transitionBuilder: (context, primaryAnimation, secondaryAnimation, child) =>
          FadeScaleTransition(animation: primaryAnimation, child: child),
      barrierDismissible: barrierDismissible,
  );
}

Widget alertDialog(BuildContext context, String title, String content, VoidCallback confirmCallback) {
  return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text(generalCancel)),
        TextButton(onPressed: confirmCallback, child: const Text(generalConfirm, style: TextStyle(color: Colors.red))),
      ]
  );
}


/// Colors
Color primaryColor = const Color(0xFFFCBE44);
Color secondaryColor = const Color(0xFFE7E3D1);
Color tertiaryColor = const Color(0xFFE95D2E);