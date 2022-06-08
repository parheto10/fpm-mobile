import 'package:argon_flutter/models/user.dart';

class Cooperative {
  int id;
  int user;
  Region region;
  String sigle;
  List<Projet> projet;
  String contacts;
  String logo;
  int totalProducteurs;

  Cooperative(
      {this.id,
        this.user,
        this.region,
        this.sigle,
        this.projet,
        this.contacts,
        this.logo,
        this.totalProducteurs});

  Cooperative.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    region =
    json['region'] != null ? new Region.fromJson(json['libelle']) : null;
    sigle = json['sigle'];
    if (json['projet'] != null) {
      projet = <Projet>[];
      json['projet'].forEach((v) {
        projet.add(new Projet.fromJson(v));
      });
    }
    contacts = json['contacts'];
    logo = json['logo'];
    totalProducteurs = json['total_producteurs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;  
    data['user'] = this.user;
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    data['sigle'] = this.sigle;
      data['projet'] = this.projet;
    data['contacts'] = this.contacts;
    data['logo'] = this.logo;
    data['total_producteurs'] = this.totalProducteurs;
    return data;
  }
}

// class User {
//   int id;
//   String password;
//   String lastLogin;
//   bool isSuperuser;
//   String username;
//   String firstName;
//   String lastName;
//   String email;
//   bool isStaff;
//   bool isActive;
//   String dateJoined;
//   List<int> groups;
//   // List<Null> userPermissions;

//   // User(
//   //     {this.id,
//   //       this.password,
//   //       this.lastLogin,
//   //       this.isSuperuser,
//   //       this.username,
//   //       this.firstName,
//   //       this.lastName,
//   //       this.email,
//   //       this.isStaff,
//   //       this.isActive,
//   //       this.dateJoined,
//   //       this.groups,
//   //       // this.userPermissions
//   //     });

//   // User.fromJson(Map<String, dynamic> json) {
//   //   id = json['id'];
//   //   password = json['password'];
//   //   lastLogin = json['last_login'];
//   //   isSuperuser = json['is_superuser'];
//   //   username = json['username'];
//   //   firstName = json['first_name'];
//   //   lastName = json['last_name'];
//   //   email = json['email'];
//   //   isStaff = json['is_staff'];
//   //   isActive = json['is_active'];
//   //   dateJoined = json['date_joined'];
//   //   groups = json['groups'].cast<int>();
//   //   // if (json['user_permissions'] != null) {
//   //   //   userPermissions = <Null>[];
//   //   //   json['user_permissions'].forEach((v) {
//   //   //     userPermissions.add(new Null.fromJson(v));
//   //   //   });
//   //   // }
//   // }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['password'] = this.password;
//     data['last_login'] = this.lastLogin;
//     data['is_superuser'] = this.isSuperuser;
//     data['username'] = this.username;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     data['is_staff'] = this.isStaff;
//     data['is_active'] = this.isActive;
//     data['date_joined'] = this.dateJoined;
//     data['groups'] = this.groups;
//     // if (this.userPermissions != null) {
//     //   data['user_permissions'] =
//     //       this.userPermissions!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }

class Region {
  int id;
  String libelle;

  Region({this.id, this.libelle});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['libelle'] = this.libelle;
    return data;
  }
}

class Projet {
  int id;
  String sigle;
  String titre;
  String chef;
  String debut;
  String fin;
  String etat;
  int categorie;

  Projet(
      {this.id,
        this.sigle,
        this.titre,
        this.chef,
        this.debut,
        this.fin,
        this.etat,
        this.categorie});

  Projet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sigle = json['sigle'];
    titre = json['titre'];
    chef = json['chef'];
    debut = json['debut'];
    fin = json['fin'];
    etat = json['etat'];
    categorie = json['categorie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sigle'] = this.sigle;
    data['titre'] = this.titre;
    data['chef'] = this.chef;
    data['debut'] = this.debut;
    data['fin'] = this.fin;
    data['etat'] = this.etat;
    data['categorie'] = this.categorie;
    return data;
  }
}
