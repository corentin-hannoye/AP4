import 'package:app/src/const.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:app/src/view/auth/login_view.dart';
import 'package:app/src/view/home/home_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter getRouter() {
  return GoRouter(
    initialLocation: Routes.home,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (_, __) => const HomeView()
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginView()
      ),
    ],
    redirect: (context, state) {
      UserProvider userProvider = Provider.of<UserProvider>(context);

      if(!userProvider.getIsLogin && state.fullPath != Routes.login) {
        return Routes.login;
      }

      if(userProvider.getIsLogin && state.fullPath == Routes.login) {
        return Routes.home;
      }
      return null;
    },
  );
}
