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

DateFormat dateFormat = DateFormat.yMd('en_GB');

/// Form UI
InputDecoration formDecoration(String hint) {

  return InputDecoration(
    hintText: hint,
    // hintStyle: AppTheme.bodyFontSecondaryDisabled,
    // errorStyle: isInline ? const TextStyle(fontSize: 0, height: 0, color: Colors.transparent) : AppTheme.captionError,
    // counterStyle: isInline ? const TextStyle(fontSize: 0, height: 0, color: Colors.transparent) : null,
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

/// Colors
Color primaryColor = const Color(0xFFFCBE44);