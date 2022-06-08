import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/plantingParcelle.dart';
import 'package:argon_flutter/screens/upform/editplantespece.dart';
import 'package:flutter/material.dart';

class EspecePlantingPage extends StatefulWidget {
  Planting plant;
  Parcelle parc;
   EspecePlantingPage({ 
     Key key,
     this.plant,
     this.parc
   }) : super(key: key);

  @override
  State<EspecePlantingPage> createState() => _EspecePlantingPageState();
}
var dbHelper = DatabaseHelper();
class _EspecePlantingPageState extends State<EspecePlantingPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
     extendBodyBehindAppBar: true,
     appBar: AppBar(
      title: Text("Espèces Plantées"),
       backgroundColor: Color(0xcc5ac1Be),
    ),


        body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: dbHelper.getPlantingEspece(widget.plant.code),
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
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                  SizedBox(
                                    width: 195.0,
                                    child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 2.0,),
                                      Text("${snapshot.data[index].libelle}", style: TextStyle(color: Colors.black,fontSize: 16.0, fontWeight: FontWeight.w800),),
                                      SizedBox(width: 2.0,),
                                      Text("Qté plantées : ${snapshot.data[index].nb_plante}", style: TextStyle(color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.w500),),
                                      // Text("${widget.parc.code} ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 55.0,),
                                 SizedBox( 
                                   width: 60.0,
                                   child:   Container(
                              child: FlatButton(
                                minWidth: 5.0,
                                onPressed: () {
                                  Navigator.push(
                                      context, new MaterialPageRoute(
                                      builder: (context)=>EditEspecePlanting(detailplant: snapshot.data[index],planting: widget.plant, parc: widget.parc)
                                      )
                                  );
                                },
                                color: Color.fromARGB(255, 227, 244, 228),
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
                                 ),
                        SizedBox(width: 5.0,),
                                //  SizedBox(
                                //    width : 60.0,
                                //    child : 
                                //     Container(
                                //       child: FlatButton(
                                //         minWidth: 5.0,
                                //         onPressed:  () async {
                                //               return showDialog<void>(
                                //                 context: context,
                                //                 barrierDismissible: false, // user must tap button!
                                //                 builder: (BuildContext context) {
                                //                   return AlertDialog(
                                //                     title: const Text('AVERTISSEMENT ! '),
                                //                     content: SingleChildScrollView(
                                //                       child: ListBody(
                                //                         children: const <Widget>[
                                //                           // Text("Desole! Vous n'etes plus autorisé a ajouter des plants"),
                                //                           Text('Voulez-vous supprimer cet élément ?',style: TextStyle(fontWeight: FontWeight.bold),),
                                //                         ],
                                //                       ),
                                //                     ),
                                //                     actions: <Widget>[
                                //                       TextButton(
                                //                         child: const Text('OK'),
                                //                         onPressed: () async {
                                //                             await dbHelper.deleteDetailPlanting(snapshot.data[index].code);
                                //                             final plantingUp = widget.plant.copy(
                                //                                 plant_recus: widget.plant.plant_recus-snapshot.data[index].nb_plante ,
                                //                                 plant_total: widget.plant.nb_plant_exitant + widget.plant.plant_recus-snapshot.data[index].nb_plante ,
                                //                                 campagne_id: widget.plant.campagne_id,
                                //                                 user_id: widget.plant.user_id,
                                //                                 // synchro : "NON"
                                                                
                                //                             );

                                //                             await dbHelper.updatePlanting(plantingUp);
                                //                                 Navigator.push(
                                //                                     context, MaterialPageRoute(
                                //                                     builder: (context)=>PlantingParcelle(parc: widget.parc, ))
                                //                                 );
                                //                         },
                                //                       ),

                                //                       TextButton(
                                //                           child: const Text('NON',style: TextStyle(color: Colors.red),),
                                //                           onPressed: () {
                                //                             Navigator.of(context).pop();
                                //                           },
                                //                         ),
                                //                     ],
                                //                   );
                                //                 },
                                //               );
                                //             }
                                //             ,

                                //         color: Color.fromARGB(255, 238, 223, 209),
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(20.0),
                                //         ),
                                //         child: Row(
                                //           children: [
                                //             Icon(Icons.delete,color: Colors.red,),
                                //             // Text('', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                                //           ],
                                //         ),
                                              
                                //         // child: Icon(Icons.chevron_right_sharp,),
                                //       ),
                                //     ),
                                //  )
                          
                        
                               
                                
                                   

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

  );
}