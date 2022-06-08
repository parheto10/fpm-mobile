import 'dart:io';
import 'dart:typed_data';
import 'package:argon_flutter/data_services/cooperatives.dart';
import 'package:argon_flutter/data_services/producteur.dart';
import 'package:argon_flutter/models/monitoring.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  DatabaseHelper.internal();
  
  static final DatabaseHelper instance =  new DatabaseHelper.internal();
  factory DatabaseHelper() => instance;
  //  final int usercoop_id = User.sessionUser.cooperative_id; 


  static Database _db;

  Future<Database> get db async {
    if (_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  // DatabaseHelper.internal();

  initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,"db.sqlite3");

    final exist  = await databaseExists(path);

    if(exist){
      var ourDb = await openDatabase(path);
    }else{

      try {

        await Directory(dirname(path)).create(recursive: true);
        
      } catch (e) {
      }

      ByteData data = await rootBundle.load(join('data','db.sqlite3'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes,flush: true);

    }
      var ourDb = await openDatabase(path);

    return ourDb;

    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentDirectory.path, "db.sqlite3");
    // ByteData data = await rootBundle.load(join('data','db.sqlite3'));
    // List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // await new File(path).writeAsBytes(bytes);
    // var ourDb = await openDatabase(path);
    // return ourDb;
  }


  Future<int> getNumberOfProducteurCoop(int coopId) async {
     Database db = await instance.db; 
     final count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) as nb FROM cooperatives_producteur WHERE cooperative_id = '$coopId' ")
     );
      print('Producteur count: $count');
     return count;
  }

  Future<Cooperative> firstCoop(int id) async { 
    Database db = await instance.db;
    final resultat = await db.rawQuery("SELECT * FROM parametres_cooperative WHERE id = '$id' ");
    if (resultat.length > 0){
      return new Cooperative.fromJson(resultat.first);
    }
    return null;
  }

  Future<DetailMonitoring> firstDetailMonitoring(String id) async { 
    Database db = await instance.db;
    final resultat = await db.rawQuery("SELECT * FROM cooperatives_detailmonitoring WHERE monitoring_id = '$id' ");
    if (resultat.length > 0){
      return  DetailMonitoring.fromJson(resultat.first);
    }
    return null;
  }

  Future<int> getNumberOfParcelleCoop(int coopId) async {
     Database db = await instance.db; 
     final count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) as nb FROM parametres_cooperative as c INNER JOIN cooperatives_producteur as pr ON c.id = pr.cooperative_id INNER JOIN  cooperatives_parcelle as pa ON pr.code = pa.producteur_id  WHERE pr.cooperative_id = '$coopId' ")
     );     
      
      if(count != null){
        print('parcelle count: $count');
        return count;
      }else{
        print("object");
      }     
  }

  Future<int> getNumberOfMonitoringForPlanting(String planting) async {
     Database db = await instance.db; 
    final  count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) as nb FROM cooperatives_monitoring  WHERE planting_id = '$planting' ")
     );     
      
      if(count != null){
        print('monitoring count: $count');
        return count;           
      }else{
        print("object");
      }     
  }

   getNumberEspecePlanting(String plantingId) async {
     Database db = await instance.db; 
     final count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) as nb FROM cooperatives_detailplanting  WHERE planting_id = '$plantingId' ")
     );   
      
      if(count != null){
        print('espece count: $count');
        return count;
      }else{
        print("object");
      }     
  }

  Future<int> getNumParcProd(String prod) async {
    Database db = await instance.db;
    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) as nb FROM cooperatives_parcelle WHERE producteur_id = '$prod' ")
    );
    if(count != null){
        print('parcelle producteur count: $count');
        return count;
    }else{
        print("object");
    }
    
  }


  Future getProdListForCoop(int coopId) async {
    Database db = await instance.db;
    final resultats = await db.rawQuery("SELECT * FROM cooperatives_producteur WHERE cooperative_id = '$coopId' ");
    return resultats.map((json) => Producteur.fromJson(json)).toList();
  }
  
  Future getParcListForCoop(int coopId) async {
    Database db = await instance.db;
    final resultats = await db.rawQuery("SELECT p.code,p.code_certificat,p.annee_certificat,p.annee_acquis,p.acquisition,p.longitude,p.superficie,p.culture,p.certification,p.producteur_id,p.latitude,p.user_id,p.created_at,p.updated_at FROM cooperatives_parcelle as p INNER JOIN cooperatives_producteur as pr on p.producteur_id = pr.code WHERE pr.cooperative_id = '$coopId' ORDER BY pr.nom ");
    // print(resultats);
    return resultats.map((json) => Parcelle.fromJson(json)).toList();
  }

