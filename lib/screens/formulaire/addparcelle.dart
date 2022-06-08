
import 'package:argon_flutter/controller/querySql.dart';
import 'package:argon_flutter/data_services/producteur.dart';
import 'package:argon_flutter/models/campagne.dart';
import 'package:argon_flutter/widgets/form/parcel_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:geolocator/geolocator.dart';



class AddParcellePage extends StatefulWidget {
  Producteur prod;
  Parcelle parcelle;

   AddParcellePage({
     Key key,
     this.prod,
     this.parcelle
   }) : super(key: key);

  @override
  State<AddParcellePage> createState() => _AddParcellePageState();
}

 var dbHelper = DatabaseHelper();

class _AddParcellePageState extends State<AddParcellePage> {
  final _formKey = GlobalKey<FormState>();
  String codeproducteur;
  String nomprod;
  String codeCertificat;
  String certification;
  String culture;
  String acquisition;
  var latitude = "";
  String superficie;
  var longitude = "";
  String anneeCertificat;
  String anneeAcquisition;
  String idprod;
  int user_id ;
  int nbParcelle;
  String selectValue = "";
  // ignore: deprecated_member_use
  var _listProjet = List<DropdownMenuItem>();

  // Future<List<Campagne>> _campagnes;
     getCurrentLocation() async {
        var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        var lastPosition = await Geolocator().getLastKnownPosition();
 
          var lat = "${position.latitude}";
          var lon= "${position.longitude}";
         

    setState(() {
          latitude = lat;
          longitude= lon;

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

  void countParcelleCoop() async {
    
    int count = await dbHelper.getNumParcProd(widget.prod.code);
     setState(() {
      nbParcelle = count;
      

   });
 
  }


  @override
  void initState(){
    super.initState();
    countParcelleCoop();
    getProjets();
    

    codeproducteur = widget.prod.code ?? '';
    nomprod = widget.prod.nom ?? '';
    idprod = widget.prod.code ?? '';


    codeCertificat = widget.parcelle?.code_certificat ?? '';
    certification = widget.parcelle?.certification ?? '';
    culture = widget.parcelle?.culture ?? '';
    anneeCertificat = widget.parcelle?.annee_certificat ?? '';
    anneeAcquisition = widget.parcelle?.annee_acquis ?? '';
    acquisition = widget.parcelle?.acquisition ?? '';
    // longitude = widget.parcelle?.longitude ?? '' ;
    // latitude = widget.parcelle?.latitude ?? '';
    superficie = widget.parcelle?.superficie ?? '';
   
    
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("${nomprod}"),
      actions: [
        buildButtonSave(),
      ],
      backgroundColor: Color(0xcc5ac1Be),
    ),

    body: SingleChildScrollView(
        child :Column(
          children: [
            Form(
              key: _formKey,
              child: ParcelFormWidget(
                // codeproducteur: codeproducteur,
                certification: certification,
                codeCertificat: codeCertificat,
                acquisition: acquisition,
                anneeAcquisition: anneeAcquisition,
                anneeCertificat: anneeCertificat,
                culture: culture,
                superficie: superficie,
                projets: _listProjet,
                onChangedprojet: (selectValue)=>setState(() =>this.selectValue = selectValue.toString()),
                onChangedcodeCertificat: (codeCertificat) => setState(() => this.codeCertificat = codeCertificat),
                onChangedsuperficie: (superficie) => setState(() => this.superficie = superficie),
                onChangedacquisition: (acquisition) =>setState(() => this.acquisition = acquisition) ,
                onChangedanneeAcquisition: (anneeAcquisition)=>setState(() => this.anneeAcquisition = anneeAcquisition) ,
                onChangedanneeCertificat: (anneeCertificat)=>setState(() => this.anneeCertificat = anneeCertificat) ,
                onChangedcertification: (certification)=>setState(() =>this.certification = certification),
                onChangedculture: (culture)=>setState(() =>this.culture = culture) ,        


              ),
            ),
          //    Text(
          //     'Latitude : ${latitude}',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 15,
          //       fontWeight: FontWeight.bold,
          //     ),
          // ),
          //    Text(
          //     'Longitude : ${longitude}',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 15,
          //       fontWeight: FontWeight.bold,
          //     ),
          // ),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: longitude,
                           keyboardType : TextInputType.number,
                          onSaved : (longitude)=>setState(() =>this.longitude = longitude),
                          onChanged: (longitude)=>setState(() =>this.longitude = longitude),
                          validator: (longitude)=> this.longitude != null && longitude.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: '${longitude}',
                            hintText: '${longitude}',
                            isDense: true,
                             errorText: this.latitude != null && latitude.isEmpty ? 'Le champs Longitude est obligatoire' : null,
                          ),
                        ),

              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: latitude,
                           keyboardType : TextInputType.number,
                          onSaved : (latitude)=>setState(() =>this.latitude = latitude),
                          onChanged: (latitude)=>setState(() =>this.latitude = latitude),
                          validator: (latitude)=> this.latitude != null && latitude.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '${latitude}',
                            hintText: '${latitude}',
                            isDense: true,
                            errorText: this.latitude != null && latitude.isEmpty ? 'Le champs Latitude est obligatoire' : null,
                          ),
                        ),

                  ),

            ],
        )

      
    ),

      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 64, 217, 176),
          child: Icon(
            Icons.location_on,
             color: Colors.blue,
            ),
          onPressed:()  {
                         getCurrentLocation();
                      },
          
        ),


  );

  Widget buildButtonSave(){
    final isFormValid = superficie.isNotEmpty &&  longitude.isNotEmpty && latitude.isNotEmpty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Color.fromARGB(255, 143, 125, 125),
        ),
        onPressed: addOrUpdateParcelle,
        child: Text('Enregistrer'),
      ),
    );
  }

  void addOrUpdateParcelle() async {
    final isValid = _formKey.currentState.validate();
   
     if(nbParcelle < widget.prod.nb_parcelle){
        if(isValid) {
          await addParcelle();
          Navigator.pushReplacementNamed(context, '/parcelles');
          }
    }else{
      _showMyDialog();
    }
   

  }


  Future addParcelle() async {

    // 
        final parcelle = Parcelle(
        code: widget.prod.code+'P0${nbParcelle+1}',
        code_certificat: codeCertificat,
        annee_certificat: anneeCertificat,
        annee_acquis: anneeAcquisition,
        acquisition: acquisition,
        latitude: latitude,
        longitude: longitude,
        superficie: superficie,
        culture: culture,
        projet_id: selectValue =="" || selectValue == null ? 1 : int.parse(selectValue),
        producteur_id :widget.prod.code, 
        certification: certification,
        user_id: User.sessionUser.id,
        created_at: DateTime.now(),
        updated_at: DateTime.now(),
        synchro: "NON"
      );
// print(parcelle.projet_id);
      await DatabaseHelper.internal().createParcelle(parcelle);


  
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
              Text('Desole! Veillez verifier le nombre de parcelle pour cet producteur.'),
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