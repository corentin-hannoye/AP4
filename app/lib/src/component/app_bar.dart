import 'package:app/src/const.dart';
import 'package:flutter/material.dart';

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
