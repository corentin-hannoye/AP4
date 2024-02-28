import 'package:app/src/router/app_router.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xff000000);
const secondaryColor = Color(0xfff7882d);
const whiteColor = Color(0xffffffff);
const successColor = Color(0xff3fbf4f);
const errorColor = Color(0xffe84f4f);
const linkColor = Color(0xff3b82f6);
const disabledColor = Color(0xff505050);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Router(
          routerDelegate: AppRouter()
        ),
      ),
      theme: appThemeData(),
    );
  }

  // AppBar
  AppBar appTopBar() {
    return AppBar(
      title: Image.asset(
        'assets/images/logo.png',
        width: 50
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print('QR CODE...');
          },
          child: const Icon(
            Icons.qr_code_scanner,
            color: whiteColor
          )
        )
      ],
      scrolledUnderElevation: 0,
      backgroundColor: primaryColor,
      centerTitle: true,
    );
  }

  // BottomBar
  Widget appBottomNavigationBar() {
    return Container(
      color: secondaryColor,
      child: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.label,
        dividerHeight: 0,
        indicatorPadding: EdgeInsets.symmetric(
          vertical: 5,
        ),
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.home_rounded),
          ),
          Tab(
            icon: Icon(Icons.account_circle),
          ),
          Tab(
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }

  // ThemeApp
  ThemeData appThemeData() {
    return ThemeData(
      fontFamily: 'Montserrat',
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        onPrimary: whiteColor,
        secondary: secondaryColor,
        error: errorColor
      ),
      disabledColor: disabledColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900
        ),
        displayMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.normal
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900
        ),
        labelSmall: TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
          decorationColor: linkColor,
          color: linkColor
        )
      )
    );
  }
}
