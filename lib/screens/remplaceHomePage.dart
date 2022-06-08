import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/models/monitoring.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:flutter/material.dart';


class RemplacementHomePage extends StatefulWidget {
 final Monitoring monitoring;
 final Planting planting;
 final Parcelle parc;
 final Monitoring lastmonitoring;

   RemplacementHomePage({ 
     Key key, 
     this.monitoring, 
     this.planting, 
     this.parc, 
     this.lastmonitoring 
    }) : super(key: key);

  @override
  State<RemplacementHomePage> createState() => _RemplacementHomePageState();
}

 var dbHelper = DatabaseHelper();
class _RemplacementHomePageState extends State<RemplacementHomePage> {


    @override
  void initState() {
    super.initState(); 
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REMPLACEMENT"),
        backgroundColor: Color(0xcc5ac1Be),
      ),
    );
  }
}