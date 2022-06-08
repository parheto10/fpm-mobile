import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';


class ParcelFormWidget extends StatelessWidget {
  final String codeCertificat;
  // final String codeproducteur;
  final String longitude;
  final String latitude;
  final String superficie;
  final String anneeCertificat;
  final String anneeAcquisition;
  final String certification;
  final String culture;
  final String acquisition;
  final  String selectValue;
  final ValueChanged<String> onChangedcodeCertificat;
  final ValueChanged<String> onChangedlongitude;
  final ValueChanged<String> onChangedlatitude;
  final ValueChanged<String> onChangedsuperficie;
  final ValueChanged<String> onChangedanneeCertificat;
  final ValueChanged<String> onChangedanneeAcquisition;
  final ValueChanged<String> onChangedcertification;
  final ValueChanged<String> onChangedculture;
  final ValueChanged<String> onChangedacquisition;
  final ValueChanged<dynamic> onChangedprojet;

    // ignore: deprecated_member_use
    var  projets = List<DropdownMenuItem>() ;



 ParcelFormWidget({ 
   Key key, 
   this.codeCertificat, 
   this.longitude, 
   this.projets,
   this.latitude, 
   this.superficie, 
   this.anneeCertificat, 
   this.anneeAcquisition, 
   this.certification, 
   this.culture, 
   this.acquisition, 
  //  this.codeproducteur,
   this.onChangedcodeCertificat, 
   this.onChangedlongitude, 
   this.onChangedlatitude, 
   this.onChangedsuperficie, 
   this.onChangedanneeCertificat, 
   this.onChangedanneeAcquisition, 
   this.onChangedcertification, 
   this.onChangedculture, 
   this.onChangedacquisition, 
   this.selectValue, 
   this.onChangedprojet, 

   }) : super(key: key);

