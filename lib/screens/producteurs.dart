import 'dart:ui';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/controller/querySql.dart';
import 'package:argon_flutter/controller/syncronize.dart';
import 'package:argon_flutter/data_services/cooperatives.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/formulaire/addparcelle.dart';
import 'package:argon_flutter/screens/formulaire/addprod.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/loginScreen.dart';
import 'package:argon_flutter/screens/upform/editproform.dart';
import 'package:argon_flutter/widgets/drawer-tile.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';

// Producteurs Service
import 'package:argon_flutter/data_services/producteurs_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data_services/producteur.dart';
import 'detail_prod.dart';


class Producteurs extends StatefulWidget {
final String currentPage;
final Cooperative coop;

  const Producteurs({Key key, this.currentPage, this.coop}) : super(key: key);



  @override
  State<Producteurs> createState() => _ProducteursState();
}

 var dbHelper = DatabaseHelper();

class _ProducteursState extends State<Producteurs> {

  Producteur prod;
  Cooperative coop;
  int nbProd;

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

  void countPeople() async {
   int count = await dbHelper.getNumberOfProducteurCoop(User.sessionUser.cooperative_id);
   this.coop = await dbHelper.firstCoop(User.sessionUser.cooperative_id);
   setState(() {
     nbProd = count;
   });
 } 

  Future syncToServerall() async {
    EasyLoading.show(status: 'Veillez patientez synchronisation en cours...');

     await ControllerSync().getProductServer();
    EasyLoading.showSuccess('Synchronisation effectué avec succes !');
 }


     @override
 void initState() {
   super.initState();
   countPeople();
  //  print(QuerySql().getParcListForCoop(User.sessionUser.cooperative_id));   
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 60.0,
          title: Text("${nbProd} Producteur(s)",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
          actions: [
            IconButton(
              onPressed: (){
                showSearch(context: context, delegate: SearchProducteur());
              }, 
              icon: Icon(Icons.search)
            ),
            // IconButton(
            //   onPressed:syncToServerall, 
            //   icon: Icon(Icons.refresh_outlined)
            // ),
          ],
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
          future: QuerySql().getProdListForCoop(User.sessionUser.cooperative_id),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData) {
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
            
         
                                // Container(
                                //   width: 35.0,
                                //   height: 30.0,
                                //   color: Colors.white,
                                //   child: CircleAvatar(
                                //     backgroundColor: Colors.grey,
                                //     foregroundColor: Colors.white,
                                //     // backgroundImage: AssetImage("assets/img/profile-screen-avatar.jpg"),
                                //   ),
                                // ),
                                // SizedBox(width: 5.0,),
                                SizedBox(
                                    width: 170.0,
                                    child:    Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${snapshot.data[index].nom}", style: TextStyle(color: Colors.blue, fontSize: 12.0, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 2.0,),
                                      Text("Code : ${snapshot.data[index].code}", style: TextStyle(color: Colors.grey),),
                                      Text("Coopérative : ${coop?.sigle }", style: TextStyle(color: Colors.black),),
                                      Text("Parcelle(s) : ${snapshot.data[index].nb_parcelle}", style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                             
                              SizedBox(
                                width: 5.0,

                              ),
                          
                            Container(
                              child: FlatButton(
                                minWidth: 9.0,
                                onPressed: () {
                                  Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>AddParcellePage(prod: snapshot.data[index],))
                                  );
                                },
                                color: Colors.green[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.add,color: Colors.greenAccent,),
                                    // Text('', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                                  ],
                                ),
                                      
                                // child: Icon(Icons.chevron_right_sharp,),
                              ),
                            ),
                            Container(
                              child: FlatButton(
                                minWidth: 9.0,
                                onPressed: () {
                                  Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>EditProdFormPage(product:  snapshot.data[index],))
                                  );
                                },
                                color: Color.fromARGB(255, 209, 230, 238),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.edit,color: Colors.blue,),
                                    // Text('', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                                  ],
                                ),
                                      
                                // child: Icon(Icons.chevron_right_sharp,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
          onPressed:()  {
                          Navigator.push(
                          context, new MaterialPageRoute(
                          builder: (context)=>AddProducteurPage())
                          );
                      },
          
        ),
    );
  }
}


class SearchProducteur extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.close),
        onPressed: (){
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }

  // ignore: deprecated_member_use
  QuerySql _producteurList = QuerySql();

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: FutureBuilder(
        future: _producteurList.getProdListSearchForCoop(coopId : User.sessionUser.cooperative_id,query: query),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData) {
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
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               SizedBox(
                                    width: 170.0,
                                    child:    Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${snapshot.data[index].nom}", style: TextStyle(color: Colors.blue, fontSize: 12.0, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 2.0,),
                                      Text("Code : ${snapshot.data[index].code}", style: TextStyle(color: Colors.grey),),
                                      // Text("Coopérative : ${coop?.sigle }", style: TextStyle(color: Colors.black),),
                                      Text("Parcelle(s) : ${snapshot.data[index].nb_parcelle}", style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                                    SizedBox(
                                width: 30.0,

                              ),
                          
                            Container(
                              child: FlatButton(
                                minWidth: 9.0,
                                onPressed: () {
                                  Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>AddParcellePage(prod: snapshot.data[index],))
                                  );
                                },
                                color: Colors.green[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.add,color: Colors.greenAccent,),
                                    // Text('', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                                  ],
                                ),
                                      
                                // child: Icon(Icons.chevron_right_sharp,),
                              ),
                            ),
                               SizedBox(
                                width: 9.0,

                              ),
                            Container(
                              child: FlatButton(
                                minWidth: 9.0,
                                onPressed: () {
                                  Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>EditProdFormPage(product:  snapshot.data[index],))
                                  );
                                },
                                color: Color.fromARGB(255, 209, 230, 238),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.edit,color: Colors.blue,),
                                    // Text('', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                                  ],
                                ),
                                      
                                // child: Icon(Icons.chevron_right_sharp,),
                              ),
                            ),
                            ],
                          ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                          //   child: FlatButton(
                          //     onPressed: () {
                          //         Navigator.push(
                          //             context, new MaterialPageRoute(
                          //             builder: (context)=>AddParcellePage(prod: snapshot.data[index],))
                          //         );
                          //       },
                          //     color: Colors.green[200],
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(20.0),
                          //     ),
                          //     child: Text('add parcelle', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                          //     // child: Icon(Icons.chevron_right_sharp,),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Chercher un Producteur ..."),
    );
  }
}


