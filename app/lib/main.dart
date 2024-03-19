import 'package:app/src/app.dart';
import 'package:app/src/provider/app_state_provider.dart';
import 'package:app/src/provider/cart_provider.dart';
import 'package:app/src/provider/login_validation_provider.dart';
import 'package:app/src/provider/product_list_provider.dart';
import 'package:app/src/provider/qr_code_provider.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();

  AppStateProvider appStateProvider = AppStateProvider();
  UserProvider userProvider = UserProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appStateProvider),
        ChangeNotifierProvider.value(value: userProvider),
        ChangeNotifierProvider<LoginValidationProvider>(create: (_) => LoginValidationProvider(appStateProvider, userProvider)),
        ChangeNotifierProvider<ProductListProvider>(create: (_) => ProductListProvider()),
        ChangeNotifierProvider<QRCodeProvider>(create: (_) => QRCodeProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider(userProvider)),
      ],
      child: const App(),
    )
  );
}
