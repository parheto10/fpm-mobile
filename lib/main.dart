// @dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/screens/producteurs.dart';

import 'package:flutter/material.dart';

// screens

import 'package:argon_flutter/screens/onboarding.dart';
import 'package:argon_flutter/screens/cooperatives.dart';
import 'package:argon_flutter/screens/parcelles.dart';
import 'package:argon_flutter/screens/register.dart';
import 'package:argon_flutter/screens/loginScreen.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  SystemChrome.setPreferredOrientations([ 
    // DeviceOrientation.landscapeRight,
    //  DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp, 
      DeviceOrientation.portraitDown, 
    ]);


  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance 
    ..displayDuration = const Duration(milliseconds: 200)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
    //..customAnimation = CustomAnimation();
} 


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Agromap Traceability',
        theme: ThemeData(fontFamily: 'OpenSans'),
        builder: EasyLoading.init(),
        initialRoute: "/onboarding",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          // "/home": (BuildContext context) => new Home(),
          "/cooperatives": (BuildContext context) => new Cooperatives(),
          "/producteurs": (BuildContext context) => new Producteurs(),
          "/parcelles": (BuildContext context) => new Parcelles(),
          // "/productions": (BuildContext context) => new Productions(),
          // "/plantings": (BuildContext context) => new Plantings(),
          // "/monitorings": (BuildContext context) => new Monitorings(),
          "/account": (BuildContext context) => new Register(),
          // "/carte": (BuildContext context) => new Carte(),
          "/login": (BuildContext context) => new LoginScreen(),
        });
  }
}


