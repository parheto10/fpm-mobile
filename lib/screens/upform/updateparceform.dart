import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/data_services/producteur.dart';
import 'package:argon_flutter/models/parcelles.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/widgets/form/parcel_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:select_form_field/select_form_field.dart';

class UpdateParcelleForm extends StatefulWidget {
   Parcelle parcelle;
  
   UpdateParcelleForm({ 
     Key key,
     this.parcelle,
      }) : super(key: key);

  @override
  State<UpdateParcelleForm> createState() => _UpdateParcelleFormState();
}
 var dbHelper = DatabaseHelper();
class _UpdateParcelleFormState extends State<UpdateParcelleForm> {
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
  // String selectValue;
  int proje;
  String proj;
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

      final List<Map<String, dynamic>> _culture = [
  {
    'value': '',
    'label': 'AUCUN',
  },
   {
    'value': 'CACAO',
    'label': 'CACAO',
  },
    {
    'value': 'ANACARDE',
    'label': 'ANACARDE',
  },
    {
    'value': 'CAFE',
    'label': 'CAFE',
  },
  {
    'value': 'COTON',
    'label': 'COTON',
  },

];

  final List<Map<String, dynamic>> _certification = [
    {
      'value': 'UTZ',
      'label': 'UTZ',
    },
    {
      'value': 'RA',
      'label': 'RA',
    },
      {
      'value': 'PROJET',
      'label': 'PROJET',
    },
      {
      'value': 'BIO',
      'label': 'BIO',
    },
    {
      'value': 'AUTRE',
      'label': 'AUTRE',
    },

  ];

  final List<Map<String, dynamic>> _acquisition = [
    {
      'value': 'HERITAGE',
      'label': 'HERITAGE',
    },
    {
      'value': 'ACHAT',
      'label': 'ACHAT',
    },
      {
      'value': 'AUTRE',
      'label': 'AUTRE',
    },

  ];


  // void countParcelleCoop() async {
    
  //   int count = await dbHelper.getNumParcProd(widget.prod.code);
  //    setState(() {
  //     nbParcelle = count;
      

  //  });
 
  // }


