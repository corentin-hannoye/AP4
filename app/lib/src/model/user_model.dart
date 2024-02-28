import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserModel {

  final String? apiUrl = dotenv.env['API_URL'];

  Future<Map> login(username, password) async {

    Map message = {};

    // Début requête http sur 'http://localhost:8000/api/login'
    final http.Response response = await http.post(
      Uri.parse('$apiUrl/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'email': username.text,
        'password': password.text
      }
    );
    // Fin requête http sur 'http://localhost:8000/api/login'

    // Début si la réponse ne nous retourne pas un code 200 (OK)
    if(response.statusCode != 200) {
      return message;
    }
    // Fin si la réponse ne nous retourne pas un code 200 (OK)

    final dynamic responseJson = jsonDecode(response.body);
    final bool success = responseJson['success'];

    // Début si la connexion n'est pas un succès (couple email/mdp invalide)
    if(!success) {
      return message;
    }
    // Fin si la connexion n'est pas un succès (couple email/mdp invalide)
    
    return message;

  }

}
