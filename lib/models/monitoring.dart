import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String tableMonitoring = 'cooperatives_monitoring';
final String tabledetailMonitoring = 'cooperatives_detailmonitoring';
final String tableobservationMonitoring = 'cooperatives_monitoring_observation';
final String tableMonitoringespece = 'cooperatives_monitoringespece';


////MONITORING START///
class MonitoringField {
  static final List<String> values = [
    code,
    date,
    planting_id,
    taux_mortalite,
    taux_vitalite,
    mature_global,
    mort_global,
    user_id 
  ];

  static final String code = 'code';
  static final String date = 'date';
  static final String planting_id = 'planting_id';
  static final String taux_mortalite = 'taux_mortalite';
  static final String taux_vitalite = 'taux_vitalite';
  static final String mature_global = 'mature_global';
  static final String mort_global = 'mort_global';
  static final String user_id = 'user_id';


}

class Monitoring {
  final String code;
  final DateTime date;
  final String planting_id;
  final String taux_mortalite;
  final String taux_vitalite;
  final int mature_global;
  final int mort_global;
  final int user_id;

  Monitoring({
    this.code, 
    this.date, 
    this.planting_id, 
    this.taux_mortalite, 
    this.taux_vitalite, 
    this.mature_global, 
    this.mort_global,
    this.user_id
  });

  Monitoring copy({
    String code,
    DateTime date,
    String planting_id,
    String taux_mortalite,
    String taux_vitalite,
    int mature_global,
    int mort_global,
    int user_id,

  }) => 
  Monitoring(
    code: code ?? this.code,
    date: date ?? this.date,
    planting_id: planting_id ?? this.planting_id,
    taux_vitalite: taux_vitalite ?? this.taux_vitalite,
    taux_mortalite: taux_mortalite ?? this.taux_mortalite,
    mature_global: mature_global ?? this.mature_global,
    mort_global: mort_global ?? this.mort_global,
    user_id: user_id ?? this.user_id
  );

  static Monitoring fromJson(Map<String, Object>json ) => Monitoring(
      code: json[MonitoringField.code] as String,
      date: json[MonitoringField.date] != null ? DateTime.parse(json[MonitoringField.date] as String) : null,
      taux_vitalite: json[MonitoringField.taux_vitalite].toString() as String,
      planting_id: json[MonitoringField.planting_id] as String,
      taux_mortalite: json[MonitoringField.taux_mortalite].toString() as String,
      mature_global: json[MonitoringField.mature_global] as int,
      mort_global: json[MonitoringField.mort_global] as int,
      user_id: json[MonitoringField.user_id] as int,
  );

  Map<String, Object>toJson() => {
    MonitoringField.code : code,
    MonitoringField.date : date.toIso8601String(),
    MonitoringField.planting_id : planting_id,
    MonitoringField.taux_vitalite : taux_vitalite,
    MonitoringField.taux_mortalite : taux_mortalite,
    MonitoringField.mature_global : mature_global,
    MonitoringField.mort_global : mort_global,
    MonitoringField.user_id : user_id,
  };



}


//// MONITORING END////


class DetailMonitoringField {
  static final List<String> values = [
    code, 
    monitoring_id
  ];

  static final String code = 'code';
  static final String monitoring_id = 'monitoring_id';

}

class DetailMonitoring {
  final String code;
  final String monitoring_id;

  DetailMonitoring({
    this.code, 
    this.monitoring_id,
  });


  DetailMonitoring copy({
    int id,
    String monitoring_id
  }) =>

  DetailMonitoring(
    code: code ?? this.code,
    monitoring_id: monitoring_id ?? this.monitoring_id
  );

   

    static DetailMonitoring fromJson(Map<String, Object>json ) => DetailMonitoring(
      code: json[DetailMonitoringField.code] as String,
      monitoring_id: json[DetailMonitoringField.monitoring_id]  as String ,

  );
  Map<String, Object>toJson() => {
    DetailMonitoringField.code : code,
    DetailMonitoringField.monitoring_id : monitoring_id
  };


}

// END DETAILMONITORING////


class ObservationMonitoringField {
  static final List<String> values = [
    id,
    monitoring_id,
    obsmonitoring_id
  ];

  static final String id = 'id';
  static final String monitoring_id = 'monitoring_id';
  static final String obsmonitoring_id = 'obsmonitoring_id';
}

class ObservationMonitoring{
  final int id;
  final String monitoring_id;
  final int obsmonitoring_id;

  ObservationMonitoring({
    this.id, 
    this.monitoring_id, 
    this.obsmonitoring_id, 
  });

  ObservationMonitoring copy({
    int id,
    String monitoring_id,
    int obsmonitoring_id
  }) =>
  ObservationMonitoring(
    id: id ?? this.id,
    monitoring_id: monitoring_id ?? this.monitoring_id,
    obsmonitoring_id: obsmonitoring_id ?? this.obsmonitoring_id
  );


  Map<String, Object> toJson() => {
    ObservationMonitoringField.id : id,
    ObservationMonitoringField.monitoring_id : monitoring_id,
    ObservationMonitoringField.obsmonitoring_id : obsmonitoring_id
  };




}

// END OBSERVATIONMONITORING////

class MonitoringEspeceField {
  static final List<String> values = [
    code,
    mort,
    taux_mortalite,
    detailmonitoring_id,
    detailplanting_id,
    espece_id,
    detailplantingremplacement_id
  ];

  static final String code = 'code';
  static final String mort = 'mort';
  static final String taux_mortalite = 'taux_mortalite';
  static final String detailmonitoring_id = 'detailmonitoring_id';
  static final String detailplanting_id = 'detailplanting_id';
  static final String espece_id = 'espece_id';
  static final String detailplantingremplacement_id = 'detailplantingremplacement_id';

}

class MonitoringEspece {
  final String code;
  final String mort;
  final String taux_mortalite;
  final String detailmonitoring_id;
  final String detailplanting_id;
  final int espece_id;
  final String detailplantingremplacement_id;

  MonitoringEspece({
    this.code, 
    this.mort, 
    this.taux_mortalite, 
    this.detailmonitoring_id, 
    this.detailplanting_id, 
    this.espece_id, 
    this.detailplantingremplacement_id, 
  });


  MonitoringEspece copy({
    String code,
    int mort,
    String taux_mortalite,
    String detailmonitoring_id,
    String detailplanting_id,
    int espece_id,
    String detailplantingremplacement_id
  }) => 
  MonitoringEspece(
    code: code ?? this.code,
    mort: mort ?? this.mort,
    taux_mortalite: taux_mortalite ?? this.taux_mortalite,
    espece_id: espece_id ?? this.espece_id,
    detailmonitoring_id: detailmonitoring_id ?? this.detailmonitoring_id,
    detailplanting_id: detailplanting_id ?? this.detailplanting_id,
    detailplantingremplacement_id: detailplantingremplacement_id ?? this.detailplantingremplacement_id
  );


  Map<String, Object>toJson() => {
    MonitoringEspeceField.code: code,
    MonitoringEspeceField.detailmonitoring_id : detailmonitoring_id,
    MonitoringEspeceField.detailplanting_id : detailplanting_id,
    MonitoringEspeceField.espece_id : espece_id,
    MonitoringEspeceField.mort : mort,
    MonitoringEspeceField.taux_mortalite : taux_mortalite,
    MonitoringEspeceField.detailplantingremplacement_id : detailplantingremplacement_id
  };

}

