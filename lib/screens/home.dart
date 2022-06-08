import 'dart:async';
import 'dart:convert';

import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/controller/syncronize.dart';
import 'package:argon_flutter/data_services/cooperatives.dart';
import 'package:argon_flutter/data_services/producteur.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/detail_coop.dart';
import 'package:argon_flutter/screens/loginScreen.dart';
import 'package:argon_flutter/screens/producteurs.dart';
import 'package:argon_flutter/screens/register.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/card-horizontal.dart';
import 'package:argon_flutter/widgets/card-small.dart';
import 'package:argon_flutter/widgets/card-square.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:argon_flutter/controller/querySql.dart';

class Home extends StatefulWidget {
  final VoidCallback signOut;
  Home(this.signOut);
  @override
  State<Home> createState() => _HomeState();
}
 var dbHelper = DatabaseHelper();

class _HomeState extends State<Home> {
  Timer _timer;
  int number;
  Cooperative coop;
  Producteur prod;
  int i = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  int t = 0;
  var cor =0;

  final GlobalKey _scaffoldKey = new GlobalKey();


 signOut() {
    if (this.mounted) {
      setState(() {
      widget.signOut();
   });
  }
 }

 Future syncToServerall() async {
    
    
    await ControllerSync().getProducteursync().then((value) async{
      i = value.length;
      EasyLoading.show(status: 'Synchronisation de (${i}) producteurs en cours...');
      await ControllerSync().saveProducteurToserver(value);   
    });
  
    await ControllerSync().getParcellesync().then((value) async{  
        b = value.length;
        EasyLoading.show(status: 'Synchronisation de (${b}) parcelles en cours...');
        await ControllerSync().saveParcToserver(value);
      
    });

    await ControllerSync().getPlantinggync().then((value) async{  
        c = value.length;
        EasyLoading.show(status: 'Synchronisation de (${c}) plantings en cours...');
        await ControllerSync().savePlantingToserver(value);
      
    });

    await ControllerSync().getDetailPlantingsync().then((value) async{  
        d = value.length;
        EasyLoading.show(status: 'Synchronisation de (${d}) plants en cours...');
        await ControllerSync().saveToDetailPlantingserver(value);      
    });

    t = i+b+c+d;

     setState(() {
         cor = t;
    });

    // print(value);
    // EasyLoading.showSuccess('Synchronisation effectué avec succes !');
      if (t > 0) {
        EasyLoading.showSuccess('Felicitation vous avez synchronisé ${cor} données !',duration: const Duration(seconds: 15),dismissOnTap: true);
      } else {
        EasyLoading.showInfo('Aucune données à synchroniser. Merci',duration: const Duration(seconds: 10),dismissOnTap: true,);
      }

   
      
 }

 Future countSynchro()async{
       await ControllerSync().getProducteursync().then((value) async{
      i = value.length;  
    });
  
    await ControllerSync().getParcellesync().then((value) async{  
        b = value.length;
      
    });

    await ControllerSync().getPlantinggync().then((value) async{  
        c = value.length;
      
    });

    await ControllerSync().getDetailPlantingsync().then((value) async{  
        d = value.length;     
    });

    t = i+b+c+d;
    setState(() {
        cor = t;
    });

    if(cor > 0){
      EasyLoading.showInfo('Vous avez ${cor} données à synchroniser',duration: const Duration(seconds: 10),dismissOnTap: true,);
    }else{
      EasyLoading.showInfo('Vous n\'avez pas de données à synchroniser',duration: const Duration(seconds: 10),dismissOnTap: true,);
    }
    
     
 }

 Future isInteret()async{
  //  EasyLoading.showInfo('Patientez nous vérifions votre accès à internet.',duration: const Duration(seconds: 3),);
    await ControllerSync.isInternet().then((connection){
      if (connection == 1) { 
              
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reseau disponible! synchroniser vos données "),duration: const Duration(seconds: 8),backgroundColor: Color.fromARGB(255, 50, 135, 37),));
      }else if(connection == 2){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous n'aviez pas de data internet"),backgroundColor: Colors.red,));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pas de réseau disponible"),backgroundColor: Colors.red,));
      }
    });
  }

 


  var value;
  getPref() async {

    var value;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getString("user");
      if(data != null){
          var decode = json.decode(data);
          var user = await User.fromJson(decode);
          User.sessionUser = user;
          this.coop = await dbHelper.firstCoop(User.sessionUser.cooperative_id);
     }else{
       User.sessionUser == null;
     }

    setState(() {
      value = preferences.getInt("value");
    });
  }


  @override
 void initState() {
   // TODO: implement initState
   super.initState();
   getPref();
   isInteret();
  //  countSynchro();
    
   
 }




