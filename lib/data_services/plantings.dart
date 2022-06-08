class Plantings {
  int id;
  String campagne;
  String parcelle;
  int nbPlantExitant;
  int plantRecus;
  int plantTotal;
  String projet;
  String date;

  Plantings(
      {this.id,
        this.campagne,
        this.parcelle,
        this.nbPlantExitant,
        this.plantRecus,
        this.plantTotal,
        this.projet,
        this.date});

  Plantings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campagne = json['campagne'];
    parcelle = json['parcelle'];
    nbPlantExitant = json['nb_plant_exitant'];
    plantRecus = json['plant_recus'];
    plantTotal = json['plant_total'];
    projet = json['projet'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['campagne'] = this.campagne;
    data['parcelle'] = this.parcelle;
    data['nb_plant_exitant'] = this.nbPlantExitant;
    data['plant_recus'] = this.plantRecus;
    data['plant_total'] = this.plantTotal;
    data['projet'] = this.projet;
    data['date'] = this.date;
    return data;
  }
}
