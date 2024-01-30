import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
                'All4Sport',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
            )
          ),
          backgroundColor: Colors.deepOrange,
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
      ),
    );
  }
}