  //  _animals.map((String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Text(value),
  //                 );
  //     }).toList();

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
      'value': 'FAIRTRADE',
      'label': 'FAIRTRADE',
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
      'value': 'DON',
      'label': 'DON',
    },
    {
      'value': 'METEAGE',
      'label': 'METEAGE',
    },
      {
      'value': 'AUTRE',
      'label': 'AUTRE',
    },

  ];

  final List<Map<String, dynamic>> _annee = [
    {
      'value': '2010',
      'label': '2010',
    },
    {
      'value': '2011',
      'label': '2011',
    },
      {
      'value': '2012',
      'label': '2012',
    },
      {
      'value': '2013',
      'label': '2013',
    },
      {
      'value': '2014',
      'label': '2014',
    },
      {
      'value': '2015',
      'label': '2015',
    },
      {
      'value': '2016',
      'label': '2016',
    },
      {
      'value': '2017',
      'label': '2017',
    },
      {
      'value': '2018',
      'label': '2018',
    },
      {
      'value': '2019',
      'label': '2019',
    },
      {
      'value': '2020',
      'label': '2020',
    },
      {
      'value': '2021',
      'label': '2021',
    },
      {
      'value': '2022',
      'label': '2022',
    },

  ];

  @override
  Widget build(BuildContext context) 
    => SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ProducteurCode(),
            SizedBox(height: 8),
            Culture(),
            SizedBox(height: 10),
            Superficie(),
            SizedBox(height: 8),
            Certification(),
            SizedBox(height: 8),
            Anneecert(),
            SizedBox(height: 10),
            CodeCertification(),
            SizedBox(height: 10),
            Acquisition(),
            SizedBox(height: 10),
            Anneeacq(),
            SizedBox(height: 10),
            Projets()
            // Longitude(),
            // SizedBox(height: 10),
            // Latitude(),
            // SizedBox(height: 10),

           

          ],
        ),
      ),
    );

  // Widget ProducteurCode() => Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: <Widget>[
  //     Text(
  //       'CODE PRODUCTEUR : ${codeproducteur}',
  //       style: TextStyle(
  //         color: Colors.black,
  //         fontSize: 15,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     SizedBox(height: 5),

  //   ],
  // );
 
  Widget CodeCertification() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'CODE CERTIFICATION',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      SizedBox(height: 5),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 50,
        child:  
          TextFormField(
            maxLines: 2,
            initialValue: codeCertificat,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              
            ),

            decoration: InputDecoration(
              contentPadding:EdgeInsets.only(left: 9),                      
              // hintText: 'Code Producteur',
              hintStyle: TextStyle(
              color: Colors.black,
              ),
            ),
            // validator: (codeCertificat) =>  
            //     codeCertificat != null && codeCertificat.isEmpty ? 'Ce champs est obligatoire' : null,
          onChanged: onChangedcodeCertificat,

          )
      )
    ],
  );

   Widget Anneeacq() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Année acquisition',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      SizedBox(height: 5),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 50,
        child:  
          TextFormField(
            maxLines: 2,
            keyboardType : TextInputType.number,
            initialValue: anneeAcquisition,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              
            ),

            decoration: InputDecoration(
              contentPadding:EdgeInsets.only(left: 9),                      
              hintText: '',
              hintStyle: TextStyle(
              color: Colors.black,
              ),
            ),
            // validator: (anneeAcquisition) => 
            //     anneeAcquisition != null && anneeAcquisition.isEmpty ? 'Ce champs est obligatoire' : null,

            onChanged: onChangedanneeAcquisition,
          )
      )
    ],
  );

  Widget Anneecert() => Column( 
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Année certification',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      SizedBox(height: 5),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 50,
        child:  
          TextFormField(
            maxLines: 2,
            keyboardType : TextInputType.number,
            initialValue: anneeCertificat,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              
            ),

            decoration: InputDecoration(
              contentPadding:EdgeInsets.only(left: 9),                      
              // hintText: 'Code Producteur',
              hintStyle: TextStyle(
              color: Colors.black,
              ),
            ),
            // validator: (latitude) => 
            //     latitude != null && latitude.isEmpty ? 'Ce champs est obligatoire' : null,
              onChanged: onChangedanneeCertificat,

          )
      )
    ],
  );
  

   Widget Superficie() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Superficie',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      SizedBox(height: 5),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 50,
        child:  
          TextFormField(
            maxLines: 2,
            keyboardType : TextInputType.number,
            initialValue: superficie,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              
            ),

            decoration: InputDecoration(
              contentPadding:EdgeInsets.only(left: 9),                      
              // hintText: 'Code Producteur',
              hintStyle: TextStyle(
              color: Colors.black,
              ),
            ),
            validator: (superficie) => 
                superficie != null && superficie.isEmpty ? 'Ce champs est obligatoire' : null,
              onChanged: onChangedsuperficie,

          )
      )
    ],
  );

  Widget Culture() =>  SelectFormField(
                    type: SelectFormFieldType.dropdown, 
                    labelText: 'Culture',
                    items: _culture,
                    onChanged:onChangedculture,
                    onSaved: onChangedculture,
          );
  Widget Certification() =>  SelectFormField(
                    type: SelectFormFieldType.dropdown,
                    labelText: 'Certification',
                    items: _certification,
                    onChanged: onChangedcertification,
                    onSaved: onChangedcertification,
          );
  Widget Projets() => DropdownButtonFormField<dynamic>(
      value: selectValue,
      isDense: true,
      items:projets,
      hint: Text("Projet *"),
      onChanged:onChangedprojet,
      validator: (selectValue) =>selectValue != null && selectValue.isEmpty ? 'Ce champs est obligatoire' : null,
                
  );
  // Widget Anneecert() =>  SelectFormField(
  //                   type: SelectFormFieldType.dropdown,       
  //                   labelText: 'Annee certification',
  //                   items: _annee,
  //                   onChanged: onChangedanneeCertificat,
  //                   onSaved: onChangedanneeCertificat,
  //         );

  // Widget Anneeacq() =>  SelectFormField(
  //                   type: SelectFormFieldType.dropdown, 
  //                   labelText: 'Annee Acquisition',
  //                   items: _annee,
  //                   onChanged: onChangedanneeAcquisition,
  //                   onSaved: onChangedanneeAcquisition,
  //         );


  Widget Acquisition() =>  SelectFormField(
                    type: SelectFormFieldType.dropdown, 
                    labelText: 'Acquisition',
                    items: _acquisition,
                    onChanged: onChangedacquisition,
                    onSaved: onChangedacquisition,
          );
   
  
}