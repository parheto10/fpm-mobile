import 'dart:core';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String tablePlanting = 'cooperatives_planting';
final String tableDetailPlanting = 'cooperatives_detailplanting';

class PlantingFields {
  static final List<String> values = [
    code,
    nb_plant_exitant,
    plant_recus,
    plant_total,
    date,
    campagne_id,
    parcelle_id,
    synchro,
    user_id,
  ];

  static final String code = 'code';
  static final String nb_plant_exitant  = 'nb_plant_exitant';
  static final String plant_recus  = 'plant_recus';
  static final String plant_total  = 'plant_total';
  static final String date  = 'date';
  static final String campagne_id  = 'campagne_id';
  static final String parcelle_id  = 'parcelle_id';
  static final String synchro  = 'synchro';
  static final String user_id  = 'user_id';


}
class PlantingAffichFields {
  static final List<String> values = [
    code,
    nb_plant_exitant,
    plant_recus,
    plant_total,
    date,
    campagne_id,
    parcelle_id,
    synchro,
    nom,
    codeparc,
    user_id,
  ];

  static final String code = 'code';
  static final String nb_plant_exitant  = 'nb_plant_exitant';
  static final String plant_recus  = 'plant_recus';
  static final String plant_total  = 'plant_total';
  static final String date  = 'date';
  static final String campagne_id  = 'campagne_id';
  static final String parcelle_id  = 'parcelle_id';
  static final String synchro  = 'synchro';
  static final String nom  = 'nom';
  static final String codeparc  = 'codeparc';
  static final String user_id  = 'user_id';


}
class Planting {
  final String code;
  final int nb_plant_exitant;
  final int plant_recus;
  final int plant_total;
  final DateTime date;
  final int campagne_id;
  final String parcelle_id;
  // final int projet_id;
  final int user_id;
  final String nom;
  final String codeparc;
  final String synchro;

  Planting({this.code, 
  this.nb_plant_exitant, 
  this.plant_recus, 
  this.plant_total, 
  this.date, 
  this.campagne_id, 
  this.parcelle_id, 
  // this.projet_id,
  this.user_id,
  this.codeparc,
  this.nom,
  this.synchro
  });

  Planting copy({
    String code,
    int nb_plant_exitant,
    int plant_recus,
    int plant_total,
    DateTime date,
    int campagne_id,
    int parcelle_id,
    // int projet_id,
    int user_id,
    // String nom,
    String synchro,

  }) => 
  Planting(
    code: code ?? this.code,
    nb_plant_exitant: nb_plant_exitant ?? this.nb_plant_exitant,
    plant_recus: plant_recus ?? this.plant_recus,
    plant_total: plant_total ?? this.plant_total,
    date: date ?? this.date,
    campagne_id: campagne_id ?? this.campagne_id,
    parcelle_id: parcelle_id ?? this.parcelle_id,
    synchro: synchro ?? this.synchro,
    user_id: user_id ?? this.user_id
  );

  static Planting fromJson(Map<String, Object>json ) => Planting(
    code: json[PlantingAffichFields.code] as String,
    nb_plant_exitant: json[PlantingAffichFields.nb_plant_exitant] as int,
    plant_recus: json[PlantingAffichFields.plant_recus] as int,
    plant_total: json[PlantingAffichFields.plant_total] as int,
    parcelle_id: json[PlantingAffichFields.parcelle_id] as String,
    campagne_id: json[PlantingAffichFields.campagne_id] as int,
    date: json[PlantingAffichFields.date] != null ? DateTime.parse(json[PlantingAffichFields.date] as String) : null,
    user_id: json[PlantingAffichFields.user_id] as int,
    synchro: json[PlantingAffichFields.synchro] as String,
  );

  Map<String, Object>toJson() => {
    PlantingFields.code: code,
    PlantingFields.nb_plant_exitant : nb_plant_exitant,
    PlantingFields.plant_recus : plant_recus,
    PlantingFields.plant_total : plant_total,
    PlantingFields.date : date.toIso8601String(),
    PlantingFields.campagne_id : campagne_id,
    PlantingFields.parcelle_id : parcelle_id,
    PlantingFields.synchro : synchro,
    PlantingFields.user_id : user_id,
  };

  
}

class DetailPlantingFields {
  static final List<String> values = [
    code,
    nb_plante,
    espece_id,
    planting_id,
    user_id,
    synchro
  ];

  static final String code = 'code';
  static final String nb_plante = 'nb_plante';
  static final String espece_id = 'espece_id';
  static final String planting_id = 'planting_id';
  static final String user_id = 'user_id';
  static final String synchro = 'synchro';


}
class DetailPlantingAfficheFields {
  static final List<String> values = [
    code,
    nb_plante,
    espece_id,
    planting_id,
    libelle,
    accronyme,
    user_id,
    synchro
  ];

  static final String code = 'code';
  static final String nb_plante = 'nb_plante';
  static final String espece_id = 'espece_id';
  static final String libelle = 'libelle';
  static final String accronyme = 'accronyme';
  static final String planting_id = 'planting_id';
  static final String user_id = 'user_id';
  static final String synchro = 'synchro';


}



class DetailPlanting {
  final String code;
  final int  nb_plante;
  final int  espece_id;
  final String  planting_id;
  final String libelle;
  final String accronyme;
  final int user_id;
  final String synchro;

  DetailPlanting({
    this.code, 
    this.nb_plante, 
    this.espece_id, 
    this.planting_id,
    this.accronyme,
    this.libelle,
    this.user_id,
    this.synchro
  });

   DetailPlanting copy({
    String code,
    int nb_plante,
    int espece_id,
    String planting_id,
    String libelle,
    String accronyme,
    int user_id,
    String synchro

  }) => 
  DetailPlanting(
    code: code ?? this.code,
    nb_plante: nb_plante ?? this.nb_plante,
    espece_id: espece_id ?? this.espece_id,
    planting_id: planting_id ?? this.planting_id,
    libelle: libelle ?? this.libelle,
    accronyme: accronyme ?? this.accronyme,
    user_id: user_id ?? this.user_id,
    synchro: synchro ?? this.synchro,
  );


  static DetailPlanting fromJson(Map<String, Object>json ) => DetailPlanting(
    code: json[DetailPlantingAfficheFields.code] as String,
    nb_plante: json[DetailPlantingAfficheFields.nb_plante] as int,
    espece_id: json[DetailPlantingAfficheFields.espece_id] as int,
    planting_id: json[DetailPlantingAfficheFields.planting_id] as String,
    accronyme: json[DetailPlantingAfficheFields.accronyme] as String,
    libelle: json[DetailPlantingAfficheFields.libelle] as String,
    user_id: json[DetailPlantingAfficheFields.user_id] as int,
    // synchro: json[DetailPlantingAfficheFields.synchro] as String,
  );

  Map<String, Object> toJson() => {
    DetailPlantingFields.code : code,
    DetailPlantingFields.nb_plante : nb_plante,
    DetailPlantingFields.espece_id : espece_id,
    DetailPlantingFields.planting_id : planting_id,
    DetailPlantingFields.user_id : user_id,
    DetailPlantingFields.synchro : synchro
  };


}