  @override
  void initState(){
    super.initState();
    // countParcelleCoop();
    getProjets();
    

    // codeproducteur = widget.prod.code ?? '';
    // nomprod = widget.prod.nom ?? '';
    // idprod = widget.prod.code ?? '';


    codeCertificat = widget.parcelle?.code_certificat ?? '';
    certification = widget.parcelle?.certification ?? '';
    culture = widget.parcelle?.culture ?? '';
    anneeCertificat = widget.parcelle?.annee_certificat ?? '';
    anneeAcquisition = widget.parcelle?.annee_acquis ?? '';
    acquisition = widget.parcelle?.acquisition ?? '';
    longitude = widget.parcelle?.longitude ?? '' ;
    latitude = widget.parcelle?.latitude ?? '';
    superficie = widget.parcelle?.superficie ?? '';
    proje = widget.parcelle.projet_id ?? '';
    // print(proje);
    proj = '${proje}';

    // print(widget.parcelle.projet_id);
   
    
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("${widget.parcelle.code}"),
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
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                            Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: SelectFormField(
                      initialValue: culture,
                    type: SelectFormFieldType.dropdown, 
                    labelText: 'Culture',
                    items: _culture,
                    onChanged:(culture)=>setState(() =>this.culture = culture),
                    onSaved: (culture)=>setState(() =>this.culture = culture),
          ),
           ),
           SizedBox(height: 5),
          Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: superficie,
                           keyboardType : TextInputType.number,
                          onSaved : (superficie)=>setState(() =>this.superficie = superficie),
                          onChanged: (superficie)=>setState(() =>this.superficie = superficie),
                          validator: (superficie)=> this.superficie != null && superficie.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Superficie *',
                            hintText: 'Superficie *',
                            isDense: true
                          ),
                        ),

                  ),
            SizedBox(height: 5,),
                              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: SelectFormField(
                      initialValue: certification,
                    type: SelectFormFieldType.dropdown, 
                    labelText: 'Certification',
                    items: _certification,
                    onChanged:(certification)=>setState(() =>this.certification = certification),
                    onSaved: (certification)=>setState(() =>this.certification = certification),
          ),
           ),
           SizedBox(height: 5),
           Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: codeCertificat,
                          //  keyboardType : TextInputType.number,
                          onSaved : (codeCertificat)=>setState(() =>this.codeCertificat = codeCertificat),
                          onChanged: (codeCertificat)=>setState(() =>this.codeCertificat = codeCertificat),
                          // validator: (codeCertificat)=> this.codeCertificat != null && codeCertificat.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Code certification ',
                            hintText: 'Code certification',
                            isDense: true
                          ),
                        ),

                  ),

                  Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: anneeCertificat,
                           keyboardType : TextInputType.number,
                          onSaved : (anneeCertificat)=>setState(() =>this.anneeCertificat = anneeCertificat),
                          onChanged: (anneeCertificat)=>setState(() =>this.anneeCertificat = anneeCertificat),
                          // validator: (anneeCertificat)=> this.anneeCertificat != null && anneeCertificat.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Année certification',
                            hintText: 'Année certification',
                            isDense: true
                          ),
                        ),

                  ),

                         Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: SelectFormField(
                      initialValue: acquisition,
                    type: SelectFormFieldType.dropdown, 
                    labelText: 'Acquisition',
                    items: _acquisition,
                    onChanged:(acquisition)=>setState(() =>this.acquisition = acquisition),
                    onSaved: (acquisition)=>setState(() =>this.acquisition = acquisition),
          ),
           ),

                             Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: anneeAcquisition,
                           keyboardType : TextInputType.number,
                          onSaved : (anneeAcquisition)=>setState(() =>this.anneeAcquisition = anneeAcquisition),
                          onChanged: (anneeAcquisition)=>setState(() =>this.anneeAcquisition = anneeAcquisition),
                          // validator: (anneeAcquisition)=> this.anneeAcquisition != null && anneeAcquisition.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Année acquisition',
                            hintText: 'Année acquisition',
                            isDense: true
                          ),
                        ),

                  ),

             Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child:  DropdownButtonFormField<dynamic>(
                value: proj,
                isDense: true,
                items:_listProjet,
                hint: Text("Projet *"),
                onChanged: (proj)=>setState(() =>this.proj = proj),
                validator: (proj) =>proj != null && proj.isEmpty ? 'Ce champs est obligatoire' : null,
                          
            )
           ),

                    Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: longitude,
                           keyboardType : TextInputType.number,
                          onSaved : (longitude)=>setState(() =>this.longitude = longitude),
                          onChanged: (longitude)=>setState(() =>this.longitude = longitude),
                          validator: (longitude)=> this.longitude != null && longitude.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Longitude * ',
                            hintText: '${longitude}',
                            isDense: true
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
                            labelText: 'Latitude * ',
                            hintText: '${latitude}',
                            isDense: true
                          ),
                        ),

                  ),

                ],
              )
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
          primary: null,
        ),
        onPressed: addOrUpdateParcelle,
        child: Text('Enregistrer'),
      ),
    );
  }

    void addOrUpdateParcelle() async {
    final isValid = _formKey.currentState.validate();
    

        if(isValid) {
          await addParcelle();
          Navigator.pushReplacementNamed(context, '/parcelles');
          }
    
   

  }


  Future addParcelle() async {

   
        final parcelle = widget.parcelle.copy(
        code_certificat: codeCertificat,
        annee_certificat: anneeCertificat,
        annee_acquis: anneeAcquisition,
        acquisition: acquisition,
        latitude: latitude,
        longitude: longitude,
        superficie: superficie,
        culture: culture ,
        projet_id: int.parse(proj)  ,
        certification: certification ,
        producteur_id: widget.parcelle.producteur_id,
        user_id: User.sessionUser.id,
        synchro: "NON"
      );

      // print(parcelle.latitude);

      await dbHelper.updateParcelle(parcelle);


  
  }

}