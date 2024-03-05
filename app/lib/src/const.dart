import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final String? apiUrl = dotenv.env['API_URL'];

const Color primaryColor = Color(0xff000000);
const Color secondaryColor = Color(0xfff7882d);
const Color whiteColor = Color(0xffffffff);
const Color successColor = Color(0xFF0E9720);
const Color errorColor = Color(0xFFC93131);
const Color linkColor = Color(0xff3b82f6);
const Color disabledColor = Color(0xFFCCCCCC);

abstract class Routes {
  static const String login = '/login';
  static const String home = '/';
  static const String account = '/account';
  static const String QRCode = '/qr-code';
  static const String product = '/product';
  static const String cart = '/cart';
}
