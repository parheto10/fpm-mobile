import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:flutter/material.dart';


class DetailPlantingFormPage extends StatefulWidget {
  
  Planting planting;
  DetailPlantingFormPage({ 
    Key key,
    this.planting
    }) : super(key: key);

  @override
  State<DetailPlantingFormPage> createState() => _DetailPlantingFormPageState();
}

 var dbHelper = DatabaseHelper();
class _DetailPlantingFormPageState extends State<DetailPlantingFormPage> {
  final _formKey = GlobalKey<FormState>();
  // ignore: deprecated_member_use
  var _listEspeces = List<DropdownMenuItem>();
  String espece;
  String nbplant;
  int count ;



     getEspeces() async {
      // ignore: deprecated_member_use
      var especes = await dbHelper.getEspeces();
      especes.forEach((espece){
        setState(() {
          _listEspeces.add(DropdownMenuItem<String>(
            child: Text(espece['libelle']),
            value: espece['id'].toString(),
            ));
        });
      });

    }

    getCount() async{
      count = await dbHelper.getNumberOfMonitoringForPlanting(widget.planting.code);
  
    }
                 
                    

  @override
  void initState(){
    super.initState();
    getEspeces();
    getCount();
    espece = '';
    nbplant = '';

  }


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [
        buildButtonSave() 
      ],
       backgroundColor: Color(0xcc5ac1Be),
    ),

    body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Material(
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                leading: Icon(Icons.verified_sharp),
                elevation: 0,
                title: Text("Ajouter des especes"),
                // ignore: deprecated_member_use
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
              ),

              DropdownButtonFormField(
                items: _listEspeces, 
                onChanged: (espece)=>setState(() =>this.espece = espece.toString()),
                hint: Text("Espece *"),
                value: espece.toString().isNotEmpty ? espece.toString() : null,
                isDense: true,
              ),
                        SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: TextFormField(
                keyboardType : TextInputType.number,
                initialValue: nbplant,
                onSaved : (nbplant)=>setState(() =>this.nbplant = nbplant),
                onChanged: (nbplant)=>setState(() =>this.nbplant = nbplant),
                validator: (nbplant)=> this.nbplant != null && nbplant.isEmpty ? 'Ce champs est obligatoire' : null,
                decoration: InputDecoration(
                  labelText: 'Nombre de plants *',
                  hintText: 'Entrer le nombre',
                  isDense: true
                ),
              ),
            ),
              

              ],
            ),
          ),
        )
      ),
    ),
  );








  Widget buildButtonSave(){
    final isFormValid = espece.isNotEmpty && nbplant.isNotEmpty;
 
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Color.fromARGB(255, 255, 255, 255),
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addDetailplant,
        child: Text('Enregistrer'),
      ),
    );
  
   
  }


  void addDetailplant() async{
          // print(count);
      if(count > 0 ){
         _showMyDialog();
      }else{
      final isValid = _formKey.currentState.validate();
      if(isValid){
        await addDetailplanting();
        Navigator.of(context).pop();
  
    }
      }

  }


  Future addDetailplanting() async{

    final detail = DetailPlanting(
        code: "${DateTime.now().millisecondsSinceEpoch}DPL",
        nb_plante: int.parse(nbplant),
        espece_id: int.parse(espece),
        planting_id: widget.planting.code ,
        user_id: User.sessionUser.id,
        synchro: "NON"
    );

    await dbHelper.createdetailPlanting(detail);

    final plantingUp = widget.planting.copy(
        plant_recus: widget.planting.plant_recus + int.parse(nbplant),
        plant_total: widget.planting.nb_plant_exitant + widget.planting.plant_recus + int.parse(nbplant),
        campagne_id: widget.planting.campagne_id,
        user_id: User.sessionUser.id,
        // synchro : "OUI"
        
    );

    await dbHelper.updatePlanting(plantingUp);



  }

Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AVERTISSEMENT ! '),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              // Text("Desole! Vous n'etes plus autorisé a ajouter des plants"),
              Text('Desole! Veillez effectuer un remplacement ',style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
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

