import 'package:app/src/component/app_bar.dart';
import 'package:app/src/component/app_bottom_navigation_bar.dart';
import 'package:app/src/component/app_theme.dart';
import 'package:app/src/provider/app_state_provider.dart';
import 'package:app/src/router.dart';
import 'package:app/src/view/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          child: Consumer<AppStateProvider>(
            builder: (_, value, __) => 
              Scaffold(
                appBar: appTopBar(context),
                body: value.loading ? const LoaderView() : child,
                bottomNavigationBar: const AppBottomNavigationBar(),
              ),
          )
        );
      },
    );
  }
}
