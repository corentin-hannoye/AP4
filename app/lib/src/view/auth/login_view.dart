import 'package:app/src/const.dart';
import 'package:app/src/provider/app_state_provider.dart';
import 'package:app/src/provider/login_validation_provider.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<LoginValidationProvider, AppStateProvider, UserProvider>(
      builder: (context, loginValidationProvider, appStateProvider, userProvider, _) =>
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 100
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Connexion',
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                if(loginValidationProvider.message != null)
                  Text(
                    loginValidationProvider.message.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: loginValidationProvider.getValue('email'),
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    errorText: loginValidationProvider.getError('email'),
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
                  onChanged: (fieldValue) => loginValidationProvider.setValue('email', fieldValue),
                  onTapOutside: (event) => loginValidationProvider.setValue('email', loginValidationProvider.getValue('email')),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: !loginValidationProvider.showPassword,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    errorText: loginValidationProvider.getError('password'),
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
                        loginValidationProvider.toggleShowPassword();
                      },
                      child: Icon(loginValidationProvider.showPassword ? Icons.visibility_off : Icons.visibility),
                    )
                  ),
                  onChanged: (fieldValue) => loginValidationProvider.setValue('password', fieldValue),
                  onTapOutside: (event) => loginValidationProvider.setValue('password', loginValidationProvider.getValue('password')),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: loginValidationProvider.allowButton ? () {
                    loginValidationProvider.sendForm();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  child: const Text('Connexion')
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: disabledColor,
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Pas encore inscrit ? ',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Inscrivez-vous ',
                        style: TextStyle(
                          background: Paint()..color = Theme.of(context).colorScheme.primary,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () async {
                          if(!await launchUrl(Uri.parse('$apiUrl/connexion'))) {
                            throw Exception('Erreur lors du lancement');
                          }
                        }
                      ),
                      const TextSpan(text: ' dès maintenant !'),
                    ],
                  ),
                )
              ]
            )
          ),
        ),
    );
  }
}
