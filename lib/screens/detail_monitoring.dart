import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/models/monitoring.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/screens/monitoringHomePage.dart';
import 'package:flutter/material.dart';

class MonitoringEspecePage extends StatefulWidget {

  final Monitoring monitoring;
  final Planting planting;
  final Parcelle parc;

   MonitoringEspecePage({
      Key key,
      this.monitoring,
      this.planting, 
      this.parc
    }) : super(key: key);

  @override
  State<MonitoringEspecePage> createState() => _MonitoringEspecePageState();
}

var dbHelper = DatabaseHelper();
class _MonitoringEspecePageState extends State<MonitoringEspecePage> {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
     String mort;
     String obs;
     DetailMonitoring detailMn;

    // ignore: deprecated_member_use
    var _listObservation = List<DropdownMenuItem>();

     getObservations() async {
      // ignore: deprecated_member_use
      var observations = await dbHelper.getObservations();
      observations.forEach((observation){
        setState(() {
          _listObservation.add(DropdownMenuItem<String>(
            child: Text(observation['libelle']),
            value: observation['id'].toString(),
            ));
        });
      });

    }

    getFistInstance() async {
       this.detailMn = await dbHelper.firstDetailMonitoring(widget.monitoring.code);
    }

  // final TextEditingController _textEditingController = TextEditingController();

    @override
  void initState(){
    super.initState();
    getObservations();
    getFistInstance();
    mort = '';
    obs = '';

  }

  @override
  Widget build(BuildContext context)  => Scaffold(
       extendBodyBehindAppBar: true,
       appBar: AppBar(
       title: Text("Monitoring par especes"),
       backgroundColor: Color(0xcc5ac1Be),
    ),

        body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: dbHelper.getPlantingEspece(widget.planting.code),
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
                          child : Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [                            
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                    SizedBox(
                                      width: 165.0,
                                      child :Column(
                                        children: [
                                           Text("${snapshot.data[index].libelle} (${snapshot.data[index].accronyme})", style: TextStyle(color: Colors.black,fontSize: 13.0, fontWeight: FontWeight.bold),),
                                           SizedBox(height: 2.0,),
                                          //  Text("|", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                                           Text("Plants reçus : ${snapshot.data[index].nb_plante} ", style: TextStyle(color: Colors.black),),
                                        ],
                                      )
                                    ),
                                     SizedBox(width: 15.0,),
                              snapshot.data[index].etat == 0 ?
                                      SizedBox(
                                        width: 100,
                                        child:  Container(
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
                                                  onPressed:() async {
                                                            await showInformationDialog(context,detailplant: snapshot.data[index]);
                                                          },
                                                child: Text(
                                                  "COMPTER",
                                                  style: TextStyle(
                                                      color: ArgonColors.white,
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 8.0),
                                              ),
                                      ) :
                                        SizedBox(
                                      width: 100,
                                      child:  Container(
                                              height: 38.0,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 88, 221, 35),
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
                                                onPressed:null,
                                              child: Text(
                                                "VOIR",
                                                style: TextStyle(
                                                    color: ArgonColors.white,
                                                    fontSize: 10.0,
                                                    fontWeight:
                                                    FontWeight.bold),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            ),
                                    )
                                   

                              ],
                            ),

                          ],
                        ),
                        )
                 
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

   Future<void> showInformationDialog(BuildContext context,{DetailPlanting detailplant}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField( 
                        initialValue: mort,
                        keyboardType: TextInputType.number,                       
                        // controller: _textEditingController,
                        validator: (mort) {
                          if(this.mort != null && mort.isEmpty){
                            return "Champs obligatoire";
                          }
                          if(int.parse(this.mort) > detailplant.nb_plante){
                            return "Plant mort superieur au plant reçu";
                          }
                          // return value.isNotEmpty ? null : "Enter any text";
                        },
                        decoration:
                            InputDecoration(hintText: "Plant Mort"),
                        onChanged:(mort)=>setState(() =>this.mort = mort),
                      ),
                        DropdownButtonFormField<dynamic>(
                        value: obs.toString().isNotEmpty ? obs.toString() : null,
                        isDense: true,
                        items:_listObservation,
                        hint: Text("Observation"),
                        onChanged:(obs)=>setState(() =>this.obs = obs.toString()),
                        // validator: (obs) =>this.obs != null && obs.isEmpty ? 'Ce champs est obligatoire' : null,              
                    )
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Choice Box"),
                      //     Checkbox(
                      //         value: isChecked,
                      //         onChanged: (checked) {
                      //           setState(() {
                      //             isChecked = checked;
                      //           });
                      //         })
                      //   ],
                      // )
                    ],
                  )),
              title: Text("${detailplant.libelle}| Reçu: ${detailplant.nb_plante}"),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () async {
                    if (_formKey.currentState.validate()) {

                      final monitoringespece = MonitoringEspece(
                        mort: mort,
                        taux_mortalite: "${int.parse(mort)*100/detailplant.nb_plante}",
                        detailmonitoring_id : detailMn.code,
                        detailplanting_id: detailplant.code,
                        detailplantingremplacement_id: null,
                        espece_id: detailplant.espece_id
                      );

                       final monitoring = widget.monitoring.copy(
                          mort_global: widget.monitoring.mort_global + int.parse(mort),
                          mature_global: widget.monitoring.mature_global + detailplant.nb_plante - int.parse(mort),
                          taux_vitalite: "${(detailplant.nb_plante - int.parse(mort))/widget.planting.plant_recus}",
                          taux_mortalite: "${100 - ((detailplant.nb_plante - int.parse(mort))/widget.planting.plant_recus) }",
                          date: widget.monitoring.date,
                          planting_id: widget.planting.code,
                      );

                      
                    await dbHelper.createMonitoringEspece(monitoringespece,monitoring,detailplant);

                    if(obs != "" ){

                       final monitoringObs = ObservationMonitoring(
                        monitoring_id: widget.monitoring.code,
                        obsmonitoring_id: int.parse(obs),
                      );
                      await dbHelper.createMonitoringObs(monitoringObs);

                    }
                     

                     Navigator.push(context, new MaterialPageRoute(builder: (context)=>MonitoringHomePage(planting: widget.planting,parc: widget.parc,)));
                    }
                  },
                ),
              ],
            );
          });
        });
  }

}