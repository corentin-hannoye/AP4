import 'package:app/src/entity/user.dart';
import 'package:flutter/material.dart';

class ProfilView extends StatefulWidget {
  final Function toggleConnected;
  const ProfilView({required this.toggleConnected, super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
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
