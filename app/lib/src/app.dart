import 'package:app/src/component/app_theme.dart';
import 'package:app/src/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginNotifierProvider extends ChangeNotifierProvider {
  bool _isLogin = false;
  get getIsLogin => _isLogin;

  void login() {
    _isLogin = true;
  }
}

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
            appBar: AppBar(
              title: Text('Titre, connecté : ' + (Provider.<LoginNotifierProvider>().getIsLogin() ? 'oui' : 'non')),
            ),
            body: child,
          )
        );
      },
    );
  }
}
