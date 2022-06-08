import 'dart:convert';

import 'package:argon_flutter/data_services/producteur.dart';
import 'package:argon_flutter/models/monitoring.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:http/http.dart' as http;
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:sqflite/sqflite.dart';
  


class ControllerSync {
  final con = DatabaseHelper.instance;
  final int usercoop_id = User.sessionUser.cooperative_id; 
  final int user_id = User.sessionUser.id; 

  static Future<int> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile){

      if(await DataConnectionChecker().hasConnection) {
        print("Donnée mobile detecté & connection internet confirmé");
        return 1;
      }else{
        print("Pas de data internet :(Reason:'");
        return 2;
      }

    }else if(connectivityResult == ConnectivityResult.wifi){
      if(await DataConnectionChecker().hasConnection){
        print("wifi data detected & connection internet confirmé");
        return 1;
      }else{
        print('Pas de data internet :( Reason:');
        return 2;
      }

    }else{
      print("Aucune Donnée activée");
      return 3;
    }

  }




  Future<List<Parcelle>> getParcellesync()async{
    final db = await con.db;

    List<Parcelle> parcList = [];

    try {
      final maps = await db.rawQuery("SELECT p.code,p.code_certificat,p.annee_certificat,p.annee_acquis,p.acquisition,p.longitude,p.superficie,p.culture,p.projet_id,p.certification,p.producteur_id,p.latitude,p.user_id,p.created_at,p.updated_at FROM cooperatives_parcelle as p INNER JOIN cooperatives_producteur as pr on p.producteur_id = pr.code WHERE p.synchro ='NON' AND pr.cooperative_id = '$usercoop_id'  AND p.user_id = '$user_id'  ");
      // print(maps);
      for(var item in maps){
        parcList.add(Parcelle.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }

    return parcList;

  }
  Future<List<DetailPlanting>> getDetailPlantingsync()async{
    final db = await con.db;

    List<DetailPlanting> detailplant = [] ;

    try {
      final maps = await db.rawQuery("SELECT * FROM cooperatives_detailplanting WHERE synchro ='NON' AND user_id = '$user_id' ");
      // print("maps");
      for(var item in maps){
        detailplant.add(DetailPlanting.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }
    // print(detailplant);

    return detailplant;

  }
  
  Future<List<Monitoring>> getMonitoringync()async{
    final db = await con.db;

    List<Monitoring> moniList = [];

    try {
      final maps = await db.rawQuery("SELECT * FROM cooperatives_monitoring WHERE synchro = 'NON' ");
      for(var item in maps){
        moniList.add(Monitoring.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }

    return moniList;

  }

  Future<List<Planting>> getPlantinggync()async{
    final db = await con.db;

    List<Planting> PlantingLists = [];

    try {
      final maps = await db.rawQuery("SELECT * FROM cooperatives_planting WHERE synchro ='NON' AND  user_id = '$user_id'   ");
      for(var item in maps){
        PlantingLists.add(Planting.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }
    // print(PlantingLists);

    return PlantingLists;

  }
  
  Future<List<Producteur>> getProducteursync()async{
    final db = await con.db;

    List<Producteur> ProdLists = [];
   

    try {
      final maps = await db.rawQuery("SELECT * FROM cooperatives_producteur WHERE synchro = 'NON' AND cooperative_id = '$usercoop_id' AND user_id = '$user_id' ");
      for(var item in maps){
        ProdLists.add(Producteur.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }

    return ProdLists;

  }


  Future saveParcToserver(List parcList) async {
     final db = await con.db;
    for(var i = 0; i < parcList.length; i++){
      Map<String,dynamic> data = {
        // "id":"${parcList[i]?.id}" ?? "",
        "code":"${parcList[i]?.code}" ?? "",
        "code_certificat":"${parcList[i]?.code_certificat}" ?? "",
        "annee_certificat":parcList[i]?.annee_certificat == ""|| parcList[i]?.annee_certificat == null  ? "1960": "${parcList[i]?.annee_certificat}",
        "annee_acquis":parcList[i]?.annee_acquis == ""|| parcList[i]?.annee_acquis == null  ? "1960": "${parcList[i]?.annee_acquis}",
        "acquisition":"${parcList[i]?.acquisition}" ?? "",
        "longitude":"${parcList[i]?.longitude}" ?? "",
        "superficie":"${parcList[i]?.superficie}" ?? "",
        "culture":"${parcList[i]?.culture}" ?? "",
        "projet_id": parcList[i]?.projet_id == ""|| parcList[i]?.projet_id == null  ? "1": "${parcList[i]?.projet_id}",
        "certification":"${parcList[i]?.certification}" ?? "",
        "latitude":"${parcList[i]?.latitude}" ?? "",
        "producteur_id":"${parcList[i]?.producteur_id}" ?? "",
        "user_id": parcList[i]?.user_id == ""|| parcList[i]?.user_id == null  ? "0": "${parcList[i]?.user_id}",
      };

      print(data);     

      final response = await http.post(Uri.parse('https://fpmpro.pythonanywhere.com/cooperatives/apiCreateParc/'),
        body: data
      );

      if(response.statusCode  == 200){
        print("Saving Data ok ");
      }else{
        print(response.statusCode);
      }

      final detup = await db.rawUpdate("UPDATE cooperatives_parcelle SET synchro = ? WHERE code = ? ",["OUI",parcList[i]?.code]);  

    }
  }


  Future saveMoniToserver(List moniList) async {
     final db = await con.db;
    for(var i = 0; i < moniList.length; i++){
      Map<String,dynamic> data = {
        "code":"${moniList[i]?.code}" ?? "",
        "date":"${moniList[i]?.date}" ?? "",
        "planting_id":"${moniList[i]?.planting_id}" ?? "",
        "mature_global":"${moniList[i]?.mature_global}" ?? "",
        "mort_global":"${moniList[i]?.mort_global}" ?? "",
      };

      print(data);

      final response = await http.post(Uri.parse('https://fpmpro.pythonanywhere.com/cooperatives/apiCreateMonitoring/'),
        body: data
      );

      if(response.statusCode  == 200){
        print("Saving Data ok ");
      }else{
        print(response.statusCode);
      }

      final detup = await db.rawUpdate("UPDATE cooperatives_monitoring SET sync = ? WHERE code = ? ",["OUI",moniList[i]?.code]);    

    }
  }

  Future savePlantingToserver(List PlantingLists) async {
     final db = await con.db;
    for(var i = 0; i < PlantingLists.length; i++){
      Map<String,dynamic> data = {
        "code":"${PlantingLists[i]?.code}" ?? "",
        "nb_plant_exitant":"${PlantingLists[i]?.nb_plant_exitant}" ?? "",
        "plant_recus":"${PlantingLists[i]?.plant_recus}" ?? "",
        "date":"${PlantingLists[i]?.date}" ?? "",
        "plant_total":"${PlantingLists[i]?.plant_total}" ?? "",
        "campagne_id": PlantingLists[i]?.campagne_id == ""|| PlantingLists[i]?.campagne_id == null  ? "1": "${PlantingLists[i]?.campagne_id}" ,
        "parcelle_id":"${PlantingLists[i]?.parcelle_id}" ?? "",
        "user_id":PlantingLists[i]?.user_id == ""|| PlantingLists[i]?.user_id == null  ? "0": "${PlantingLists[i]?.user_id}",
      };

      print(data);

      final response = await http.post(Uri.parse('https://fpmpro.pythonanywhere.com/cooperatives/apiCreatePlant/'),
        body: data
      );

      if(response.statusCode  == 200){
        print("Saving Data ok ");
      }else{
        print(response.statusCode);
      }

       final detup = await db.rawUpdate("UPDATE cooperatives_planting SET synchro = ? WHERE code = ? ",["OUI",PlantingLists[i]?.code]);    

    }
  }

  Future saveProducteurToserver(List ProdLists) async {
    final db = await con.db;
    for(var i = 0; i < ProdLists.length; i++){
      Map<String,dynamic> data = {
        // "id":"${ProdLists[i]?.id}" ?? "",
        "code":"${ProdLists[i]?.code}" ?? "",
        "origine_id":"${ProdLists[i]?.origine_id}" ?? "",
        "sous_prefecture_id":"${ProdLists[i]?.sous_prefecture_id}" ?? "",
        "genre":"${ProdLists[i]?.genre}" ?? "",
        "type_producteur":"${ProdLists[i]?.type_producteur}" ?? "",
        "nom":"${ProdLists[i]?.nom}" ?? "",
        "dob": ProdLists[i]?.dob == ""|| ProdLists[i]?.dob == null  ? "1900-12-31T05:00:00.000": "${ProdLists[i]?.dob}",
        "contacts":"${ProdLists[i]?.contacts}" ?? "",
        "localite":"${ProdLists[i]?.localite}" ?? "",
        "nb_enfant":"${ProdLists[i]?.nb_enfant}" ?? "",
        "nb_epouse":"${ProdLists[i]?.nb_epouse}" ?? "",
        "section_id":"${ProdLists[i]?.section_id}" ?? "",
        "sous_section_id":"${ProdLists[i]?.sous_section_id}" ?? "",
        "nb_parcelle":"${ProdLists[i]?.nb_parcelle}" ?? "",
        "image":"${ProdLists[i]?.image}" ?? "",
        "type_document":"${ProdLists[i]?.type_document}" ?? "",
        "num_document":"${ProdLists[i]?.num_document}" ?? "",
        "document":"${ProdLists[i]?.document}" ?? "",
        "cooperative_id":"${ProdLists[i]?.cooperative_id}" ?? "",
        "enfant_scolarise":"${ProdLists[i]?.enfant_scolarise}" ?? "",
        "nb_personne":ProdLists[i]?.nb_personne == ""|| ProdLists[i]?.nb_personne == null  ? "0": "${ProdLists[i]?.nb_personne}",
        "user_id":ProdLists[i]?.user_id == ""|| ProdLists[i]?.user_id == null  ? "0": "${ProdLists[i]?.user_id}",
      };

      print(data);

      final response = await http.post(Uri.parse('https://fpmpro.pythonanywhere.com/cooperatives/apiCreateProd/'),
        body: data
      );

      if(response.statusCode  == 200){
        print("Saving Data ok ");
      }else{
        print(response.statusCode);
      }

       final detup = await db.rawUpdate("UPDATE cooperatives_producteur SET synchro = ? WHERE code = ? ",["OUI",ProdLists[i]?.code]);    

    }
  }

    Future saveToDetailPlantingserver(List detailplant) async {
     final db = await con.db;
    for(var i = 0; i < detailplant.length; i++){
      Map<String,dynamic> data = {
        "code":"${detailplant[i]?.code}" ?? "",
        "nb_plante":"${detailplant[i]?.nb_plante}" ?? "",
        "planting_id":"${detailplant[i]?.planting_id}" ?? "",
        "espece_id":"${detailplant[i]?.espece_id}" ?? "",
        // "mort_global":"${detailplant[i]?.mort_global}" ?? "",
      };

      print(data);

      final response = await http.post(Uri.parse('https://fpmpro.pythonanywhere.com/cooperatives/apiCreatedetailPlant/'),
        body: data
      );

      if(response.statusCode  == 200){
        print("Saving Data ok ");
      }else{
        print(response.statusCode);
      }

      final detup = await db.rawUpdate("UPDATE cooperatives_detailplanting SET synchro = ? WHERE code = ? ",["OUI",detailplant[i]?.code]);    

    }
  }


  Future<List<Producteur>> getProductServer() async {
    final db = await con.db;
    final url = "https://fpmpro.pythonanywhere.com/cooperatives/apiProdListCoop/${usercoop_id}";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var data = json.decode(response.body) as List<dynamic>;
      List<Producteur> Prod = data.map((json) => Producteur.fromJson(json)).toList(); 

      for(var i = 0; i < Prod.length; i++){
        final  id = await db.insert(tableProducteur, Prod[i].toJson(),conflictAlgorithm: ConflictAlgorithm.ignore);
         print(id);
      }

     

    }
  }


}




