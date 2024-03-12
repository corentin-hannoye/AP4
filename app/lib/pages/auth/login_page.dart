import 'dart:convert';

import 'package:app/model/user_model.dart';
import 'package:app/pages/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  final Function toggleConnected;
  const LoginPage({required this.toggleConnected, super.key});

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

  Future<void> login() async {
    setState(() {
      loading = true;
      err = '';
    });

    // Début requête http sur 'http://localhost:8000/api/login'
    final http.Response response = await http.post(
      Uri.parse('$apiUrl/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'email': email.text,
        'password': password.text
      }
    );
    // Fin requête http sur 'http://localhost:8000/api/login'

    setState(() {
      loading = false;
    });

    // Début si la réponse ne nous retourne pas un code 200 (OK)
    if(response.statusCode != 200) {
      return;
    }
    // Fin si la réponse ne nous retourne pas un code 200 (OK)

    final dynamic responseJson = jsonDecode(response.body);
    final bool success = responseJson['success'];

    // Début si la connexion n'est pas un succès (couple email/mdp invalide)
    if(!success) {
      setState(() {
        err = 'Identifiant incorrect !';
      });
      return;
    }
    // Fin si la connexion n'est pas un succès (couple email/mdp invalide)

    // Si tout se passe bien, nous appelons la function toggleConnected() dans main.dart, et ensuite nous sauvegardons la session de l'utilisateur
    UserModel user = UserModel.fromJson(responseJson['user']);
    user.saveUser();
    widget.toggleConnected();

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
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10
                      ),
                      label: Text(
                        'Email',
                        style: Theme.of(context).textTheme.bodyMedium
                      )
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
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Mot de passe',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10
                      ),
                      label: Text(
                          'Mot de passe',
                          style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
                      textStyle: Theme.of(context).textTheme.bodyMedium,
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
                      'Connexion'
                    )
                  ),
                ]),
            )
          ]),
        ),
      );
  }
}
