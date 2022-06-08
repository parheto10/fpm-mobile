import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cooperatives.dart';

List<Cooperative> parseCooperative(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Cooperative> cooperative = list.map((e) => Cooperative.fromJson(e)).toList();
  return cooperative;
}

Future<List<Cooperative>> fetchCooperative() async {
  var response = await http.get(Uri.parse("http://192.168.1.250:8000/cooperativelist/"));
  // var response = await http.get ("http://192.168.1.250:8000/producteurlist/?format=json");
  // print(response.body.length);
  if (response.statusCode == 200) {
    return compute(parseCooperative, (Utf8Decoder().convert(response.bodyBytes)));
    // return compute(parseProducteur, response.body);
    print(response.body.length);
  } else {
    throw Exception("Une Erreur est Survenue Venifier votre Connexion");
  }
}