import 'package:app/pages/login/login_page.dart';
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
const DISABLED_COLOR = Color(0xff505050);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}


class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A4S',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: PRIMARY_COLOR,
          primary: PRIMARY_COLOR,
          onPrimary: WHITE_COLOR,
          secondary: SECONDARY_COLOR,
          error: ERROR_COLOR
        ),
        disabledColor: DISABLED_COLOR
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/images/logo.png',
              width: 50,
            ),
            backgroundColor: SECONDARY_COLOR,
            centerTitle: true,
            toolbarHeight: 70,
          ),
          body: [
            LoginPage()
          ][0],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: '',
                tooltip: 'test'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                activeIcon: Icon(Icons.account_circle),
                label: ''
              )
            ],
            iconSize: 30,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            backgroundColor: SECONDARY_COLOR,
            selectedItemColor: PRIMARY_COLOR,
            unselectedItemColor: DISABLED_COLOR,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
