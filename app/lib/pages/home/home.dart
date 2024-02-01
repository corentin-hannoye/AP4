import 'package:flutter/material.dart';

bool login() {
  return true;
}

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
                'All4Sport',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
            )
          ),
          backgroundColor: const Color(0xfff7882d),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 100
          ),
          child: Column(
            children: [
              const Text(
                'Connexion',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
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
                            borderRadius: BorderRadius.all(Radius.circular(4))
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10
                          )
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
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
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          side: const BorderSide(
                            width: 1,
                          )
                        ),
                        child: const Text(
                            'Se connecter',
                        ),
                      ),
                    ]
                  ),
                )
              )
            ]
          ),
        )
      )
    );
  }
}
