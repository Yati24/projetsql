use('shrek_school_nosql');

//commmentaire
db.commentaires.insertOne({
  id_etudiant: 1,
  nom_etudiant: "L'Âne",
  auteur: "Shrek-Grogneur",
  date_commentaire: new Date("2023-10-01T08:15:00Z"),
  texte: "L'étudiant chante constamment dans les couloirs. J'ai dû menacer d'en faire du saucisson."
});

//evaluation libre
db.evaluations_libres.insertOne({
  id_etudiant: 2,
  nom_etudiant: "Pinocchio",
  id_module: 3,
  intervenant: "Shrek-Potté",
  date_evaluation: new Date("2023-11-16T10:30:00Z"),
  contenu: {
    points_forts: "A un certain potentiel comique.",
    points_faibles: "Son nez s'allonge quand il dit qu'il a révisé.",
    recommandation: "Doit travailler son regard larmoyant, c'est encore trop artificiel."
  }
});

//log
db.logs.insertOne({
  timestamp: new Date(),
  niveau_alerte: "ERROR",
  composant: "Serveur_Authentification",
  message: "Tentative de connexion échouée (mot de passe incorrect)",
  adresse_ip: "10.0.0.5",
  utilisateur_tente: "lord_farquaad_admin"
});

//historique
db.historiques.insertOne({
  date_action: new Date(),
  action: "MODIFICATION_NOTE",
  utilisateur: "direction_shrek",
  details: {
    table_impactee: "EVALUATION",
    id_etudiant: 1,
    id_module: 1,
    ancienne_note: 8.50,
    nouvelle_note: 12.00,
    justification: "L'Âne a pleuré pendant 3 heures, j'ai craqué."
  }
});
