import 'package:app/model/user_model.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  final Function toggleConnected;
  const ProfilPage(this.toggleConnected, {super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  UserModel? user = UserModel.getUser();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Page de profil ${user?.getName}"),
          TextButton(
              onPressed: () => widget.toggleConnected(),
              child: const Text('Déconnexion')
          )
        ],
      ),
    );
  }
}

