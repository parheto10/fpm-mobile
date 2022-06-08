import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  int id;
  String password;
  String last_login;
  int is_superuser;
  String username;
  String last_name;
  String email;
  int is_staff;
  int is_active;
  String date_joined;
  String first_name;
  int groupe;
  int cooperative_id;
  int client_id;
  int role;

  static User sessionUser;


  User({
      this.id,
      this.first_name,
      this.last_name,
      this.last_login,
      this.email,
      this.is_active,
      this.date_joined,
      this.is_staff,
      this.is_superuser,
      this.password,
      this.username,
      this.client_id,
      this.cooperative_id,
      this.groupe,
      this.role
      });

  factory User.fromJson(Map<String, dynamic> obj){

    return User(
      id: obj['id'],
       first_name: obj['first_name'], 
       last_name: obj['last_name'], 
       last_login : obj['last_login'], 
       email : obj['email'], 
       is_active :obj['is_active'],
       date_joined:obj['date_joined'] , 
       is_staff:obj['is_staff'] , 
       is_superuser:obj['is_superuser'] ,
       password:obj['password'] , 
       username:obj['username'] ,
       client_id:obj['client_id'] ,
       cooperative_id:obj['cooperative_id'] ,
       groupe:obj['groupe'] ,
       role:obj['role'] ,

       );
  }


  Map toMap(){
    return {
       'id': id,
       'first_name': first_name, 
       'last_name': last_name, 
       'last_login' : last_login, 
       'email' : email, 
       'is_active' : is_active,
       'date_joined': date_joined , 
       'is_staff': is_staff , 
       'is_superuser': is_superuser ,
       'password': password , 
       'username': username,
       'client_id': client_id,
       'cooperative_id': cooperative_id,
       'groupe': groupe,
       'role': role,
    };
  }


  static savePref(int value,User user) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = json.encode(user.toMap());

      preferences.setInt("value", value);
      preferences.setString("user", data);
      preferences.commit();
  
  }



   static signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

      sessionUser == null;
      preferences.setInt("value", 0);
      preferences.commit();

  }






  



  










}