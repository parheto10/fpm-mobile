import 'dart:core';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String tableProducteur = 'cooperatives_producteur';

class ProdFields {
  static final List<String> values = [
    // id,
    code,
    origine_id,
    sous_prefecture_id,
    genre,
    type_producteur,
    nom,
    dob,
    contacts,
    localite,
    nb_enfant,
    nb_epouse,
    enfant_scolarise,
    section_id,
    sous_section_id,
    nb_parcelle,
    image,
    type_document,
    num_document,
    document,
    cooperative_id,
    nb_personne,
    is_active,
    user_id,
    created_at,
    updated_at,
    synchro
  ];

  // static final String id = 'id';
  static final String code = 'code';
  static final String origine_id = 'origine_id';
  static final String sous_prefecture_id = 'sous_prefecture_id';
  static final String genre = 'genre';
  static final String type_producteur = 'type_producteur';
  static final String nom = 'nom';
  static final String dob = 'dob';
  static final String contacts = 'contacts';
  static final String localite = 'localite';
  static final String nb_enfant = 'nb_enfant';
  static final String nb_epouse = 'nb_epouse';
  static final String enfant_scolarise = 'enfant_scolarise';
  static final String section_id = 'section_id';
  static final String sous_section_id = 'sous_section_id';
  static final String nb_parcelle = 'nb_parcelle';
  static final String image = 'image';
  static final String type_document = 'type_document';
  static final String num_document = 'num_document';
  static final String document = 'document';
  static final String cooperative_id = 'cooperative_id';
  static final String nb_personne = 'nb_personne';
  static final String is_active = 'is_active';
  static final String latitude = 'latitude';
  static final String user_id = 'user_id';
  static final String created_at = 'created_at';
  static final String updated_at = 'updated_at';
  static final String synchro = 'synchro';
}


class Producteur {
  // final  int id;
  final  String code;
  final  int origine_id;
  final  int sous_prefecture_id;
  final  String genre;
  final  String type_producteur;
  final  String nom;
  final  DateTime dob;
  final  String contacts;
  final  String localite;
  final  int nb_enfant;
  final  int nb_epouse;
  final  int enfant_scolarise;
  final  int section_id ;
  final  int sous_section_id ;
  final  int nb_parcelle;
  final  String image ;
  final  String type_document; 
  final  String num_document;
  final  String document ;
  final  String synchro ;
  final  int cooperative_id ;
  final  int nb_personne ;
  final  int is_active ;
  final int user_id;
  final DateTime created_at;
  final DateTime updated_at;


  Producteur({
      
      // this.id,
        this.code,
        this.nom,
        this.dob,
        this.contacts,
        this.localite,
        this.origine_id,
        this.sous_prefecture_id,
        this.genre,
        this.type_producteur,
        this.nb_enfant,
        this.nb_epouse,
        this.enfant_scolarise,
        this.section_id,
        this.sous_section_id,
        this.nb_parcelle, 
        this.image,
        this.type_document,
        this.num_document,
        this.document,
        this.cooperative_id, 
        this.nb_personne, 
        this.is_active, 
        this.user_id,
        this.created_at,
        this.updated_at,
        this.synchro

        });

        Producteur copy({
          // int id,
          String code,
          String nom,
          DateTime dob,
          String contacts,
          int origine_id,
          int sous_prefecture_id,
          String genre,
          String type_producteur,
          int nb_enfant,
          int nb_epouse,
          String localite,
          int enfant_scolarise,
          int section_id,
          int sous_section_id,
          int nb_parcelle,
          String image,
          String synchro,
          String type_document,
          String num_document,
          int cooperative_id,
          int nb_personne,
          int is_active,
          int user_id,
          DateTime created_at,
          DateTime updated_at,
          
        }) => 
        Producteur(
          // id: id ?? this.id,
          code: code ?? this.code,
          nom: nom ?? this.nom,
          dob: dob ?? this.dob,
          contacts: contacts ?? this.contacts,
          origine_id: origine_id ?? this.origine_id,
          sous_prefecture_id: sous_prefecture_id ?? this.sous_prefecture_id,
          genre: genre ?? this.genre,
          type_document: type_document ?? this.type_document,
          type_producteur: type_producteur ?? this.type_producteur,
          nb_enfant: nb_enfant ?? this.nb_enfant,
          nb_epouse: nb_epouse ?? this.nb_epouse,
          enfant_scolarise: enfant_scolarise ?? this.enfant_scolarise,
          section_id: section_id ?? this.section_id,
          sous_section_id: sous_section_id ?? this.sous_section_id,
          nb_parcelle: nb_parcelle ?? this.nb_parcelle,
          image: image ?? this.image,
          num_document: num_document ?? this.num_document,
          cooperative_id: cooperative_id ?? this.cooperative_id,
          nb_personne: nb_personne ?? this.nb_personne,
          localite: localite ?? this.localite,
          is_active: is_active ?? this.is_active,
          user_id: user_id ?? this.user_id,
          created_at: created_at ?? this.created_at,
          updated_at: updated_at ?? this.updated_at,
          synchro: synchro ?? this.synchro
        );

