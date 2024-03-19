import 'dart:convert';

import 'package:app/src/const.dart';
import 'package:app/src/entity/store.dart';
import 'package:http/http.dart' as http;

class StoreRepository {

  Future<List<Store>?> findAll() async {
    final http.Response response = await http.get(Uri.parse('$apiUrl/api/stores'));

    if(response.statusCode != 200) {
      return null;
    }

    final List responseJson = jsonDecode(response.body)['hydra:member'];

    List<Store> stores = [];

    for(Map<dynamic, dynamic> e in responseJson) {
      stores.add(Store.fromJson(e));
    }
    return stores;
  }

}
