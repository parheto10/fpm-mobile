import 'dart:core';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String tableParcelle = 'cooperatives_parcelle';

class ParcelleFields {
  static final List<String> values = [
    code,
    code_certificat,
    annee_certificat,
    annee_acquis,
    acquisition,
    longitude,
    superficie,
    culture,
    certification,
    producteur_id,
    latitude,
    synchro,
    user_id,
    projet_id,
    created_at,
    updated_at
  ];

  // static final String id = 'id';
  static final String code = 'code';
  static final String code_certificat = 'code_certificat';
  static final String annee_certificat = 'annee_certificat';
  static final String annee_acquis = 'annee_acquis';
  static final String acquisition = 'acquisition';
  static final String longitude = 'longitude';
  static final String superficie = 'superficie';
  static final String culture = 'culture';
  static final String certification = 'certification';
  static final String producteur_id = 'producteur_id';
  static final String projet_id = 'projet_id';
  static final String latitude = 'latitude';
  static final String synchro = 'synchro';
  static final String user_id = 'user_id';
  static final String created_at = 'created_at';
  static final String updated_at = 'updated_at';
}



class AffichFields {
  static final List<String> values = [
    // id,
    code,
    code_certificat,
    annee_certificat,
    annee_acquis,
    acquisition,
    longitude,
    superficie,
    culture,
    certification,
    producteur_id,
    projet_id,
    nom,
    latitude,
    user_id,
    created_at,
    updated_at
  ];

  // static final String id = 'id';
  static final String code = 'code';
  static final String code_certificat = 'code_certificat';
  static final String annee_certificat = 'annee_certificat';
  static final String annee_acquis = 'annee_acquis';
  static final String acquisition = 'acquisition';
  static final String longitude = 'longitude';
  static final String superficie = 'superficie';
  static final String culture = 'culture';
  static final String projet_id = 'projet_id';
  static final String certification = 'certification';
  static final String producteur_id = 'producteur_id';
  static final String nom = 'nom';
  static final String latitude = 'latitude';
  static final String user_id = 'user_id';
  static final String created_at = 'created_at';
  static final String updated_at = 'updated_at';
}

class Parcelle {

  // final int id;
  final String code;
  final String code_certificat;
  final String annee_certificat;
  final String annee_acquis;
  final String acquisition;
  final String longitude;
  final String superficie;
  final String culture;
  final String certification;
  final String producteur_id;
  final int projet_id;
  final String nom;
  final String latitude;
  final String synchro;
  final int user_id;
  final DateTime created_at;
  final DateTime updated_at;

  Parcelle({
    // this.id,
    this.code,
    this.code_certificat,
    this.annee_certificat,
    this.annee_acquis,
    this.longitude,
    this.culture,
    this.certification,
    this.producteur_id,
    this.projet_id,
    this.nom,
    this.acquisition,
    this.latitude,
    this.synchro,
    this.superficie,
    this.user_id,
    this.created_at,
    this.updated_at
  });

  Parcelle copy({
  // int id,
  String code,
  String code_certificat,
  String annee_certificat,
  String annee_acquis,
  String acquisition,
  String longitude,
  String superficie,
  String culture,
  String certification,
  String producteur_id,
  int projet_id,
  String nom,
  String latitude,
  int user_id,
  DateTime created_at,
  DateTime updated_at,
  String synchro,

}) => 
Parcelle(
  // id: id ?? this.id,
  code: code ?? this.code,
  code_certificat: code_certificat ?? this.code_certificat,
  annee_certificat: annee_certificat ?? this.annee_certificat,
  annee_acquis: annee_acquis ?? this.annee_acquis,
  acquisition: acquisition ?? this.acquisition,
  longitude: longitude ?? this.longitude,
  superficie: superficie ?? this.superficie,
  culture: culture ?? this.culture,
  certification: certification ?? this.certification,
  producteur_id: producteur_id ?? this.producteur_id,
  projet_id: projet_id ?? this.projet_id,
  latitude: latitude ?? this.latitude,
  synchro: synchro ?? this.synchro,
  user_id: user_id ?? this.user_id,
  created_at: created_at ?? this.created_at,
  updated_at: updated_at ?? this.updated_at
);

static Parcelle fromJson(Map<String, Object> json) => Parcelle(
  // id: json[AffichFields.id] as int,
  code: json[AffichFields.code] as String,
  code_certificat: json[AffichFields.code_certificat] as String,
  annee_certificat: json[AffichFields.annee_certificat] as String,
  annee_acquis: json[AffichFields.annee_acquis] as String,
  acquisition: json[AffichFields.acquisition] as String,
  longitude: json[AffichFields.longitude] as String,
  superficie: json[AffichFields.superficie] as String,
  culture: json[AffichFields.culture] as String,
  certification: json[AffichFields.certification] as String,
  producteur_id: json[AffichFields.producteur_id] as String,
  projet_id: json[AffichFields.projet_id] as int,
  nom: json[AffichFields.nom] as String,
  latitude: json[AffichFields.latitude] as String,
  user_id: json[AffichFields.user_id] as int,
  created_at: json[AffichFields.created_at] != null ? DateTime.parse(json[AffichFields.created_at] as String ) : null,
  updated_at: json[AffichFields.updated_at] != null ? DateTime.parse(json[AffichFields.updated_at] as String ) : null,
);



Map<String, Object> toJson() => {
  // ParcelleFields.id: id,
  ParcelleFields.code: code,
  ParcelleFields.code_certificat: code_certificat,
  ParcelleFields.annee_certificat: annee_certificat,
  ParcelleFields.annee_acquis: annee_acquis,
  ParcelleFields.acquisition: acquisition,
  ParcelleFields.longitude: longitude,
  ParcelleFields.superficie: superficie,
  ParcelleFields.culture: culture,
  ParcelleFields.certification: certification,
  ParcelleFields.producteur_id: producteur_id,
  ParcelleFields.projet_id: projet_id,
  ParcelleFields.latitude: latitude,
  ParcelleFields.synchro: synchro,
  ParcelleFields.user_id: user_id,
  ParcelleFields.created_at: created_at.toIso8601String(),
  ParcelleFields.updated_at: updated_at.toIso8601String(),

};





}





