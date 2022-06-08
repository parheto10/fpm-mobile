import 'dart:async';

import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/controller/querySql.dart';
import 'package:crypto/crypto.dart';

class LoginRequest {
  QuerySql con = new QuerySql();

  Future<User> getLogin(String username, String password){
    var res = con.getLogin(username, password);

    return res;
  }


}