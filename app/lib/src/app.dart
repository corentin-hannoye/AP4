import 'package:app/src/component/app_theme.dart';
import 'package:app/src/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'All4Sport',
      debugShowCheckedModeBanner: false,
      theme: appThemeData(),
      routerConfig: getRouter(context),
    );
  }
}
