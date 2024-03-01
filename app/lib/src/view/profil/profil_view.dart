import 'package:app/src/entity/user.dart';
import 'package:flutter/material.dart';

class ProfilScreen extends StatefulWidget {
  final Function toggleConnected;
  const ProfilScreen({required this.toggleConnected, super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  User? user = User.getUser();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Page de profil de l'utilisateur ${user?.getName}"),
          TextButton(
            onPressed: () => widget.toggleConnected(),
            child: Text(
              'Déconnexion',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          )
        ],
      ),
    );
  }
}

