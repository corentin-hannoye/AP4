import 'package:app/src/entity/user.dart';
import 'package:app/src/view/auth/login_page.dart';
import 'package:flutter/material.dart';

class AppRouter extends RouterDelegate {
  User? _user;
 
  @override
  Future<void> setInitialRoutePath(configuration) {
    return super.setInitialRoutePath(configuration);
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }

  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    throw UnimplementedError();
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
  
}