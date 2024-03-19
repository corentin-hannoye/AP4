import 'dart:convert';

import 'package:app/src/const.dart';
import 'package:app/src/entity/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {

  Future<User?> login(String email, String password) async {
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

    if(response.statusCode != 200) {
      return null;
    }

    final dynamic responseJson = jsonDecode(response.body);
    final bool success = responseJson['success'];

    if(!success) {
      return null;
    }

    User user = User.fromJson(responseJson['user']);

    return user;
  }
}
