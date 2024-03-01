import 'package:app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(
     MultiProvider(
      providers: [
        Provider(
          create: (context) => LoginNotifierProvider(),
        )
      ],
      child: const App(),
    )
  );
}
