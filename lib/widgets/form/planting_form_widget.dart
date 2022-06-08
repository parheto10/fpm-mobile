// ignore_for_file: non_constant_identifier_names
import 'dart:ui';
import 'package:argon_flutter/controller/databasehelper.dart';
import 'package:argon_flutter/controller/querySql.dart';
import 'package:argon_flutter/models/campagne.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';


class PlantingFormWidget extends StatelessWidget {
   DatabaseHelper con =  new DatabaseHelper();

    // ignore: deprecated_member_use
    var campages =  List<DropdownMenuItem>() ;

    // ignore: deprecated_member_use
    var  projets = List<DropdownMenuItem>() ;
    // final String projet;
    final String plantExist;
    final String codeparcelle;
    final DateTime date;
    final  String selectValue;
    final  String selectValue2;
    final ValueChanged<dynamic> onChangedcampagne;
    final ValueChanged<dynamic> onChangedprojet;
    final ValueChanged<String> onChangedplantExist;
    final ValueChanged<DateTime> onChangedateplanting;

   PlantingFormWidget({ 
     Key key, 
     this.campages, 
     this.date,
     this.projets, 
     this.plantExist, 
     this.codeparcelle, 
     this.onChangedcampagne, 
     this.onChangedprojet,
     this.onChangedplantExist, 
     this.selectValue,
     this.selectValue2,
     this.onChangedateplanting

      }) : super(key: key);




  @override
  Widget build(BuildContext context) 
      => Container(
      child: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [     
           ParcelleCode(),
           SizedBox(height: 10),
           Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
       SizedBox(height: 10),
                 Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, bottom: 5),
                        child:DateTimeFormField(
                              initialDate: date,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Date de planting *',
                              ),
                              mode: DateTimeFieldPickerMode.date,
                              autovalidateMode: AutovalidateMode.always,
                              // validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                              onDateSelected:onChangedateplanting,
                                // print(dob);
                             
                            ),

                  ),
      //  SizedBox(height: 0),
       Campagnes(),
        SizedBox(height: 10),
      //  Projets(),
      //  SizedBox(height: 10),
       PlantExistant(),
      Divider(
        height: 40.0,
        thickness: 1.5,
        indent: 32.0,
        endIndent: 32.0,
      ),
      SizedBox(height: 5),
    ],
  )

          ],
        ),
      ),
    );


  Widget ParcelleCode() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'CODE PARCELLE : ${codeparcelle}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 5),
    ],
  );

  Widget Campagnes() => DropdownButtonFormField<dynamic>(
      value: selectValue,
      isDense: true,
      items:campages,
      hint: Text("Campagne * "),
      onChanged:onChangedcampagne,  
      validator: (selectValue) =>this.selectValue != null && selectValue.isEmpty ? 'Ce champs est obligatoire' : null,              
  );
     
  Widget Projets() => DropdownButtonFormField<dynamic>(
      value: selectValue2,
      isDense: true,
      items:projets,
      hint: Text("Projet"),
      onChanged:onChangedprojet,
      validator: (projets) =>projets != null && projets.isEmpty ? 'Ce champs est obligatoire' : null,
                
  );
     

   Widget PlantExistant() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Plant Existant',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      SizedBox(height: 5),
      Container(
        padding: EdgeInsets.only(left: 1.0),
        width: 200.0,
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
            initialValue: '0',
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
            // validator: (plantExist) => 
            //     plantExist != null && plantExist.isEmpty ? 'Ce champs est obligatoire' : null,
              onChanged: onChangedplantExist,

          )
      )
    ],
  );


  // Widget DatePlant() => Column(
  //     Text(
  //       'Date Planting',
  //       style: TextStyle(
  //         color: Colors.black,
  //         fontSize: 15,
  //       ),
  //     ),
  //     SizedBox(height: 10),
  //     Container(
  //       padding: EdgeInsets.only(left: 1.0),
  //       width: 200.0,
  //       alignment: Alignment.centerLeft,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //         boxShadow: [
  //           BoxShadow(
  //             blurRadius: 6,
  //             offset: Offset(0,2)
  //           )
  //         ]
  //       ),
  //       height: 50,
  //       child:  
  //         TextFormField(
  //           // maxLines: 2,
  //           // initialValue: datePlanting,
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 15,
              
  //           ),

  //           decoration: InputDecoration(
  //             contentPadding:EdgeInsets.only(left: 9),                      
  //             hintText: '${this.datePlanting}',
  //             hintStyle: TextStyle(
  //             color: Colors.black,
  //             fontSize: 15.0,
  //             fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           onTap: () async {
  //             FocusScope.of(context).requestFocus(FocusNode());
  //             DateTime pickedDate = await showDatePicker(
  //               context: context,
  //               initialDate: DateTime.now(),
  //               firstDate: DateTime(DateTime.now().year),
  //               lastDate: DateTime(DateTime.now().year + 20),
  //             );
  //             if(pickedDate != null ){
  //                     print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
  //                     String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); 
  //                     print(formattedDate); 
  //                     datePlanting = formattedDate; 
                      
  //                 }else{
  //                     print("Date is not selected");
  //                 }
  //           },
  //           validator: (codeCertificat) => 
  //               datePlanting != null && datePlanting.isEmpty ? 'Ce champs est obligatoire' : null,
  //         onChanged: onChangedDatePlanting,

  //         )
  //     ),
  // );




}