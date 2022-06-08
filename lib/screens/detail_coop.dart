import 'dart:ui';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/controller/querySql.dart';
import 'package:argon_flutter/controller/syncronize.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/widgets/drawer-tile.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/data_services/cooperatives.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



class DetailCooperative extends StatefulWidget {
 Cooperative cooperative;
  final String currentPage;

  DetailCooperative({
    this.cooperative, this.currentPage
    });

  @override
  State<DetailCooperative> createState() => _DetailCooperativeState();
}

 var dbHelper = DatabaseHelper();

class _DetailCooperativeState extends State<DetailCooperative> {

 Cooperative cooperative;
 int nbProd;
 int nbParcelle;
 int supParcelle;

 String sigle;
 String contact;
 String region;
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
 


 void countPeople() async {
   int count = await dbHelper.getNumberOfProducteurCoop(User.sessionUser.cooperative_id);

   setState(() {
     nbProd = count;
   });
 } 

  void countParcelleCoop() async {
   int count = await dbHelper.getNumberOfParcelleCoop(User.sessionUser.cooperative_id);

    setState(() {
      nbParcelle = count;
   });
 
 }


  signOut() async {

      setState(() {
        User.signOut();
        Navigator.of(context).pushNamedAndRemoveUntil('/account', (route) => false);
   });

 }





  

    @override
 void initState() {
   // TODO: implement initState
   super.initState();
   countPeople();
    countParcelleCoop();
   sigle = widget.cooperative?.sigle ?? '';
   contact = widget.cooperative?.contacts ?? '';
   region = widget.cooperative?.region ?? '';
   
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: sigle,
          // title: "Profile",
          transparent: true,
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
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/img/screen1.png"),
                      fit: BoxFit.fitWidth))),
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, top: 70.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                              Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: .0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ArgonColors.info,
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "BIENVENUE",
                                                style: TextStyle(
                                                    color: ArgonColors.white,
                                                    fontSize: 24.0,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text("${nbProd}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text("Producteur(s)"
                                                    ,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                            // Column(
                                            //   children: [
                                            //     Text("${nbParcelle}",
                                            //         style: TextStyle(
                                            //             color: Color.fromRGBO(
                                            //                 82, 95, 127, 1),
                                            //             fontSize: 20.0,
                                            //             fontWeight:
                                            //             FontWeight.bold)),
                                            //     Text("Parcelle(s)",
                                            //         style: TextStyle(
                                            //             color: Color.fromRGBO(
                                            //                 50, 50, 93, 1),
                                            //             fontSize: 12.0))
                                            //   ],
                                            // ),
                                            Column(
                                              children: [
                                                Text("${nbParcelle}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text("Parcelle(s)",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            )
                                          ],
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                          child: Text(sigle,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 28.0)),
                                        ),
                                        SizedBox(height: 5.0),
                                        Align(
                                          child: Text("Contacts : ${contact}",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w900)),
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
                                          child: Text("Région : ${region}",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.0, right: 32.0),
                                          child: Align(
                                            child: Text(
                                                "Détail Supplémentaire sur la Coopérative en 1 ou 2 lignes",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        82, 95, 127, 1),
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                    FontWeight.w200)),
                                          ),
                                        ),

                                        // SizedBox(height: 15.0),
                                        // Align(
                                        //     child: Text("Show more",
                                        //         style: TextStyle(
                                        //             color: ArgonColors.primary,
                                        //             fontWeight: FontWeight.w400,
                                        //             fontSize: 16.0))),
                                        // SizedBox(height: 25.0),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       right: 25.0, left: 25.0),
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //       Text(
                                        //         "Album",
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 16.0,
                                        //             color: ArgonColors.text),
                                        //       ),
                                        //       Text(
                                        //         "View All",
                                        //         style: TextStyle(
                                        //             color: ArgonColors.primary,
                                        //             fontSize: 13.0,
                                        //             fontWeight:
                                        //             FontWeight.w600),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   height: 250,
                                        //   child: GridView.count(
                                        //       primary: false,
                                        //       padding: EdgeInsets.symmetric(
                                        //           horizontal: 24.0,
                                        //           vertical: 15.0),
                                        //       crossAxisSpacing: 10,
                                        //       mainAxisSpacing: 10,
                                        //       crossAxisCount: 3,
                                        //       children: <Widget>[
                                        //         Container(
                                        //             height: 100,
                                        //             decoration: BoxDecoration(
                                        //               borderRadius:
                                        //               BorderRadius.all(
                                        //                   Radius.circular(
                                        //                       6.0)),
                                        //               image: DecorationImage(
                                        //                   image: NetworkImage(
                                        //                       "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                        //                   fit: BoxFit.cover),
                                        //             )),
                                        //         Container(
                                        //             decoration: BoxDecoration(
                                        //               borderRadius:
                                        //               BorderRadius.all(
                                        //                   Radius.circular(6.0)),
                                        //               image: DecorationImage(
                                        //                   image: NetworkImage(
                                        //                       "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                        //                   fit: BoxFit.cover),
                                        //             )),
                                        //         Container(
                                        //             decoration: BoxDecoration(
                                        //               borderRadius:
                                        //               BorderRadius.all(
                                        //                   Radius.circular(6.0)),
                                        //               image: DecorationImage(
                                        //                   image: NetworkImage(
                                        //                       "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80"),
                                        //                   fit: BoxFit.cover),
                                        //             )),
                                        //         Container(
                                        //             decoration: BoxDecoration(
                                        //               borderRadius:
                                        //               BorderRadius.all(
                                        //                   Radius.circular(6.0)),
                                        //               image: DecorationImage(
                                        //                   image: NetworkImage(
                                        //                       "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80"),
                                        //                   fit: BoxFit.cover),
                                        //             )),
                                        //         Container(
                                        //             decoration: BoxDecoration(
                                        //               borderRadius:
                                        //               BorderRadius.all(
                                        //                   Radius.circular(6.0)),
                                        //               image: DecorationImage(
                                        //                   image: NetworkImage(
                                        //                       "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80"),
                                        //                   fit: BoxFit.cover),
                                        //             )),
                                        //         Container(
                                        //             decoration: BoxDecoration(
                                        //               borderRadius:
                                        //               BorderRadius.all(
                                        //                   Radius.circular(6.0)),
                                        //               image: DecorationImage(
                                        //                   image: NetworkImage(
                                        //                       "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80"),
                                        //                   fit: BoxFit.cover),
                                        //             )),
                                        //       ]),
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      // FractionalTranslation(
                      //     translation: Offset(0.0, -0.5),
                      //     child: Align(
                      //       child: CircleAvatar(
                      //         backgroundImage: AssetImage("assets/img/user-icon-2.png"),
                      //         // backgroundImage: NetworkImage("https://icon-library.com/images/profile-png-icon/profile-png-icon-2.jpg"),
                      //         radius: 65.0,
                      //         // maxRadius: 200.0,
                      //       ),
                      //       alignment: FractionalOffset(0.5, 0.0),
                      //     ))
                    ]),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }
}



// class DetailProducteur extends StatelessWidget {
//   final Producteur producteur;
//   // const DetailProducteur({Key? key, required this.producteur}) : super(key: key);
//
//   DetailProducteur(this.producteur);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${producteur.nom} - ${producteur.code}"),
//       ),
//     );
//   }
// }

