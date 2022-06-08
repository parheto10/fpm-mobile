import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/models/campagne.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/plantingParcelle.dart';
import 'package:argon_flutter/widgets/form/planting_form_widget.dart';
import 'package:argon_flutter/screens/formulaire/adddetailplanting.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPlantingPage extends StatefulWidget {

  Parcelle parcelle;

  AddPlantingPage({
     Key key,
     this.parcelle
  
   }) : super(key: key);

  @override
  State<AddPlantingPage> createState() => _AddPlantingPageState();
}
 var dbHelper = DatabaseHelper();
class _AddPlantingPageState extends State<AddPlantingPage> {

    //  DatabaseHelper con =  new DatabaseHelper();
 
  final _formKey = GlobalKey<FormState>();
  String codeparcelle;
  String nbplantExist;
  DateTime date;
  String selectValue;
  String selectValue2;
  String selectValue3;
   // ignore: deprecated_member_use
    var _listCampagne = List<DropdownMenuItem>();
    // ignore: deprecated_member_use
    var _listProjet = List<DropdownMenuItem>();


 

   getCampagnes() async {
      // ignore: deprecated_member_use
      var campagnes = await dbHelper.getCampagne();
      campagnes.forEach((campagne){
        setState(() {
          _listCampagne.add(DropdownMenuItem<String>(
            child: Text(campagne['titre']),
            value: campagne['id'].toString(),
            ));
        });
      });

    }
    
   getProjets() async {
      // ignore: deprecated_member_use
      var projets = await dbHelper.getProjets();
      projets.forEach((projet){
        setState(() {
          _listProjet.add(DropdownMenuItem<String>(
            child: Text(projet['titre']),
            value: projet['id'].toString(),
            ));
        });
      });

    }
  //  getEspeces() async {
  //     // ignore: deprecated_member_use
  //     var especes = await dbHelper.getEspeces();
  //     especes.forEach((espece){
  //       setState(() {
  //         _listEspece.add(DropdownMenuItem<String>(
  //           child: Text(espece['libelle']),
  //           value: espece['id'].toString(),
  //           ));
  //       });
  //     });

  //   }
 



  @override
  void initState(){
    super.initState();
    getCampagnes();
    getProjets();
    codeparcelle = widget.parcelle.code ?? '';
    nbplantExist = '0' ;
    selectValue = '';
    selectValue2 = '';
    selectValue3 = '';

  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Nouveau Planting"),
      actions: [
          buildButtonSave(),
      ],
      backgroundColor: Color(0xcc5ac1Be),
    ),

    body: SingleChildScrollView(
      child: Form(
      key: _formKey,
      child: Column(
        children: [

          PlantingFormWidget(
              codeparcelle: codeparcelle,
              date: date,
              selectValue: selectValue.toString().isNotEmpty ? selectValue.toString() : null,
              campages: _listCampagne,
              plantExist: nbplantExist,
              projets: _listProjet,
              onChangedcampagne: (selectValue)=>setState(() =>this.selectValue = selectValue.toString()),   
              onChangedprojet: (selectValue2)=>setState(() =>this.selectValue2 = selectValue2.toString()),
              onChangedplantExist: (nbplantExist)=>setState(() =>this.nbplantExist = nbplantExist),
              onChangedateplanting: (date)=>setState(() =>this.date = date),
          ),          
        ],
      )
      
      ),
    ),

  );






    Widget buildButtonSave(){
    final isFormValid = selectValue.isNotEmpty && nbplantExist.isNotEmpty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addPlanting,
        child: Text('Enregistrer'),
      ),
    );
  }



  void addPlanting() async {
    final isValid = _formKey.currentState.validate();    
    // print(User.sessionUser.id);
    if(isValid){
      await addPlantings();
      Navigator.push(
          context, new MaterialPageRoute(
          builder: (context)=>PlantingParcelle(parc: widget.parcelle, ))
      );
    }
  }

  Future addPlantings() async {
    final planting = Planting(
      code: "${DateTime.now().millisecondsSinceEpoch}PLG",
      date: date,
      nb_plant_exitant: int.parse(nbplantExist),
      plant_recus: 0,
      plant_total: 0,
      campagne_id: int.parse(selectValue),
      parcelle_id: widget.parcelle.code,
      user_id: User.sessionUser.id,
      synchro: "NON"


    );

    await dbHelper.createPlanting(planting);

  }






  // onAddFormPlant() {

  //   setState(() {});
  //     if (detailplant.length >= 5) {
  //         return;
  //   }
  //   setState(() {
  //    var _plant = DetailPlanting();
  //    detailplant.add(DetailPlantingForm(
  //    detailPlanting: _plant,
  //    especes: _listEspece,
  //    selectValue3: selectValue3.toString().isNotEmpty ? selectValue3.toString() : null,
  //    nbplant: nb_plant,
  //    lengths: detailplant.length + 1,
  //    onChangedEspece: (selectValue3){this.espece = selectValue3.toString();} ,
  //    onChangedNbplant: (nb_plant){this.nb_plant = nb_plant;},        
  //    onDelete: ()=> onDelete(_plant),

  //   ));
  //   });
  
    
  // }

  //  onDelete(DetailPlanting _plant){
  //   setState(() {
  //     var find = detailplant.firstWhere(
  //       (it) => it.detailPlanting == _plant,
  //       orElse: () => null
  //       );
  //       if(find != null ) detailplant.removeAt(detailplant.indexOf(find));
  //   });
  // }


}


