import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:provider/provider.dart';
import 'package:to_do/db/database_provider.dart';
import 'package:to_do/screen/todo_form_screen.dart';
import 'package:to_do/screen/todo_list_screen.dart';
import 'package:to_do/utils/app_constant.dart';
import 'package:to_do/utils/app_string.dart';
import 'package:to_do/utils/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('en_GB');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DatabaseProvider>(
        create: (context) => DatabaseProvider(),
        dispose: (context, db) => db.close(),
        child: MaterialApp(
          builder: (context, _) {
            var child = _!;
            // final navigatorKey = child.key as GlobalKey<NavigatorState>;
            // child = Toast(navigatorKey: navigatorKey, child: child);
            // child = FlashTheme(
            //   flashBarTheme: const FlashBarThemeData.dark(),
            //   flashDialogTheme: const FlashDialogThemeData(),
            //   child: child,
            // );
            return child;
          },
          title: appTitle,
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: primaryColor,
            typography: appTypography,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
              },
            ),
          ),
          supportedLocales: const [Locale('en')],
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
          ],

          // navigatorObservers: <NavigatorObserver>[routeObserver],
          // home: const ToDoListScreen(),
          home: const ToDoFormScreen(),
        )
    );
  }
}
