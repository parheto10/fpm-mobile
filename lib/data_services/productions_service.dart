import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'productions.dart';

List<Productions> parseProduction(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Productions> production = list.map((e) => Productions.fromJson(e)).toList();
  return production;
}

Future<List<Productions>> fetchProduction() async {
  var response = await http.get(Uri.parse("http://192.168.1.250:8000/productionlist/"));
  // var response = await http.get ("http://192.168.1.250:8000/producteurlist/?format=json");
  // print(response.body.length);
  if (response.statusCode == 200) {
    return compute(parseProduction, (Utf8Decoder().convert(response.bodyBytes)));
    // return compute(parseProducteur, response.body);
    print(response.body.length);
  } else {
    throw Exception("Une Erreur est Survenue Venifier votre Connexion");
  }
}