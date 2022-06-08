import 'dart:ui';
import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/data_services/productions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class DetailProduction extends StatelessWidget {
  final Productions production;

  DetailProduction(this.production);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "${production.parcelle}",
          // title: "Profile",
          transparent: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Profile"),
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
                                  top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.center,
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
                                                "Modifier",
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
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                          child: Text("${production.parcelle}",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 24.0)),
                                        ),
                                        SizedBox(height: 5.0),
                                        Align(
                                          child: Text("Campgne : ${production.campagne}",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w900)),
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
                                          child: Text("Qté : ${production.qteProduct} KG",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600)),
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
                                                "Détail Supplémentaire sur la Production en 1 ou 2 lignes",
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
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("https://4.bp.blogspot.com/-v4g_XDuuri8/W9N8AHRheQI/AAAAAAAACEI/gG6n6VmZw6AX67jHHQ1nxT_-Unswd_SfQCLcBGAs/s1600/culture-du-cacao.jpg"),
                              // backgroundImage: NetworkImage("https://icon-library.com/images/profile-png-icon/profile-png-icon-2.jpg"),
                              radius: 65.0,
                              // maxRadius: 200.0,
                            ),
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
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

