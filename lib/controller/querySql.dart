import 'package:argon_flutter/data_services/cooperatives.dart';
// import 'package:argon_flutter/data_services/parcelles.dart';
import 'package:argon_flutter/data_services/producteur.dart';
import 'package:argon_flutter/models/campagne.dart';
import 'package:argon_flutter/models/monitoring.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'dart:async';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';


class QuerySql {

  DatabaseHelper con =  new DatabaseHelper();

  // REQUETE MODEL USER

  Future<User> getLogin(String user, String password) async {
    var dbUser = await con.db;
    var resultat =  await dbUser.rawQuery("SELECT * FROM auth_user WHERE username = '$user' and password = '$password' and is_active = '1' ");

    if (resultat.length > 0){
      return new User.fromJson(resultat.first);
    }

    return null;
  }

  Future<List<User>> getAllUsers() async {
    var dbUser = await con.db;
    var resultats = await dbUser.query("auth_user");
    List<User> list = 
          resultats.isNotEmpty ? resultats.map((e) => User.fromJson(e)).toList(): null;
      
    return list;
  }


  getCampagne() async {
        var dbUser = await con.db;
        var resultats = await dbUser.query("parametres_campagne");
        // return Campagne.fromJson(resultats[0]);
    }

  Future Listcoop() async {
    var db = await con.db;    
    final resultats = await db.query("parametres_cooperative", orderBy: 'sigle ASC');
    return resultats.map((json) => Cooperative.fromJson(json)).toList();
    
  }


  Future<List<Producteur>> getProdListForCoop(int coopId) async {
    // var data  =[];
    var db = await con.db;
    final resultats = await db.rawQuery("SELECT * FROM cooperatives_producteur WHERE cooperative_id = '$coopId' ORDER BY nom ASC ");
    List<Producteur> list = resultats.map((json) => Producteur.fromJson(json)).toList(); 
    return list;

  }

    Future<List<Producteur>> getProdListSearchForCoop({String query,int coopId}) async {
    // var data  =[];
    var db = await con.db;
    final resultats = await db.rawQuery("SELECT * FROM cooperatives_producteur WHERE cooperative_id = '$coopId' ORDER BY nom ASC ");
    List<Producteur> list = resultats.map((json) => Producteur.fromJson(json)).toList();
    if(query != ""){
     list = list.where((element) => element.code.toLowerCase().contains(query.toLowerCase()) || element.nom.toLowerCase().contains(query.toLowerCase())).toList() ;
    } else {
        // throw Exception("Aucun Resultat");
    }   
    return list;

  }

   Future getParcListForCoop(int coopId) async {
    var db = await con.db;
    final resultats = await db.rawQuery("SELECT p.code,p.code_certificat,p.annee_certificat,p.annee_acquis,p.acquisition,p.longitude,p.superficie,p.culture,p.certification,p.producteur_id,p.latitude,p.user_id,p.projet_id,p.created_at,p.updated_at,pr.nom FROM cooperatives_parcelle as p INNER JOIN cooperatives_producteur as pr on p.producteur_id = pr.code WHERE pr.cooperative_id = '$coopId' ORDER BY pr.nom ASC ");
    // print(resultats);
    return resultats.map((json) => Parcelle.fromJson(json)).toList();

  }

  Future<List<Parcelle>> getParcListSearchForCoop({int coopId,String query}) async {
    var db = await con.db;
    final resultats = await db.rawQuery("SELECT p.code,p.code_certificat,p.annee_certificat,p.annee_acquis,p.acquisition,p.longitude,p.superficie,p.culture,p.certification,p.producteur_id,p.latitude,p.user_id,p.created_at,p.updated_at,pr.nom FROM cooperatives_parcelle as p INNER JOIN cooperatives_producteur as pr on p.producteur_id = pr.code WHERE pr.cooperative_id = '$coopId' ORDER BY pr.nom ASC ");
     List<Parcelle> list =  resultats.map((json) => Parcelle.fromJson(json)).toList();
      if (query != null){
          list = list.where(
                  (element) => element.code.toLowerCase().contains(query.toLowerCase()) || element.nom.toLowerCase().contains(query.toLowerCase())
          ).toList();
        } else {
          // throw Exception("Aucun Resultat");
        }
    return list;

  }


  Future getPlantingForParcelle(String parc) async{
    var db = await con.db;
    final resultats = await db.rawQuery("SELECT * FROM cooperatives_planting  WHERE parcelle_id = '$parc' ORDER BY date DESC  ");
    return resultats.map((json) => Planting.fromJson(json)).toList();


}
  Future getMonitoringForPlantings(String plant) async{
    var db = await con.db;
    final resultats = await db.rawQuery("SELECT * FROM cooperatives_monitoring  WHERE planting_id = '$plant' ORDER BY date DESC  ");
    return resultats.map((json) => Monitoring.fromJson(json)).toList();


}




}