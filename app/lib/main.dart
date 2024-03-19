import 'package:app/pages/auth/login_page.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/profil/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart'; // Import the correct library

Future<void> main() async {
  await dotenv.load();

  runApp(MaterialApp(home: const MainApp())); // Wrap with MaterialApp
}

const PRIMARY_COLOR = Color(0xff000000);
const SECONDARY_COLOR = Color.fromARGB(255, 34, 21, 11);
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
  bool isConnected = false;

  void toggleConnected() {
    setState(() {
      isConnected = !isConnected;
    });
  }

  // Template
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A4S',
      debugShowCheckedModeBanner: false,
      theme: appThemeData(),
      home: SafeArea(
          child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: (isConnected ? appTopBar() : null),
          body: getScreens(),
          bottomNavigationBar: (isConnected ? appBottomNavigationBar() : null),
        ),
      )),
    );
  }

  getScreens() {
    if (!isConnected) {
      return LoginPage(toggleConnected: toggleConnected);
    }

    return TabBarView(
      children: [
        HomePage(),
        ProfilPage(toggleConnected: toggleConnected),
        Text('Mon panier')
      ],
    );
  }

  void goQrCode() async {
    // Use QrCodeDartScan instead of QRView
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRCodeDartScanView()),
    );

    if (result != null) {
      print('QR Code Data: $result'); // Access scanned data here
      // Perform actions based on the scanned data
    }
  }

  // QR code scanner variables and methods are removed (replaced by goQrCode)

  // AppBar
  AppBar appTopBar() {
    return AppBar(
      title: Image.asset('assets/images/logo.png', width: 50),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print('QR CODE...');
            goQrCode();
          },
          child: const Icon(Icons.qr_code_scanner, color: WHITE_COLOR),
        ),
      ],
      scrolledUnderElevation: 0,
      backgroundColor: PRIMARY_COLOR,
      centerTitle: true,
    );
  }

  // BottomBar
  Widget appBottomNavigationBar() {
    return Container(
      color: SECONDARY_COLOR,
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
            seedColor: PRIMARY_COLOR,
            primary: PRIMARY_COLOR,
            onPrimary: WHITE_COLOR,
            secondary: SECONDARY_COLOR,
            error: ERROR_COLOR),
        disabledColor: DISABLED_COLOR,
        textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            displayMedium:
                TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
            bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            labelSmall: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: LINK_COLOR,
                color: LINK_COLOR)));
  }
}
