import 'dart:ui';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/controller/querySql.dart';
import 'package:argon_flutter/controller/syncronize.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/detail_parcelle.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/upform/updateparceform.dart';
import 'package:argon_flutter/widgets/drawer-tile.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';

// //widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:argon_flutter/widgets/drawer.dart';
// import 'package:argon_flutter/data_services/parcelles_services.dart';

// import 'detail_parcelle.dart';

class Parcelles extends StatefulWidget {
final String currentPage;

  const Parcelles({Key key, this.currentPage}) : super(key: key);
  @override
  State<Parcelles> createState() => _ParcellesState();

  static fromJson(e) {}
}

 var dbHelper = DatabaseHelper();

class _ParcellesState extends State<Parcelles> {

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
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 60.0,
          title: Text("Parcelles",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
          actions: [
            IconButton(
              onPressed: (){
                showSearch(context: context, delegate: SearchParcelle());
              }, 
              icon: Icon(Icons.search)
            )
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
          future: QuerySql().getParcListForCoop(User.sessionUser.cooperative_id),
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
                                SizedBox(
                                  width: 185.0,
                                  child : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data[index].code, style: TextStyle(color: Colors.blue, fontSize: 13.0, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 2.0,),
                                    Text("Prod : ${snapshot.data[index].nom}", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                                    Text("Superficie : ${snapshot.data[index].superficie} Ha", style: TextStyle(color: Colors.black),),
                                  ],
                                )
                                  ),

                                   SizedBox(
                                width: 15.0,

                              ),
                          
                            Container(
                              child: FlatButton(
                                minWidth: 7.0,
                                onPressed: () {
                                  Navigator.push(
                                      context, new MaterialPageRoute(
                                       builder: (context)=>DetailParcelle(parcelle: snapshot.data[index],)
                                      )
                                  );
                                },
                                color: Colors.green[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_right_outlined,color: Colors.orange,),
                                    // Text('', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                                  ],
                                ),
                                      
                                // child: Icon(Icons.chevron_right_sharp,),
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
                                       builder: (context)=>UpdateParcelleForm(parcelle: snapshot.data[index],)
                                      )
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
                            //       Navigator.push(
                            //           context, new MaterialPageRoute(
                            //           builder: (context)=>DetailParcelle(parcelle: snapshot.data[index],))
                            //       );
                            //     },
                            //     color: Colors.green[200],
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(20.0),
                            //     ),
                            //     child: Text('Détails', style: TextStyle(color: Colors.white, fontSize: 14.0),),
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
      ),
    );
  }
}


class SearchParcelle extends SearchDelegate{
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
    return IconButton(icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }

  QuerySql _parcelleList = QuerySql();

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: FutureBuilder(
        future: _parcelleList.getParcListSearchForCoop(coopId:User.sessionUser.cooperative_id,query: query),
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
                              // Container(
                              //   width: 50.0,
                              //   height: 45.0,
                              //   color: Colors.white,
                              //   child: CircleAvatar(
                              //     backgroundColor: Colors.white,
                              //     foregroundColor: Colors.white,
                              //     backgroundImage: AssetImage("assets/img/parcelle.png"),
                              //   ),
                              // ),
                              SizedBox(width: 5.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data[index].code, style: TextStyle(color: Colors.blue, fontSize: 13.0, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 2.0,),
                                    Text("Prod : ${snapshot.data[index].nom}", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                                    Text("Superficie : ${snapshot.data[index].superficie} Ha", style: TextStyle(color: Colors.black),),
                                  ],
                                )
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>DetailParcelle(parcelle: snapshot.data[index],))
                                  );
                                },
                              color: Colors.green[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text('Détails', style: TextStyle(color: Colors.white, fontSize: 14.0),),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Chercher une Parcelle ..."),
    );
  }
}
