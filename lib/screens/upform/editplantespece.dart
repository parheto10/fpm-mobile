import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/planting.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/detail_espece.dart';
import 'package:argon_flutter/screens/plantingParcelle.dart';
import 'package:flutter/material.dart';

class EditEspecePlanting extends StatefulWidget {
  DetailPlanting detailplant;
  Planting planting;
  Parcelle parc;
   EditEspecePlanting({
      Key key,
      this.detailplant,
      this.planting,
      this.parc
    })
     : super(key: key);

  @override
  State<EditEspecePlanting> createState() => _EditEspecePlantingState();
}
var dbHelper = DatabaseHelper();
class _EditEspecePlantingState extends State<EditEspecePlanting> {
    final _formKey = GlobalKey<FormState>();
      // ignore: deprecated_member_use
    var _listEspeces = List<DropdownMenuItem>();
    int espece;
    int nbplant;
    String esp;
    String nb;
    // int count ;

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



  @override
  void initState(){
    super.initState();
    getEspeces();
    espece = widget.detailplant.espece_id ?? '';
    nbplant =widget.detailplant.nb_plante ?? '';

    esp = "${espece}";
    nb = "${nbplant}";

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
                onChanged: (esp)=>setState(() =>this.esp = esp),
                hint: Text("Espece *"),
                value: esp.isNotEmpty ? esp : null,
                isDense: true,
              ),
                        SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: TextFormField(
                keyboardType : TextInputType.number,
                initialValue: nb,
                onSaved : (nb)=>setState(() =>this.nb = nb),
                onChanged: (nb)=>setState(() =>this.nb = nb),
                validator: (nb)=> this.nb != null && nb.isEmpty ? 'Ce champs est obligatoire' : null,
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
    final isFormValid = esp.isNotEmpty && nb.isNotEmpty;
 
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
      final isValid = _formKey.currentState.validate();
      if(isValid){
        await addDetailplanting();
          Navigator.push(
          context, new MaterialPageRoute(
         builder: (context)=>PlantingParcelle(parc: widget.parc, ))
      );
  
    }
      

  }


  Future addDetailplanting() async{

    final detail = widget.detailplant.copy(
        nb_plante: int.parse(nb),
        espece_id: int.parse(esp),
        planting_id: widget.detailplant.planting_id ,
        user_id: User.sessionUser.id,
        synchro: "NON"
        
    );

    await dbHelper.updateDetailplant(detail);

    final plantingUp = widget.planting.copy(
        plant_recus: (widget.planting.plant_recus-nbplant) + int.parse(nb),
        plant_total: widget.planting.nb_plant_exitant + (widget.planting.plant_recus-nbplant) + int.parse(nb),
        campagne_id: widget.planting.campagne_id,
        user_id: User.sessionUser.id,
        synchro : "NON"
        
    );

    await dbHelper.updatePlanting(plantingUp);



  }

  
}