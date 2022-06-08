import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/data_services/producteur.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class AddProducteurPage extends StatefulWidget {
  const AddProducteurPage({ Key key }) : super(key: key);

  @override
  State<AddProducteurPage> createState() => _AddProducteurPageState();
}

 var dbHelper = DatabaseHelper();

class _AddProducteurPageState extends State<AddProducteurPage> {
    final _formKey = GlobalKey<FormState>();
    String code;
    String nom;
    String genre;
    String localite;
    String nbEnfant;
    String nb_scolariser;
    String nbparc;
    String contact;
    DateTime dob;
    String document;
    String numdoc;
    String secId;
    // ignore: deprecated_member_use
    var _listSection = List<DropdownMenuItem>();

  final List<Map<String, dynamic>> _genre = [
  {
    'value': 'H',
    'label': 'HOMME',
  },
   {
    'value': 'F',
    'label': 'FEMME',
  },

];
  final List<Map<String, dynamic>> _document = [
      {
    'value': 'AUCUN',
    'label': 'AUCUN',
  },
  {
    'value': 'CNI',
    'label': 'CARTE D\'IDENTITE',
  },
   {
    'value': 'ATT',
    'label': 'ATTESTATION D\'IDENTITE',
  },
     {
    'value': 'CC',
    'label': 'CARTE DE SEJOUR',
  },

];

     getSections() async {
      // ignore: deprecated_member_use
      var sections = await dbHelper.getSections();
      // print(sections);

      sections.forEach((section){
        setState(() {
          _listSection.add(DropdownMenuItem<String>(
            child: Text(section['libelle']),
            value: section['id'].toString(),
            ));
        });
      });

    }

