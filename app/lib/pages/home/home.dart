import 'package:flutter/material.dart';

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
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
            )
          ),
          backgroundColor: const Color(0xfff7882d),
        ),
        body: const Column(
          children: [
            Text(
              'Connexion',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Mot de passe'
              ),
            ),
          ]
        )
      )
    );
  }
}
