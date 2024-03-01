import 'dart:convert';

import 'package:app/src/const.dart';
import 'package:app/src/entity/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<User?> login(String email, String password) async {
    // Début requête http sur 'http://localhost:8000/api/login'
    final http.Response response = await http.post(
      Uri.parse('$apiUrl/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'email': email,
        'password': password
      }
    );
    // Fin requête http sur 'http://localhost:8000/api/login'

    // Début si la réponse ne nous retourne pas un code 200 (OK)
    if(response.statusCode != 200) {
      return null;
    }
    // Fin si la réponse ne nous retourne pas un code 200 (OK)

    final dynamic responseJson = jsonDecode(response.body);
    final bool success = responseJson['success'];

    // Début si la connexion n'est pas un succès (couple email/mdp invalide)
    if(!success) {
      return null;
    }
    // Fin si la connexion n'est pas un succès (couple email/mdp invalide)

    User user = User.fromJson(responseJson['user']);

    return user;
  }
}
