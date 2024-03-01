import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final String? apiUrl = dotenv.env['API_URL'];
const Color primaryColor = Color(0xff000000);
const Color secondaryColor = Color(0xfff7882d);
const Color whiteColor = Color(0xffffffff);
const Color successColor = Color(0xff3fbf4f);
const Color errorColor = Color(0xffe84f4f);
const Color linkColor = Color(0xff3b82f6);
const Color disabledColor = Color(0xff505050);

abstract class Routes {
  static const String home = '/';
  static const String login = '/login';
}
