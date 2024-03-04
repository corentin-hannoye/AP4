import 'package:app/src/const.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:app/src/view/QRCode/qr_code_view.dart';
import 'package:app/src/view/auth/login_view.dart';
import 'package:app/src/view/home/home_view.dart';
import 'package:app/src/view/product/product_view.dart';
import 'package:app/src/view/profil/profil_view.dart';
import 'package:app/src/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter getRouter(context) {
  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  final UserProvider userProvider = Provider.of<UserProvider>(context);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, statefulNavigationShell) => Wrapper(statefulNavigationShell: statefulNavigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.home,
                builder: (_, __) => const HomeView()
              ),
            ]
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.account,
                builder: (_, __) => const ProfilView()
              ),
            ]
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.login,
                builder: (_, __) => const LoginView()
              ),
            ]
          ),
        ]
      ),
      GoRoute(
        path: Routes.QRCode,
        builder: (_, __) => const QRCode()
      ),
      GoRoute(
        path: Routes.product,
        builder: (_, __) => const ProductView()
      ),
    ],
    redirect: (context, state) {
      if(!userProvider.isLogin && state.fullPath != Routes.login) {
        return Routes.login;
      }

      if(userProvider.isLogin && state.fullPath == Routes.login) {
        return Routes.home;
      }
      return null;
    },
  );
}
