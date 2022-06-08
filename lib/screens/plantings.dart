import 'dart:ui';
import 'package:argon_flutter/data_services/plantings_services.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';

// Producteurs Service
import 'package:argon_flutter/data_services/producteurs_service.dart';

import 'detail_planting.dart';
import 'detail_prod.dart';


class Plantings extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Plantings",
        transparent: false,
        searchBar: true,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Plantings"),
      body: Container(
        color: Colors.blue[200],
        child: FutureBuilder(
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
                                    backgroundImage: NetworkImage("https://4.bp.blogspot.com/-v4g_XDuuri8/W9N8AHRheQI/AAAAAAAACEI/gG6n6VmZw6AX67jHHQ1nxT_-Unswd_SfQCLcBGAs/s1600/culture-du-cacao.jpg"),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data[index].parcelle}", style: TextStyle(color: Colors.blue, fontSize: 12.0, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 2.0,),
                                    Text("Date Planting : ${snapshot.data[index].date}", style: TextStyle(color: Colors.grey),),
                                    Text("Total plants reçus : ${snapshot.data[index].plantTotal}", style: TextStyle(color: Colors.black),),
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
                                      builder: (context)=>DetailPlanting(snapshot.data[index]))
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
    );
  }
}