  static Producteur fromJson(Map<String, Object> json) => Producteur(
  // id: json[ProdFields.id] as int,
  code: json[ProdFields.code] as String,
  origine_id: json[ProdFields.origine_id] == null ? 1 :(json[ProdFields.origine_id] as int),
  nom: json[ProdFields.nom] as String,
  // dob: json[ProdFields.dob] != "" ? DateTime.parse(json[ProdFields.dob] as String ) : DateTime.parse("2020-05-31 05:41:42"),
  dob: json[ProdFields.dob] != null ? DateTime.parse(json[ProdFields.dob] as String ) : null,
  contacts: json[ProdFields.contacts] as String,
  localite: json[ProdFields.localite] as String,
  sous_prefecture_id: json[ProdFields.sous_prefecture_id]  == null ? 1 :(json[ProdFields.sous_prefecture_id] as int),
  genre: json[ProdFields.genre] as String,
  type_producteur: json[ProdFields.type_producteur] as String,
  nb_enfant: json[ProdFields.nb_enfant] as int,
  nb_epouse: json[ProdFields.nb_epouse] as int,
  enfant_scolarise: json[ProdFields.enfant_scolarise] as int,
  section_id: json[ProdFields.section_id] as int,
  sous_section_id: json[ProdFields.sous_section_id]   == null ? 1 :(json[ProdFields.sous_section_id] as int),
  nb_parcelle: json[ProdFields.nb_parcelle] as int,
  image: json[ProdFields.image] as String,
  type_document: json[ProdFields.type_document] as String,
  cooperative_id: json[ProdFields.cooperative_id] as int,
  nb_personne: json[ProdFields.nb_personne] as int,
  num_document:json[ProdFields.num_document] as String ,
  user_id: json[ProdFields.user_id] as int,
  created_at: json[ProdFields.created_at] != null ? DateTime.parse(json[ProdFields.created_at] as String ) : null,
 // updated_at: json[ProdFields.updated_at] != null ? DateTime.parse(json[ProdFields.updated_at] as String ) : null,
);


Map<String, Object> toJson() => {
  // ProdFields.id: id,
  ProdFields.code : code,
  ProdFields.contacts : contacts,
  ProdFields.cooperative_id : cooperative_id,
  ProdFields.dob : dob.toIso8601String(),
  ProdFields.document : document,
  ProdFields.enfant_scolarise : enfant_scolarise,
  ProdFields.nb_enfant : nb_enfant,
  ProdFields.nb_epouse : nb_epouse,
  ProdFields.nb_parcelle : nb_parcelle,
  ProdFields.nb_personne : nb_personne,
  ProdFields.image : image,
  ProdFields.localite : localite,
  ProdFields.genre : genre,
  ProdFields.nom : nom,
  ProdFields.num_document : num_document,
  ProdFields.origine_id : origine_id,
  ProdFields.section_id : section_id,
  ProdFields.sous_prefecture_id : sous_prefecture_id,
  ProdFields.sous_section_id : sous_section_id,
  ProdFields.type_document : type_document,
  ProdFields.type_producteur: type_producteur,
  ProdFields.is_active: is_active,
  ProdFields.synchro: synchro,
  ProdFields.user_id: user_id,
  ProdFields.created_at: created_at.toIso8601String(),
  ProdFields.updated_at: updated_at.toIso8601String(),
};



}
