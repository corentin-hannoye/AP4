import 'package:app/src/const.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar appTopBar(BuildContext context) {

  UserProvider userProvider = Provider.of<UserProvider>(context);

  return AppBar(
    title: Image.asset(
      'assets/images/logo.png',
      width: 50
    ),
    actions: <Widget>[
      if(userProvider.isLogin)
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
