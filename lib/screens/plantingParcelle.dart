import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/controller/querySql.dart';
import 'package:argon_flutter/controller/syncronize.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/detail_espece.dart';
import 'package:argon_flutter/screens/formulaire/adddetailplanting.dart';
import 'package:argon_flutter/screens/formulaire/addplanting.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/monitoringHomePage.dart';
import 'package:argon_flutter/widgets/drawer-tile.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class PlantingParcelle extends StatefulWidget {
 Parcelle parc;

   PlantingParcelle({ Key key, this.parc }) : super(key: key);

  get currentPage => null;

  @override
  State<PlantingParcelle> createState() => _PlantingParcelleState();
}
 var dbHelper = DatabaseHelper();
class _PlantingParcelleState extends State<PlantingParcelle> {

  int i = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  int t = 0;
  var cor =0;

 
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
      EasyLoading.showInfo('Vous avez ${cor} éléments à synchroniser',duration: const Duration(seconds: 10),dismissOnTap: true,);
    }else{
      EasyLoading.showInfo('Vous n\'avez pas de données à synchroniser',duration: const Duration(seconds: 10),dismissOnTap: true,);
    }
    
     
 }
  signOut() async {
      setState(() {
        User.signOut();
        Navigator.of(context).pushNamedAndRemoveUntil('/account', (route) => false);

   });
 }



  @override
    void initState() {
   super.initState(); 

  //  print(widget.parc.code);

 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Planting ${widget.parc.code}",
          transparent: false,
          searchBar: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
               drawer: Drawer(
        child: Container(
      color: ArgonColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Image.asset("assets/img/logo.png"),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (widget.currentPage != "Home")
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(signOut)));
                  },
                  iconColor: ArgonColors.primary,
                  title: "Home",
                  isSelected: widget.currentPage == "Home" ? true : false),
              // DrawerTile(
              //     icon: Icons.holiday_village,
              //     onTap: () {
              //       if (widget.currentPage != "Cooperatives")
              //        Navigator.pushReplacementNamed(context, '/cooperatives');
              //     },
              //     iconColor: ArgonColors.success,
              //     title: "Cooperatives",
              //     isSelected: widget.currentPage == "Cooperatives" ? true : false),
              DrawerTile(
                  icon: Icons.person_pin,
                  onTap: () {
                    if (widget.currentPage != "Producteurs")
                      Navigator.pushReplacementNamed(context, '/producteurs');
                  },
                  iconColor: ArgonColors.info,
                  title: "Producteurs",
                  isSelected: widget.currentPage == "Producteurs" ? true : false),
              DrawerTile(
                  icon: Icons.map,
                  onTap: () {
                    if (widget.currentPage != "Parcelles")
                      Navigator.pushReplacementNamed(context, '/parcelles');
                  },
                  iconColor: ArgonColors.info,
                  title: "Parcelles",
                  isSelected: widget.currentPage == "Parcelles" ? true : false),
            DrawerTile(
                  icon: Icons.sync_alt,
                  onTap:countSynchro,
                  iconColor: ArgonColors.info,
                  title: "Lab sync",
                  isSelected: widget.currentPage == "Lab sync" ? true : false),
              // DrawerTile(
              //     icon: Icons.category,
              //     onTap: () {
              //       if (widget.currentPage != "Productions")
              //         Navigator.pushReplacementNamed(context, '/productions');
              //     },
              //     iconColor: ArgonColors.primary,
              //     title: "Productions",
              //     isSelected: widget.currentPage == "Productions" ? true : false),
              //              DrawerTile(
              //     icon: Icons.list_sharp,
              //     onTap: () {
              //       if (widget.currentPage != "Plantings")
              //         Navigator.pushReplacementNamed(context, '/plantings');
              //     },
              //     iconColor: ArgonColors.error,
              //     title: "Plantings",
              //     isSelected: widget.currentPage == "Plantings" ? true : false),
              // DrawerTile(
              //     icon: Icons.apps,
              //     onTap: () {
              //       if (widget.currentPage != "Monitorings")
              //         Navigator.pushReplacementNamed(context, '/monitorings');
              //     },
              //     iconColor: ArgonColors.primary,
              //     title: "Monitorings",
              //     isSelected: widget.currentPage == "Monitorings" ? true : false),

              // DrawerTile(
              //     icon: Icons.place_sharp,
              //     onTap: () {
              //       if (widget.currentPage != "Carte")
              //         Navigator.pushReplacementNamed(context, '/carte');
              //     },
              //     iconColor: ArgonColors.primary,
              //     title: "Carte Parcelles",
              //     isSelected: widget.currentPage == "Carte" ? true : false),
           
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("PARAMETRES",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.vpn_lock_sharp,
                      onTap: signOut,
                      iconColor: ArgonColors.muted,
                      title: "Deconnexion",
                      isSelected:
                          widget.currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    )),
        body: Container(
        color: Colors.blue[200],
        child: FutureBuilder(
          future: QuerySql().getPlantingForParcelle(widget.parc.code),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData) {
              print(snapshot.data.length);
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){                 
            
                    width: MediaQuery.of(context).size.width;
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0);
                    return Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Container(
                                //   width: 35.0,
                                //   height: 30.0,
                                //   color: Colors.white,
                                //   child: CircleAvatar(
                                //     backgroundColor: Colors.grey,
                                //     foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                                //     // backgroundImage: NetworkImage("https://4.bp.blogspot.com/-v4g_XDuuri8/W9N8AHRheQI/AAAAAAAACEI/gG6n6VmZw6AX67jHHQ1nxT_-Unswd_SfQCLcBGAs/s1600/culture-du-cacao.jpg"),
                                //   ),
                                // ),
                                SizedBox(width: 0.0,),
                                SizedBox(
                                  width: 182.0,
                                  child: Column(                                  
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DateFormat.yMMMd().format(snapshot.data[index].date), style: TextStyle(color: Colors.blue, fontSize: 13.0, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 2.0,),
                                    Text("Prod: ${widget.parc.nom}", style: TextStyle(color: Colors.black87, fontSize: 12.0, fontWeight: FontWeight.w600),),
                                    Text("Plants Plantés : ${snapshot.data[index].plant_recus} ", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),),
                                    // Text("Nbre espece(s) : ${countEspece(snapshot.data[index].id)} ", style: TextStyle(color: Colors.black),),
                                   
                                  ],
                                ),
                                ),
                                // SizedBox(width: 5.0,),
                                SizedBox(
                                  width: 150.0,
                                  child:  Row(
                                      children: [
                                  Container(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.remove_red_eye,
                                                  ),
                                                  iconSize: 30,
                                                  color: Color.fromARGB(255, 116, 189, 245),
                                                  splashColor: Colors.purple,
                                                  onPressed: () {
                                                      Navigator.push(
                                                      context, new MaterialPageRoute(
                                                      builder: (context)=>EspecePlantingPage(plant: snapshot.data[index],parc: widget.parc,))
                                                  );
                                                  },
                                                ),
                                              ),
                                            
                                          // count >= 0 ?
                                                    Container(
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.add_circle,
                                                          ),
                                                          iconSize: 30,
                                                          color: Colors.green,
                                                          splashColor: Colors.purple,
                                                          onPressed: () {
                                                          Navigator.push(
                                                              context, new MaterialPageRoute(
                                                              builder: (context)=>DetailPlantingFormPage(planting: snapshot.data[index],))
                                                          );
                                                        },
                                                        ),
                                                      ),
                                                  // : Container(),
                                            // Container(
                                            //     child: IconButton(
                                            //       icon: Icon(
                                            //         Icons.table_rows_rounded,
                                            //       ),
                                            //       iconSize: 30,
                                            //       color: Color.fromARGB(255, 241, 227, 66),
                                            //       splashColor: Colors.purple,
                                            //        onPressed:() {
                                            //               Navigator.push(
                                            //                   context, new MaterialPageRoute(
                                            //                   builder: (context)=>MonitoringHomePage(planting: snapshot.data[index],parc: widget.parc,))
                                            //               );
                                            //             },
                                            //     ),
                                            //   ),
                                      ],
                                    ),
                                  ),
                     
                              ],
                            ),
                          //   Container(
                          //     alignment: Alignment.center,
                          //     padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                          //     child: FlatButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //             context, new MaterialPageRoute(
                          //             builder: (context)=>null)
                          //         );
                          //       },
                          //       color: Colors.green[200],
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(20.0),
                          //       ),
                          //       child: Text('Détails', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                          //       // child: Icon(Icons.chevron_right_sharp,),
                          //     ),
                          //   ),
                          ],
                        ),
                      ),
                    );
                    // return ListTile(
                    //   leading: CircleAvatar(
                    //     backgroundColor: Colors.grey,
                    //     foregroundColor: Colors.white,
                    //     backgroundImage: NetworkImage("https://icon-library.com/images/profile-png-icon/profile-png-icon-2.jpg"),
                    //   ),
                    //   title: Text(snapshot.data[index].nom, style: TextStyle(fontWeight: FontWeight.bold),),
                    //   subtitle: Text(snapshot.data[index].code),
                    //   onTap: () {
                    //     Navigator.push(
                    //         context, new MaterialPageRoute(
                    //         builder: (context)=>DetailProducteur(snapshot.data[index]))
                    //     );
                    //   },
                    // );
                  }
              );
            } else if (snapshot.hasError){
              return Container(
                child: Center(child: Text('Aucune Donner Trouver, Vérifier votre Connexion Internet'),),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

          },
        ),
      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
                Navigator.push(
                context, new MaterialPageRoute(
                builder: (context)=>AddPlantingPage(parcelle: widget.parc,))
              );
     },
          
        ),
    );
    
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


}