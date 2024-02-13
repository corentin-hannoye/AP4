import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String? apiUrl = dotenv.env['API_URL'];
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    final http.Response response = await http.post(
      Uri.parse('${apiUrl!}login'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'email': email.text,
        'password': password.text
      }
    );

    final responseJson = jsonDecode(response.body);
    final bool success = responseJson['success'];
    var text = '';

    if(success) {
      text = 'Identifiant correct, bienvenue ${responseJson['user']['name']} !';
    } else {
      text = 'Identifiant incorrect !';
    }

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              text,
              style: const TextStyle(
                fontSize: 16
              ),
          ),
          backgroundColor: (success ? Colors.green : Colors.red)
        )
    );
  }

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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 100
            ),
            child: Column(children: [
              const Text(
                'Connexion',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre adresse email';
                          }
                          return null;
                      },
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4))
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10
                          )
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre mot de passe';
                          }
                          return null;
                      },
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Mot de passe',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4))
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10
                          )
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          side: const BorderSide(
                            width: 1,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                      ),
                      child: const Text(
                        'Se connecter',
                      ),
                    ),
                  ]),
              )
            ]),
          ),
        )
      )
    );
  }
}
