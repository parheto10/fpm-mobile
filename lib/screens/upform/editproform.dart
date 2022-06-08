import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/data_services/producteur.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';


class EditProdFormPage extends StatefulWidget {

  Producteur product;

   EditProdFormPage({ 
     Key key,
     this.product
     })
      : super(key: key);

  @override
  State<EditProdFormPage> createState() => _EditProdFormPageState();
}

 var dbHelper = DatabaseHelper();
class _EditProdFormPageState extends State<EditProdFormPage> {
   final _formKey = GlobalKey<FormState>();
    String code;
    String nom;
    String genre;
    String localite;
    int nbEnfant;
    int nb_scolariser;
    int nbparc;
    String nb_Enfant;
    String nbscolariser;
    String nb_parc;
    String contact;
    DateTime dob;
    String document;
    String numdoc;
    int secId;
    String sec;
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
    code = widget.product.code ?? '';
    nom =  widget.product.nom ?? '';
    genre =  widget.product.genre ??'';
    localite =  widget.product.localite ??'';
    nbEnfant =  widget.product.nb_enfant ?? 0;
    nb_scolariser =  widget.product.enfant_scolarise ??'';
    nbparc =  widget.product.nb_parcelle ??'';
    contact =  widget.product.contacts ??'';
    numdoc =  widget.product.num_document ??'';
    secId =  widget.product.section_id ??'';
    // dob = widget.product.dob ?? '';
    nb_Enfant =  "${nbEnfant}";
    nbscolariser =  "${nb_scolariser}";
    nb_parc =  "${nbparc}";
    sec =  "${secId}";

  }
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Modifier producteur"),
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
                //  Padding(
                //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 15),
                //         child:DateTimeFormField(
                //               initialDate: dob,
                //               decoration: const InputDecoration(
                //                 hintStyle: TextStyle(color: Colors.black45),
                //                 errorStyle: TextStyle(color: Colors.redAccent),
                //                 border: OutlineInputBorder(),
                //                 suffixIcon: Icon(Icons.event_note),
                //                 labelText: 'Date de naissance',
                //               ),
                //               mode: DateTimeFieldPickerMode.date,
                //               autovalidateMode: AutovalidateMode.always,
                //               validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                //               onDateSelected:(DateTime dob)=>setState(() =>this.dob = dob),
                //                 // print(dob);
                             
                //             ),

                //   ),
                //  Padding(
                //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                //         child:SelectFormField(
                //                 type: SelectFormFieldType.dropdown, 
                //                 labelText: 'Genre',
                //                 items: _genre,
                //                 onChanged:(genre)=>setState(() =>this.genre = genre.toString()),
                //                 onSaved: (genre)=>setState(() =>this.genre = genre.toString()),
                //       )
                //   ),
                 Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child:DropdownButtonFormField<dynamic>(
                        value: sec.toString().isNotEmpty ? sec.toString() : null,
                        isDense: true,
                        items:_listSection,
                        hint: Text("Section"),
                        onChanged:(sec)=>setState(() =>this.sec = sec.toString()),
                        validator: (sec) =>sec != null && sec.isEmpty ? 'Ce champs est obligatoire' : null,
                                  
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
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child:  Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                              child: TextFormField(
                                 keyboardType: TextInputType.number,
                                initialValue: nb_Enfant,
                                onSaved : (nb_Enfant)=>setState(() =>this.nb_Enfant = nb_Enfant ),
                                onChanged: (nb_Enfant)=>setState(() =>this.nb_Enfant = nb_Enfant ),
                                validator: (nb_Enfant)=> this.nb_Enfant != null && nb_Enfant.isEmpty ? 'Obligatoire' : null,
                                decoration: InputDecoration(
                                  labelText: 'Nbre Enfants ',
                                  hintText: 'Enfants ',
                                  isDense: true
                                ),
                              ),

                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child:  Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: nbscolariser,
                                onSaved : (nbscolariser)=>setState(() =>this.nbscolariser = nbscolariser),
                                onChanged: (nbscolariser)=>setState(() =>this.nbscolariser =  nbscolariser),
                                validator: (nbscolariser)=> this.nbscolariser != null && nbscolariser.isEmpty ? 'Obligatoire' : null,
                                decoration: InputDecoration(
                                  labelText: 'Enf. scolarise ',
                                  hintText: 'Enf. scolarise ',
                                  isDense: true
                                ),
                              ),

                        ),
                      )
                    ],
                  ),
                  Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                              child: TextFormField(
                                 keyboardType: TextInputType.number,
                                initialValue: nb_parc,
                                onSaved : (nb_parc)=>setState(() =>this.nb_parc =nb_parc ),
                                onChanged: (nb_parc)=>setState(() =>this.nb_parc =nb_parc ),
                                validator: (nb_parc)=> this.nbparc != null && nb_parc.isEmpty ? 'Ce champs est obligatoire' : null,
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
                                  hintText: 'Contact',
                                  isDense: true,
                                  prefixIcon: Padding(
                                      padding: EdgeInsetsDirectional.only(start: 12.0),
                                      child: Icon(Icons.phone), // myIcon is a 48px-wide widget.
                                  ),
                                 prefixText :  '+ 225 '
                                ),
                              ),

                        ),
                //  Padding(
                //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                //         child:SelectFormField(
                //                 type: SelectFormFieldType.dropdown, 
                //                 labelText: 'Pièce',
                //                 items: _document,
                //                 onChanged:(document)=>setState(() =>this.document = document.toString()),
                //                 onSaved: (document)=>setState(() =>this.document = document.toString()),
                //       )
                //   ),

                //   Padding(
                //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                //         child: TextFormField(
                //           initialValue: numdoc,
                //           onSaved : (numdoc)=>setState(() =>this.numdoc = numdoc),
                //           onChanged: (numdoc)=>setState(() =>this.numdoc = numdoc),
                //           // validator: (localite)=> this.localite != null && localite.isEmpty ? 'Ce champs est obligatoire' : null,
                //           decoration: InputDecoration(
                //             labelText: 'Numéro de pièce',
                //             hintText: 'Numéro de pièce',
                //             isDense: true
                //           ),
                //         ),

                //   ),
                
              ]
            ),
          ),
        ),
      ),
    ),

  );

    Widget buildButtonSave(){
    final isFormValid = code.isNotEmpty && nom.isNotEmpty ;

   
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
        if(code.isNotEmpty && nom.isNotEmpty ){
          addProducteur();
          Navigator.pushReplacementNamed(context, '/producteurs');
        }
        
      }

  }


  Future addProducteur() async {

    final producteur = widget.product.copy(
      code: code.toUpperCase(),
      nom: nom.toUpperCase(),
      nb_enfant:int.parse(nb_Enfant) ,
      nb_epouse: 0,
      nb_parcelle:int.parse(nb_parc) ,
      genre: genre,
      dob:  dob == null? DateTime.parse('1900-12-31T05:00:00.000') : dob,
      localite: localite.toUpperCase(),
      enfant_scolarise:int.parse(nbscolariser) ,
      contacts: contact,
      type_producteur: "MEMBRE",
      type_document: document,
      num_document: numdoc.toUpperCase(),
      cooperative_id: widget.product.cooperative_id,
      section_id: int.parse(sec),
      origine_id: 1,
      image: "logo_homme.jpeg",
      is_active : 1,
      user_id: widget.product.user_id,
      synchro: "NON",
      created_at : DateTime.now(),
      updated_at : DateTime.now(),

    );

    await dbHelper.updateProd(producteur);

  }
   
}