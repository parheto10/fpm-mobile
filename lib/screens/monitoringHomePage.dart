import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/controller/querySql.dart';
import 'package:argon_flutter/models/monitoring.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/detail_monitoring.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/remplaceHomePage.dart';
import 'package:argon_flutter/widgets/drawer-tile.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MonitoringHomePage extends StatefulWidget {
  Planting planting;
  Parcelle parc;
  MonitoringHomePage({ 
    Key key,
    this.planting,
    this.parc
  }) : super(key: key);

  get currentPage => null;

  @override
  State<MonitoringHomePage> createState() => _MonitoringHomePageState();
}


 var dbHelper = DatabaseHelper();
 
class _MonitoringHomePageState extends State<MonitoringHomePage> {
  Monitoring moni;

    signOut() async {
      setState(() {
        User.signOut();
        Navigator.of(context).pushNamedAndRemoveUntil('/account', (route) => false);

   });
 }
 double getNumber(double input, {int precision = 2}){
   return double.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));
}

  getLastMonitoring()async{
    this.moni = await dbHelper.getLastMonitoringForPlanting(widget.planting.code);
  }

  @override
  void initState() {

    getLastMonitoring();
    super.initState(); 
 }

@override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          // title: "Monitoring ${widget.parc.code}",
          title: "Monitoring ",
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
          future: QuerySql().getMonitoringForPlantings(widget.planting.code),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData) {
              print(snapshot.data.length);
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){                 
            
                    width: MediaQuery.of(context).size.width;
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 10.0);
                    return Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               
                                SizedBox(width: 8.0,),
                               Row(                                  
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 165.0,
                                      child: Column(
                                      children: [
                                        Text("Date : ${DateFormat.yMMMd().format(snapshot.data[index].date)}", style: TextStyle(color: Colors.blue, fontSize: 11.0, fontWeight: FontWeight.bold),),
                                        SizedBox(height: 3.0,),
                                        Text("PLANTS VIVANTS : ${snapshot.data[index].mature_global}", style: TextStyle(color: Colors.grey, fontSize: 10.0,fontWeight: FontWeight.bold),),
                                        // Text("TAUX REUSSITE : ${snapshot.data[index].taux_vitalite} %", style: TextStyle(color: Colors.grey, fontSize: 12.0,fontWeight: FontWeight.bold),),
                                         SizedBox(height: 18.0,),
                                          Container(
                                              height: 38.0,
                                              decoration: BoxDecoration(
                                                color: ArgonColors.info,
                                                borderRadius:
                                                BorderRadius.circular(1.0),
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
                                              child: FlatButton(
                                                onPressed: () {
                                                          Navigator.push(
                                                              context, new MaterialPageRoute(
                                                              builder: (context)=>MonitoringEspecePage(planting: widget.planting,monitoring: snapshot.data[index],parc: widget.parc,))
                                                          );
                                                        },
                                              child: Text(
                                                "SUIVRE",
                                                style: TextStyle(
                                                    color: ArgonColors.white,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                    FontWeight.bold),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            ),
                                      ],
                                    ) ,
                                    ),
                                    SizedBox(
                                      width: 135.0,
                                      child: Column(
                                      children: [
                                        Text("Reçus : ${widget.planting.plant_recus}", style: TextStyle(color: Colors.blue, fontSize: 11.0, fontWeight: FontWeight.bold),),
                                        SizedBox(height: 3.0,),
                                        Text("PLANTS MORT : ${snapshot.data[index].mort_global}", style: TextStyle(color: Colors.grey, fontSize: 10.0,fontWeight: FontWeight.bold),),
                                        // Text("TAUX MORTALITE : ${snapshot.data[index].taux_mortalite}%", style: TextStyle(color: Colors.grey, fontSize: 12.0,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 18.0,),
                                          // snapshot.data[index].mort_global > 0 ?
                                                // Container(
                                                //     height: 38.0,
                                                //     decoration: BoxDecoration(                                                
                                                //       color: Color.fromARGB(255, 245, 55, 26),
                                                //       borderRadius:
                                                //       BorderRadius.circular(1.0),
                                                //       boxShadow: [
                                                //         BoxShadow(
                                                //           color: Colors.grey
                                                //               .withOpacity(0.3),
                                                //           spreadRadius: 1,
                                                //           blurRadius: 7,
                                                //           offset: Offset(0,
                                                //               3), // changes position of shadow
                                                //         ),
                                                //       ],
                                                //     ),
                                                //     child: FlatButton(
                                                //       onPressed: () {
                                                //           Navigator.push(
                                                //               context, new MaterialPageRoute(
                                                //               builder: (context)=>RemplacementHomePage(planting: widget.planting,parc: widget.parc,monitoring: snapshot.data[index],lastmonitoring: moni,))
                                                //           );
                                                //         },
                                                //     child: Text(
                                                //       "REMPLACER",
                                                //       style: TextStyle(
                                                //           color: ArgonColors.white,
                                                //           fontSize: 15.0,
                                                //           fontWeight:
                                                //           FontWeight.bold),
                                                //       ),
                                                //     ),
                                                //     padding: EdgeInsets.symmetric(
                                                //         horizontal: 8.0,
                                                //         vertical: 8.0),
                                                //   ):
                                                  // Container()
                                      ],
                                    ) ,
                                    ),
                                  ],
                                ),
                              
                              
                              ],
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
          onPressed:_showMyDialog,
          
        ),
    );
    
  }

  Future<void> _showMyDialog() async {
    if( moni.mort_global ==null || moni.mort_global == 0){
        return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Monitoring'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              // Text('This is a demo alert dialog.'),
               Text('Voulez-vous effectuer un monitoring ',style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OUI'),
            onPressed: () async {
              final monitoring = Monitoring(
                code: "${DateTime.now().millisecondsSinceEpoch}MNT",
                date: DateTime.now(),
                planting_id: widget.planting.code,
                mature_global: 0,
                mort_global: 0,
                taux_vitalite: '0',
                taux_mortalite: '0'
              );
              await dbHelper.createMonitoring(monitoring);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MonitoringHomePage(planting: widget.planting,parc: widget.parc,)));
              
            },
          ),
          TextButton(
            child: const Text('NON',style: TextStyle(color: Colors.red),),
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



}