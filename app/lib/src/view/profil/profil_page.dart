import 'package:app/src/entity/user.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  final Function toggleConnected;
  const ProfilPage({required this.toggleConnected, super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
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
