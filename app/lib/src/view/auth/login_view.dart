import 'package:app/src/provider/login_validation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginValidationProvider>(
      builder: (context, value, child) =>
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
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    errorText: value.getError('email'),
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
                  onChanged: (fieldValue) => value.setValue('email', fieldValue),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: !value.showPassword,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    errorText: value.getError('password'),
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
                        value.toggleShowPassword();
                      },
                      child: Icon(value.showPassword ? Icons.visibility_off : Icons.visibility),
                    )
                  ),
                  onChanged: (fieldValue) => value.setValue('password', fieldValue),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if(value.isValid()) {
                      value.sendForm();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    side: const BorderSide(
                      width: 1,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  child: const Text(
                    'Connexion'
                  )
                ),
              ]
            )
          ),
        ),
    );
  }
}
