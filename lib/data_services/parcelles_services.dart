// import 'dart:convert';
// import 'package:argon_flutter/screens/parcelles.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;



// List<Parcelles> parseParcelle(String responseBody) {
//   var list = json.decode(responseBody) as List<dynamic>;
//   List<Parcelles> parcelle = list.map((e) => Parcelles.fromJson(e)).toList();
//   return parcelle;
// }

// Future<List<Parcelles>> fetchParcelle() async {
//   // var response = await http.get(Uri.parse("http://192.168.1.250:8000/api/planting/v1/"));
//   var response = await http.get(Uri.parse("http://192.168.1.250:8000/parcellelist/"));
//   // var response = await http.get ("http://192.168.1.250:8000/producteurlist/?format=json");
//   // print(response.body.length);
//   if (response.statusCode == 200) {
//     return compute(parseParcelle, (Utf8Decoder().convert(response.bodyBytes)));
//     // return compute(parseProducteur, response.body);
//     print(response.body.length);
//   } else {
//     throw Exception("Une Erreur est Survenue Venifier votre Connexion");
//   }
// }