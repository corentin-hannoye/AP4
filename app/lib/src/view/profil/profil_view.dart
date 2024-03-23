import 'package:app/src/const.dart';
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
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profil de l'utilisateur ${value.session == null ? 'Anonyme' : value.session?.name}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 50.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.0,
                      color: errorColor
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => value.toggleLogin(value.session),
                child: Text(
                  'Déconnexion',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ),
            ],
          ),
        );
      }
    );
  }
}
