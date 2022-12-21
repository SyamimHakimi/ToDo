import 'package:flutter/material.dart';
import 'package:to_do/utils/app_constant.dart';

AppBar appButton(String title) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: primaryColor,
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}