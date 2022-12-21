import 'package:flutter/material.dart';

const String fontNamePrimary = 'RobotoSlab';
const String fontNameSecondary = 'Poppins';
const String fontNameTertiary = 'Quando';

Typography appTypography = Typography.material2021(
  black: lightTextTheme,
  white: darkTextTheme,
  englishLike: Typography.englishLike2021,
  dense: Typography.dense2021,
  tall: Typography.tall2021,
);

/// ThemeData typography scheme
const TextTheme lightTextTheme = TextTheme(
  displayLarge : TextStyle(debugLabel: 'lightTextTheme displayLarge', fontFamily: fontNamePrimary, color: Colors.black54, decoration: TextDecoration.none),
  displayMedium : TextStyle(debugLabel: 'lightTextTheme displayMedium', fontFamily: fontNamePrimary, color: Colors.black54, decoration: TextDecoration.none),
  displaySmall : TextStyle(debugLabel: 'lightTextTheme displaySmall', fontFamily: fontNamePrimary, color: Colors.black54, decoration: TextDecoration.none),
  headlineLarge : TextStyle(debugLabel: 'lightTextTheme headlineLarge', fontFamily: fontNamePrimary, color: Colors.black54, decoration: TextDecoration.none),
  headlineMedium : TextStyle(debugLabel: 'lightTextTheme headlineMedium', fontFamily: fontNamePrimary, color: Colors.black54, decoration: TextDecoration.none),
  headlineSmall : TextStyle(debugLabel: 'lightTextTheme headlineSmall', fontFamily: fontNamePrimary, color: Colors.black87, decoration: TextDecoration.none),
  titleLarge : TextStyle(debugLabel: 'lightTextTheme titleLarge', fontFamily: fontNamePrimary, color: Colors.black87, decoration: TextDecoration.none),
  titleMedium : TextStyle(debugLabel: 'lightTextTheme titleMedium', fontFamily: fontNameSecondary, color: Colors.black87, decoration: TextDecoration.none),
  titleSmall : TextStyle(debugLabel: 'lightTextTheme titleSmall', fontFamily: fontNameSecondary, color: Colors.black,   decoration: TextDecoration.none),
  bodyLarge : TextStyle(debugLabel: 'lightTextTheme bodyLarge', fontFamily: fontNameSecondary, color: Colors.black87, decoration: TextDecoration.none),
  bodyMedium : TextStyle(debugLabel: 'lightTextTheme bodyMedium', fontFamily: fontNameSecondary, color: Colors.black87, decoration: TextDecoration.none),
  bodySmall   : TextStyle(debugLabel: 'lightTextTheme bodySmall',   fontFamily: fontNameSecondary, color: Colors.black54, decoration: TextDecoration.none),
  labelLarge    : TextStyle(debugLabel: 'lightTextTheme labelLarge',    fontFamily: fontNameSecondary, color: Colors.black87, decoration: TextDecoration.none),
  labelMedium  : TextStyle(debugLabel: 'lightTextTheme labelMedium',  fontFamily: fontNameSecondary, color: Colors.black,   decoration: TextDecoration.none),
  labelSmall  : TextStyle(debugLabel: 'lightTextTheme labelSmall',  fontFamily: fontNameSecondary, color: Colors.black,   decoration: TextDecoration.none),
);

const TextTheme darkTextTheme = TextTheme(
  displayLarge : TextStyle(debugLabel: 'darkTextTheme displayLarge', fontFamily: fontNamePrimary, color: Colors.white70, decoration: TextDecoration.none),
  displayMedium : TextStyle(debugLabel: 'darkTextTheme displayMedium', fontFamily: fontNamePrimary, color: Colors.white70, decoration: TextDecoration.none),
  displaySmall : TextStyle(debugLabel: 'darkTextTheme displaySmall', fontFamily: fontNamePrimary, color: Colors.white70, decoration: TextDecoration.none),
  headlineLarge : TextStyle(debugLabel: 'darkTextTheme headlineLarge', fontFamily: fontNamePrimary, color: Colors.white70, decoration: TextDecoration.none),
  headlineMedium : TextStyle(debugLabel: 'darkTextTheme headlineMedium', fontFamily: fontNamePrimary, color: Colors.white70, decoration: TextDecoration.none),
  headlineSmall : TextStyle(debugLabel: 'darkTextTheme headlineSmall', fontFamily: fontNamePrimary, color: Colors.white,   decoration: TextDecoration.none),
  titleLarge : TextStyle(debugLabel: 'darkTextTheme titleLarge', fontFamily: fontNamePrimary, color: Colors.white,   decoration: TextDecoration.none),
  titleMedium : TextStyle(debugLabel: 'darkTextTheme titleMedium', fontFamily: fontNameSecondary, color: Colors.white,   decoration: TextDecoration.none),
  titleSmall : TextStyle(debugLabel: 'darkTextTheme titleSmall', fontFamily: fontNameSecondary, color: Colors.white,   decoration: TextDecoration.none),
  bodyLarge : TextStyle(debugLabel: 'darkTextTheme bodyLarge', fontFamily: fontNameSecondary, color: Colors.white,   decoration: TextDecoration.none),
  bodyMedium : TextStyle(debugLabel: 'darkTextTheme bodyMedium', fontFamily: fontNameSecondary, color: Colors.white,   decoration: TextDecoration.none),
  bodySmall   : TextStyle(debugLabel: 'darkTextTheme bodySmall',   fontFamily: fontNameSecondary, color: Colors.white70, decoration: TextDecoration.none),
  labelLarge    : TextStyle(debugLabel: 'darkTextTheme labelLarge',    fontFamily: fontNameSecondary, color: Colors.white,   decoration: TextDecoration.none),
  labelMedium  : TextStyle(debugLabel: 'darkTextTheme labelMedium',  fontFamily: fontNameSecondary, color: Colors.white,   decoration: TextDecoration.none),
  labelSmall  : TextStyle(debugLabel: 'darkTextTheme labelSmall',  fontFamily: fontNameSecondary, color: Colors.white,   decoration: TextDecoration.none),
);
