import 'package:app/src/app.dart';
import 'package:app/src/provider/app_state_provider.dart';
import 'package:app/src/provider/login_validation_provider.dart';
import 'package:app/src/provider/product_list_provider.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateProvider>(create: (_) => AppStateProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<LoginValidationProvider>(create: (_) => LoginValidationProvider()),
        ChangeNotifierProvider<ProductListProvider>(create: (_) => ProductListProvider()),
      ],
      child: const App(),
    )
  );
}
