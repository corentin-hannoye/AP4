import 'package:app/src/component/app_bar.dart';
import 'package:app/src/component/app_theme.dart';
import 'package:app/src/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: appThemeData(),
      routerConfig: getRouter(),
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            appBar: appTopBar(context),
            body: child
          )
        );
      },
    );
  }
}
