import 'package:app/pages/auth/login_page.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/profil/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MainApp());
}

const PRIMARY_COLOR = Color(0xff000000);
const SECONDARY_COLOR = Color(0xfff7882d);
const WHITE_COLOR = Color(0xffffffff);
const SUCCESS_COLOR = Color(0xff3fbf4f);
const ERROR_COLOR = Color(0xffe84f4f);
const LINK_COLOR = Color(0xff3b82f6);
const DISABLED_COLOR = Color(0xff505050);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  bool isConnected = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleConnected() {
    setState(() {
      isConnected = !isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A4S',
      debugShowCheckedModeBanner: false,
      theme: appThemeData(),
      home: SafeArea(
        child: Scaffold(
          appBar: (isConnected ? appTopBar() : null),
          body: isConnected ?
            [
              const HomePage(),
              ProfilPage(toggleConnected: toggleConnected),
              null
            ][_selectedIndex] :
            LoginPage(toggleConnected: toggleConnected),
          bottomNavigationBar: (isConnected ? appBottomNavigationBar() : null)
        )
      )
    );
  }

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
            color: WHITE_COLOR
          )
        )
      ],
      scrolledUnderElevation: 0,
      backgroundColor: PRIMARY_COLOR,
      centerTitle: true,
    );
  }

  BottomNavigationBar appBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          activeIcon: Icon(Icons.account_circle),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: ''
        ),
      ],
      iconSize: 30,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _selectedIndex,
      backgroundColor: SECONDARY_COLOR,
      selectedItemColor: PRIMARY_COLOR,
      unselectedItemColor: DISABLED_COLOR,
      onTap: _onItemTapped
    );
  }

  ThemeData appThemeData() {
    return ThemeData(
      fontFamily: 'Montserrat',
      colorScheme: ColorScheme.fromSeed(
        seedColor: PRIMARY_COLOR,
        primary: PRIMARY_COLOR,
        onPrimary: WHITE_COLOR,
        secondary: SECONDARY_COLOR,
        error: ERROR_COLOR
      ),
      disabledColor: DISABLED_COLOR,
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
          decorationColor: LINK_COLOR,
          color: LINK_COLOR
        )
      )
    );
  }
}
