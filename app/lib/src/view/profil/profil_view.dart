import 'package:app/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<UserProvider>(
        builder: (context, value, child) => 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Page de profil de l'utilisateur ${value.session?.name}"),
            TextButton(
              onPressed: () => value.toggleLogin(value.session),
              child: Text(
                'Déconnexion',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            )
          ],
        ),
      )
    );
  }
}
