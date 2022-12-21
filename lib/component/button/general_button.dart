import 'package:flutter/material.dart';
import 'package:to_do/utils/app_constant.dart';

TextButton textButton(String buttonText, void Function()? onPressed) {
  return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.black,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(),
        padding: EdgeInsets.symmetric(vertical: padding20)
      ),
      onPressed: onPressed,
      child: Text(buttonText, style: const TextStyle(color: Colors.white))
  );
}