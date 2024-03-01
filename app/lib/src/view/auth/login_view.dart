import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidePassword = true;
  String err = '';

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    print('gg');
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
    );
  }
}
