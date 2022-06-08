class Campagne {

  int id;
  String titre;
  String mois_debut;
  int annee_debut;
  String mois_fin;
  int annee_fin;

  Campagne({
    this.id,
    this.annee_debut,
    this.annee_fin,
    this.mois_debut,
    this.mois_fin,
    this.titre

  });


    factory Campagne.fromJson(Map<String, dynamic> obj){

    return Campagne(
      id: obj['id'],
       annee_debut: obj['annee_debut'], 
       annee_fin: obj['annee_fin'], 
       mois_debut : obj['mois_debut'], 
       mois_fin : obj['mois_fin'], 
       titre :obj['titre'],

       );
  }
  
}