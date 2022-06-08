import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'plantings.dart';

List<Plantings> parsePlanting(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Plantings> planting = list.map((e) => Plantings.fromJson(e)).toList();
  return planting;
}

Future<List<Plantings>> fetchPlanting() async {
  var response = await http.get(Uri.parse("http://192.168.1.250:8000/plantinglist/"));
  // var response = await http.get ("http://192.168.1.250:8000/producteurlist/?format=json");
  // print(response.body.length);
  if (response.statusCode == 200) {
    return compute(parsePlanting, (Utf8Decoder().convert(response.bodyBytes)));
    // return compute(parseProducteur, response.body);
    print(response.body.length);
  } else {
    throw Exception("Une Erreur est Survenue Venifier votre Connexion");
  }
}