  @override
  void initState(){
    getSections();
    super.initState();
    code = '';
    nom = '';
    genre = '';
    localite = '';
    nbEnfant = '';
    nb_scolariser = '';
    nbparc = '';
    contact = '';
    numdoc = '';
    secId = '';

  }


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Nouveau producteur"),
      actions: [
        buildButtonSave()
      ],
       backgroundColor: Color(0xcc5ac1Be),
    ),

    body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding : EdgeInsets.all(16),
          child: Material(
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children : [
                 Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: code,
                          onSaved : (code)=>setState(() =>this.code = code),
                          onChanged: (code)=>setState(() =>this.code = code),
                          validator: (nbplant)=> this.code != null && code.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Code du producteur',
                            hintText: 'Code du producteur',
                            isDense: true
                          ),
                        ),

                  ),
                 Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: nom,
                          onSaved : (nom)=>setState(() =>this.nom = nom),
                          onChanged: (nom)=>setState(() =>this.nom = nom),
                          validator: (nom)=> this.nom != null && nom.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Nom et Prénoms',
                            hintText: 'Nom et Prénoms',
                            isDense: true
                          ),
                        ),

                  ),
                 Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 15),
                        child:DateTimeFormField(
                              initialDate: dob,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Date de naissance',
                              ),
                              mode: DateTimeFieldPickerMode.date,
                              autovalidateMode: AutovalidateMode.always,
                              // validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                              onDateSelected:(DateTime dob)=>setState(() =>this.dob = dob),
                                // print(dob);
                             
                            ),

                  ),
                 Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child:SelectFormField(
                                type: SelectFormFieldType.dropdown, 
                                labelText: 'Genre',
                                items: _genre,
                                onChanged:(genre)=>setState(() =>this.genre = genre.toString()),
                                onSaved: (genre)=>setState(() =>this.genre = genre.toString()),
                      )
                  ),
                 Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child:DropdownButtonFormField<dynamic>(
                        value: secId.toString().isNotEmpty ? secId.toString() : null,
                        isDense: true,
                        items:_listSection,
                        hint: Text("Section"),
                        onChanged:(secId)=>setState(() =>this.secId = secId.toString()),
                        // validator: (projets) =>projets != null && projets.isEmpty ? 'Ce champs est obligatoire' : null,
                                  
                    )
                  ),
                 Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: localite,
                          onSaved : (localite)=>setState(() =>this.localite = localite),
                          onChanged: (localite)=>setState(() =>this.localite = localite),
                          validator: (localite)=> this.localite != null && localite.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Localité',
                            hintText: 'Localité',
                            isDense: true
                          ),
                        ),

                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 150,
                  //       child:  Padding(
                  //       padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  //             child: TextFormField(
                  //                keyboardType: TextInputType.number,
                  //               initialValue: nbEnfant,
                  //               onSaved : (nbEnfant)=>setState(() =>this.nbEnfant = nbEnfant),
                  //               onChanged: (nbEnfant)=>setState(() =>this.nbEnfant = nbEnfant),
                  //               validator: (nbEnfant)=> this.nbEnfant != null && nbEnfant.isEmpty ? 'Obligatoire' : null,
                  //               decoration: InputDecoration(
                  //                 labelText: 'Nbre Enfants ',
                  //                 hintText: 'Enfants ',
                  //                 isDense: true
                  //               ),
                  //             ),

                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 150,
                  //       child:  Padding(
                  //       padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  //             child: TextFormField(
                  //               keyboardType: TextInputType.number,
                  //               initialValue: nb_scolariser,
                  //               onSaved : (nb_scolariser)=>setState(() =>this.nb_scolariser = nb_scolariser),
                  //               onChanged: (nb_scolariser)=>setState(() =>this.nb_scolariser = nb_scolariser),
                  //               validator: (nb_scolariser)=> this.nb_scolariser != null && nb_scolariser.isEmpty ? 'Obligatoire' : null,
                  //               decoration: InputDecoration(
                  //                 labelText: 'Enf. scolarise ',
                  //                 hintText: 'Enf. scolarise ',
                  //                 isDense: true
                  //               ),
                  //             ),

                  //       ),
                  //     )
                  //   ],
                  // ),
                  Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                              child: TextFormField(
                                 keyboardType: TextInputType.number,
                                initialValue: nbparc,
                                onSaved : (nbparc)=>setState(() =>this.nbparc = nbparc),
                                onChanged: (nbparc)=>setState(() =>this.nbparc = nbparc),
                                validator: (nbparc)=> this.nbparc != null && nbparc.isEmpty ? 'Ce champs est obligatoire' : null,
                                decoration: InputDecoration(
                                  labelText: 'Nombre parcelles',
                                  hintText: 'Nombre parcelles ',
                                  isDense: true
                                ),
                              ),

                        ),
                  Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                              child: TextFormField(
                                 keyboardType: TextInputType.number,
                                 maxLength: 10,
                                initialValue: contact,
                                onSaved : (contact)=>setState(() =>this.contact = contact),
                                onChanged: (contact)=>setState(() =>this.contact = contact),
                                // validator: (contact)=> this.contact != null && contact.isEmpty ? 'Ce champs est obligatoire' : null,
                                decoration: InputDecoration(
                                  labelText: 'Contact',
                                  // hintText: 'Contact',
                                  isDense: true,
                                  prefixIcon: Padding(
                                      padding: EdgeInsetsDirectional.only(start: 12.0),
                                      child: Icon(Icons.phone), // myIcon is a 48px-wide widget.
                                  ),
                                 prefixText :  '+ 225 '
                                ),
                              ),

                        ),
                 Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child:SelectFormField(
                                type: SelectFormFieldType.dropdown, 
                                labelText: 'Pièce',
                                items: _document,
                                onChanged:(document)=>setState(() =>this.document = document.toString()),
                                onSaved: (document)=>setState(() =>this.document = document.toString()),
                      )
                  ),

                  Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: TextFormField(
                          initialValue: numdoc,
                          onSaved : (numdoc)=>setState(() =>this.numdoc = numdoc),
                          onChanged: (numdoc)=>setState(() =>this.numdoc = numdoc),
                          // validator: (localite)=> this.localite != null && localite.isEmpty ? 'Ce champs est obligatoire' : null,
                          decoration: InputDecoration(
                            labelText: 'Numéro de pièce',
                            hintText: 'Numéro de pièce',
                            isDense: true
                          ),
                        ),

                  ),
                
              ]
            ),
          ),
        ),
      ),
    ),

  );

    Widget buildButtonSave(){
    final isFormValid = code.isNotEmpty && nom.isNotEmpty && nbparc.isNotEmpty ;

   
      return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Color.fromARGB(255, 255, 255, 255),
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addProd,
        child: Text('Enregistrer'),
      ),
    );
   
    
  
   
  }

    void addProd() async {        
      final isValid = _formKey.currentState.validate();
      if(isValid){
        if(code.isNotEmpty && nom.isNotEmpty && nbparc.isNotEmpty){
          addProducteur();
          Navigator.pushReplacementNamed(context, '/producteurs');
        }
        
      }

  }


  Future addProducteur() async {

    final producteur = Producteur(
      code: code.toUpperCase(),
      nom: nom.toUpperCase(),
      nb_enfant: 0,
      nb_epouse: 0,
      nb_parcelle: int.parse(nbparc),
      genre: genre,
      dob:  dob == null ?  DateTime.parse('1900-12-31T05:00:00.000') : dob,
      localite: localite.toUpperCase(),
      enfant_scolarise: 0,
      contacts: contact,
      type_producteur: "MEMBRE",
      type_document: document,
      num_document: numdoc.toUpperCase(),
      cooperative_id: User.sessionUser.cooperative_id,
      section_id: int.parse(secId),
      origine_id: 1,
      image: "logo_homme.jpeg",
      is_active : 1,
      user_id: User.sessionUser.id,
      created_at : DateTime.now(),
      updated_at : DateTime.now(),
      synchro: "NON"

    );

    await dbHelper.createProducteurs(producteur);

  }






}