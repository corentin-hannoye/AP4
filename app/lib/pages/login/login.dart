import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String _baseUrl = "http://192.168.1.45:8000/";


Future fetchUser() async {
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request('POST', Uri.parse('${_baseUrl}api/login'));
  request.bodyFields = {
    'email': 'user2@gmail.com',
    'password': 'user2'
  };
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                'All4Sport',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              )),
              backgroundColor: const Color(0xfff7882d),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(children: [
                const Text(
                  'Connexion',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const TextField(
                              keyboardType: TextInputType.emailAddress,
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Mot de passe',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: fetchUser,
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  side: const BorderSide(
                                    width: 1,
                                  )),
                              child: const Text(
                                'Se connecter',
                              ),
                            ),
                          ]),
                    ))
              ]),
            )));
  }
}