/////////////////////CREATE AND UPDATE ///////////////////////////////////////


  Future<Parcelle> createParcelle(Parcelle parcelle) async {
    Database db = await instance.db;
    try {      
      final  code = await db.insert(tableParcelle, parcelle.toJson());
    }on DatabaseException catch (e) {
      print(e.toString());
    }       
  }

    createPlanting(Planting planting) async {
      Database db = await instance.db;
      try {             
        final  id = await db.insert(tablePlanting, planting.toJson());
      }on DatabaseException catch (e) {
        print(e.toString());
      }  
   
    }
    createdetailPlanting(DetailPlanting detailPlanting) async {
      Database db = await instance.db;
      try {             
        final  id = await db.insert(tableDetailPlanting, detailPlanting.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,);
      }on DatabaseException catch (e) {
        print(e.toString());
      }  
    }
    createMonitoring(Monitoring monitoring) async {
      Database db = await instance.db;
      try {             
         int  code = await db.insert(tableMonitoring, monitoring.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,);
        // monitoring.copy(id: id); 
        final detailmonitoring = DetailMonitoring(
          code: "${DateTime.now().millisecondsSinceEpoch}DMT",
          monitoring_id: monitoring.code
        );

        final idM = await db.insert(tabledetailMonitoring, detailmonitoring.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
      }on DatabaseException catch (e) {
        print(e.toString());
      }  
   
    }

    createMonitoringEspece(MonitoringEspece monitoringepece,Monitoring monitoring,DetailPlanting detailplant) async {
      Database db = await instance.db;
      try {             
        final id = await db.insert(tableMonitoringespece, monitoringepece.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,); 
        final up = await db.update(tableMonitoring,monitoring.toJson(),where: '${MonitoringField.code} =  ?',whereArgs: [monitoring.code],);
        final detup = await db.rawUpdate("UPDATE cooperatives_detailplanting SET etat = ? WHERE code = ? ",[1,detailplant.code]);    
      }on DatabaseException catch (e) {
        print(e.toString());
      }  
   
    }

    createMonitoringObs(ObservationMonitoring obs) async {
        Database db = await instance.db;
        try {             
          final  id = await db.insert(tableobservationMonitoring, obs.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,);
        }on DatabaseException catch (e) {
          print(e.toString());
        }  
    }
    createProducteurs(Producteur prod) async {
        Database db = await instance.db;
        try {             
          final  id = await db.insert(tableProducteur, prod.toJson(),conflictAlgorithm: ConflictAlgorithm.fail,);
        }on DatabaseException catch (e) {
          print(e.toString());
        }  
    }

  Future<int> updatePlanting(Planting planting) async {
    Database db = await instance.db;
    return db.update(
      tablePlanting,
      planting.toJson(),
      where: '${PlantingFields.code} =  ?',
      whereArgs: [planting.code],
      );
  }
  Future<int> updateProd(Producteur prod) async {
    Database db = await instance.db;
    return db.update(
      tableProducteur,
      prod.toJson(),
      where: '${ProdFields.code} =  ?',
      whereArgs: [prod.code],
      );
  }
  Future<int> updateDetailplant(DetailPlanting detailPlanting) async {
    Database db = await instance.db;
    return db.update(
      tableDetailPlanting,
      detailPlanting.toJson(),
      where: '${DetailPlantingFields.code} =  ?',
      whereArgs: [detailPlanting.code],
      );
  }

  Future<int> updateParcelle(Parcelle parcelle) async {
    Database db = await instance.db;

    return db.update(tableParcelle,
          parcelle.toJson(),
          where: '${ParcelleFields.code} =  ?',
          whereArgs: [parcelle.code],
        );

  }


/////////////////////////////END CREATE AND UPDATE/////////////////////////////

  Future<int> deleteDetailPlanting(String code) async {
        Database db = await instance.db;

       return await db.delete(
         tableDetailPlanting,
         where: '${DetailPlantingFields.code} = ?',
         whereArgs: [code],
       );
  }

/////////////////////////////END DELETE/////////////////////////////



    getCampagne() async {
        Database db = await instance.db;
        var resultats = await db.query("parametres_campagne");
        return resultats;
    }
    getObservations() async {
        Database db = await instance.db;
        var resultats = await db.query("parametres_obsmonitoring");
        return resultats;
    }

    getProjets() async {
        Database db = await instance.db;
        var resultats = await db.query("parametres_projet");
        // print(resultats);
        return resultats;
    }
    getEspeces() async {
        Database db = await instance.db;
        var resultats = await db.query("parametres_espece");
        return resultats;
    }
    getSections() async {
        Database db = await instance.db;
        var resultats = await db.rawQuery("SELECT * FROM cooperatives_section WHERE id = '44' OR cooperative_id = '${User.sessionUser.cooperative_id}' ");
        // print(usercoop_id);
        return resultats;
    }


    getPlantingEspece(String plant) async{
        Database db = await instance.db;
        final resultats = await db.rawQuery("SELECT dp.code,dp.espece_id,dp.nb_plante,dp.planting_id,ec.libelle,ec.accronyme FROM cooperatives_detailplanting as dp INNER JOIN parametres_espece as ec ON dp.espece_id = ec.id WHERE dp.planting_id = '$plant'  ");
        return resultats.map((json) => DetailPlanting.fromJson(json)).toList();
    }

    Future<Monitoring>  getLastMonitoringForPlanting(String plant)async{
        Database db = await instance.db;
        final resultat = await db.rawQuery("SELECT MAX(code),mort_global FROM cooperatives_monitoring  WHERE  planting_id = '$plant'  "); 
        return Monitoring.fromJson(resultat.first);
    }


}