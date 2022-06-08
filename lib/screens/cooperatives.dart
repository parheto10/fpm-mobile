import 'dart:ui';
import 'package:argon_flutter/controller/querySql.dart';
// import 'package:argon_flutter/data_services/cooperatives_service.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/detail_coop.dart';
import 'package:argon_flutter/screens/loginScreen.dart';
import 'package:argon_flutter/widgets/drawer-tile.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/screens/home.dart';

//Producteurs Service
import 'package:argon_flutter/data_services/cooperatives.dart';

import 'detail_prod.dart';


class Cooperatives extends StatefulWidget {
  final String currentPage;

  const Cooperatives({Key key, this.currentPage}) : super(key: key);

  @override
  State<Cooperatives> createState() => _CooperativesState();
}

class _CooperativesState extends State<Cooperatives> {
    signOut() async {

      setState(() {
        // print(User.sessionUser.id);
        User.signOut();
        Navigator.pushReplacementNamed(context, '/account');
   });

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Cooperatives",
          transparent: false,
          searchBar: true,
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
              DrawerTile(
                  icon: Icons.holiday_village,
                  onTap: () {
                    if (widget.currentPage != "Cooperatives")
                     Navigator.pushReplacementNamed(context, '/cooperatives');
                  },
                  iconColor: ArgonColors.success,
                  title: "Cooperatives",
                  isSelected: widget.currentPage == "Cooperatives" ? true : false),
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
                  icon: Icons.category,
                  onTap: () {
                    if (widget.currentPage != "Productions")
                      Navigator.pushReplacementNamed(context, '/productions');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Productions",
                  isSelected: widget.currentPage == "Productions" ? true : false),
                           DrawerTile(
                  icon: Icons.list_sharp,
                  onTap: () {
                    if (widget.currentPage != "Plantings")
                      Navigator.pushReplacementNamed(context, '/plantings');
                  },
                  iconColor: ArgonColors.error,
                  title: "Plantings",
                  isSelected: widget.currentPage == "Plantings" ? true : false),
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    if (widget.currentPage != "Monitorings")
                      Navigator.pushReplacementNamed(context, '/monitorings');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Monitorings",
                  isSelected: widget.currentPage == "Monitorings" ? true : false),

              DrawerTile(
                  icon: Icons.place_sharp,
                  onTap: () {
                    if (widget.currentPage != "Carte")
                      Navigator.pushReplacementNamed(context, '/carte');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Carte Parcelles",
                  isSelected: widget.currentPage == "Carte" ? true : false),
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
                      icon: Icons.airplanemode_active,
                      onTap: signOut,
                      iconColor: ArgonColors.muted,
                      title: "Deconnection",
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
          future: QuerySql().Listcoop(),
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 35.0,
                                  height: 30.0,
                                  color: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                    // backgroundImage: NetworkImage("https://icon-library.com/images/profile-png-icon/profile-png-icon-2.jpg"),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data[index].sigle}", style: TextStyle(color: Colors.blue, fontSize: 12.0, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 2.0,),
                                    Text("${snapshot.data[index].contacts}", style: TextStyle(color: Colors.grey),),
                                    Text("${snapshot.data[index].region?.libelle ?? "pas renseigner" }", style: TextStyle(color: Colors.black),),
                                    // Text("${snapshot.data[index].projet.titre}", style: TextStyle(color: Colors.black),),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                              child: FlatButton(
                                onPressed: () async {

                                 await Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>DetailCooperative(cooperative: snapshot.data[index],))
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
      ),
    );
  }
}