  @override
  Widget build(BuildContext context) {
    
       if(User.sessionUser?.groupe == 1 || User.sessionUser?.groupe == 2){

             return Scaffold(
           appBar: Navbar(
          title: "Dashboard",
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Home",signOut: signOut,),
      
        body: Container(
                 decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/img/screen1.png"),
                    fit: BoxFit.fitWidth)),
          
                   child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: GridView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.holiday_village,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/cooperatives');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                            child: Text("Cooperatives",
                                style: TextStyle(
                                  fontSize: 12.0,
                                    fontWeight: FontWeight.w900,
                                    )),
                      ),

                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/producteurs');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                            child: Text("Producteurs",
                                style: TextStyle(
                                  fontSize: 12.0,
                                    fontWeight: FontWeight.w900,
                                    )),
                      ),

                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_pin,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/parcelles');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("Parcelles",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),

                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.greenAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/plantings');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("Plantings",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),

                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightBlue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.checklist,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/monitorings');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("Monitorings",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),

                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightGreen),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.category,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/productions');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("Productions",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),

                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightBlue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.place_sharp,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () {                          
                          Navigator.pushReplacementNamed(context, '/monitorings');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("Carte",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),

                    ],
                  ),
                ),
             

                // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueAccent.shade100),),
                // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.greenAccent.shade100),),
              ],
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //separe la page en deux Blocks
                mainAxisSpacing: 5, // espacement entre block horizontal
                crossAxisSpacing: 5, //espacement entre block Vertical
              ),
            ),
          ),
        ));

        }else if(User.sessionUser?.groupe == 3) {
          
            return Scaffold(

           appBar: Navbar(
          title: "${User.sessionUser.username}",
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Home",signOut: signOut,testSync: countSynchro,),
      
        body: Container(
                 decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/img/screen1.png"),
                    fit: BoxFit.fitWidth)),
          
                   child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 50.0),
            child: GridView(
              padding: EdgeInsets.all(10.0),
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.holiday_village,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () async {

                                 await Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>DetailCooperative(cooperative: coop,))
                                  );
                                },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                            child: Text("Infos",
                                style: TextStyle(
                                  fontSize: 10.0,
                                    fontWeight: FontWeight.w900,
                                    )),
                      ),

                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () async {

                                 await Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>Producteurs(coop: coop,))
                                  );
                                },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                            child: Text("Producteurs",
                                style: TextStyle(
                                  fontSize: 10.0,
                                    fontWeight: FontWeight.w900,
                                    )),
                      ),

                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_pin,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/parcelles');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("Parcelles",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),

                    ],
                  ),
                ),
            
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.greenAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sync_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                      FlatButton(
                        textColor: ArgonColors.text,
                        color: ArgonColors.secondary,
                        onPressed:()async{
                          EasyLoading.showInfo('Patientez nous vérifions votre accès à internet.',duration: const Duration(seconds: 3),);
                              await ControllerSync.isInternet().then((connection){
                                if (connection == 1) {
                                  syncToServerall();
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Internet Disponible"),backgroundColor: Color.fromARGB(255, 50, 135, 37),));
                                }else if(connection == 2){
                                  EasyLoading.showError('Vous n\'aviez pas de data internet',duration: const Duration(seconds: 5),);
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous n'aviez pas de data internet"),backgroundColor: Colors.red,));
                                }else{
                                  EasyLoading.showError('Pas de réseau disponible',duration: const Duration(seconds: 5),);
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pas de réseau disponible"),backgroundColor: Colors.red,));
                                } 
                              });
                            },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("synchroniser",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),

                    ],
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: Colors.lightBlue),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.checklist,
                //         size: 50,
                //         color: Colors.white,
                //       ),
                //       FlatButton(
                //         textColor: ArgonColors.text,
                //         color: ArgonColors.secondary,
                //         onPressed: _showMyDialog,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //         child: Text("Monitorings",
                //             style: TextStyle(
                //               fontSize: 12.0,
                //               fontWeight: FontWeight.w900,
                //             )),
                //       ),

                //     ],
                //   ),
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: Colors.lightGreen),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.category,
                //         size: 50,
                //         color: Colors.white,
                //       ),
                //       FlatButton(
                //         textColor: ArgonColors.text,
                //         color: ArgonColors.secondary,
                //         onPressed:_showMyDialog,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //         child: Text("Productions",
                //             style: TextStyle(
                //               fontSize: 12.0,
                //               fontWeight: FontWeight.w900,
                //             )),
                //       ),

                //     ],
                //   ),
                // ),

                
             

                // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueAccent.shade100),),
                // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.greenAccent.shade100),),
              ],
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //separe la page en deux Blocks
                mainAxisSpacing: 5, // espacement entre block horizontal
                crossAxisSpacing: 5, //espacement entre block Vertical
              ),
            ),
          ),
        ));


        }else {
          return Register();
        }


     

        
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AVERTISSEMENT ! '),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Veillez reessayer plus tard. Merci !'),
              // Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              // EasyLoading.show(status: 'loading...');
              Navigator.of(context).pop();
              // EasyLoading.removeAllCallbacks();
            },
          ),
        ],
      );
    },
  );
}
}
