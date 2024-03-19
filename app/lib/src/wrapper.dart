import 'package:app/src/component/app_bar.dart';
import 'package:app/src/component/app_bottom_navigation_bar.dart';
import 'package:app/src/provider/app_state_provider.dart';
import 'package:app/src/view/loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key, required this.statefulNavigationShell});

  final StatefulNavigationShell statefulNavigationShell;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AppStateProvider>(
        builder: (_, value, __) => 
          Scaffold(
            appBar: appTopBar(context),
            body: value.loading ? const LoaderView() : statefulNavigationShell,
            bottomNavigationBar: AppBottomNavigationBar(statefulNavigationShell: statefulNavigationShell),
          ),
      )
    );
  }
}
