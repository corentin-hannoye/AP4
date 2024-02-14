import 'dart:convert';

import 'package:app/pages/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  final Function connected;
  const LoginPage(this.connected, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String? apiUrl = dotenv.env['API_URL'];
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;
  bool hidePassword = true;
  String err = '';

  Future login() async {
    setState(() {
      loading = true;
      err = '';
    });
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

    setState(() {
      loading = false;
    });

    if(response.statusCode == 200) {

      final dynamic responseJson = jsonDecode(response.body);
      final bool success = responseJson['success'];

      setState(() {
        if(success) {
          err = 'Identifiant correct, bienvenue ${responseJson['user']['firstname']} ${responseJson['user']['name']} !';
          widget.connected();
        } else {
          err = 'Identifiant incorrect !';
        }
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return loading ?
        const LoaderPage() :
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 100
            ),
            child: Column(children: [
              Text(
                'Connexion',
                style: Theme.of(context).textTheme.displayLarge
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      err,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.error
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Veuillez saisir votre adresse email';
                        }
                        return null;
                      },
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10
                        ),
                        label: Text('Email')
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Veuillez saisir votre mot de passe';
                        }
                        return null;
                      },
                      controller: password,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        hintText: 'Mot de passe',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10
                        ),
                        label: const Text('Mot de passe'),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: Icon(
                            (hidePassword ? Icons.visibility : Icons.visibility_off),
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        side: const BorderSide(
                          width: 1,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      child: const Text(
                        'Se connecter'
                      )
                    ),
                  ]),
              )
            ]),
          ),
        );
  }
}
