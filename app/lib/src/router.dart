import 'package:app/src/const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter getRouter() {

  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) =>
          Center(
            child: ElevatedButton(
              onPressed: () {
                print('az');
                context.go(Routes.home);
              },
              child: Text('Go connexion'),
            ),
          )
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) =>
          Center(
            child: ElevatedButton(
              onPressed: () {
                print('az');
                context.go(Routes.home);
              },
              child: Text('Go accueil'),
            ),
          )
        ,
      ),
    ]
  );
}
