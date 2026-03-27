-- partie 4

-- Nombre total d'étudiants, de formations et de modules
SELECT 
    (SELECT COUNT(*) FROM ETUDIANT) AS total_etudiants,
    (SELECT COUNT(*) FROM FORMATION) AS total_formations,
    (SELECT COUNT(*) FROM MODULE) AS total_modules;

-- Moyenne générale des notes par formation
SELECT f.nom_formation, ROUND(AVG(ev.note_obtenue), 2) AS moyenne_generale
FROM FORMATION f
JOIN MODULE m ON f.id_formation = m.id_formation
JOIN EVALUATION ev ON m.id_module = ev.id_module
GROUP BY f.id_formation, f.nom_formation;

-- Répartition des étudiants par statut (réussite / échec / en cours)
SELECT statut, COUNT(id_etudiant) AS nombre_etudiants
FROM ETUDIANT
GROUP BY statut;



-- Moyenne des notes par formation et par module
SELECT f.nom_formation, m.nom_module, ROUND(AVG(ev.note_obtenue), 2) AS moyenne_module
FROM FORMATION f
JOIN MODULE m ON f.id_formation = m.id_formation
LEFT JOIN EVALUATION ev ON m.id_module = ev.id_module
GROUP BY f.id_formation, f.nom_formation, m.id_module, m.nom_module
ORDER BY f.nom_formation, m.nom_module;

-- Nombre d'étudiants par formation et par année
SELECT f.nom_formation, EXTRACT(YEAR FROM i.date_inscription) AS annee, COUNT(i.id_etudiant) AS nombre_etudiants
FROM FORMATION f
JOIN INSCRIPTION i ON f.id_formation = i.id_formation
GROUP BY f.id_formation, f.nom_formation, EXTRACT(YEAR FROM i.date_inscription)
ORDER BY annee, f.nom_formation;

-- Évolution du nombre d'inscriptions au fil du temps (par mois et année)
SELECT TO_CHAR(date_inscription, 'YYYY-MM') AS mois_annee, COUNT(id_etudiant) AS nb_inscriptions
FROM INSCRIPTION
GROUP BY mois_annee
ORDER BY mois_annee;



-- Classer les étudiants par catégorie de résultat (ex: excellent, moyen, insuffisant)
SELECT e.prenom, e.nom, ROUND(AVG(ev.note_obtenue), 2) AS moyenne,
CASE 
    WHEN AVG(ev.note_obtenue) >= 16 THEN 'Excellent'
    WHEN AVG(ev.note_obtenue) >= 10 THEN 'Moyen'
    ELSE 'Insuffisant'
END AS categorie_resultat
FROM ETUDIANT e
JOIN EVALUATION ev ON e.id_etudiant = ev.id_etudiant
GROUP BY e.id_etudiant, e.prenom, e.nom
ORDER BY moyenne DESC;

-- Identifier les formations dont la moyenne est inférieure à un seuil défini (seuil fixé à 12/20)
SELECT f.nom_formation, ROUND(AVG(ev.note_obtenue), 2) AS moyenne_formation
FROM FORMATION f
JOIN MODULE m ON f.id_formation = m.id_formation
JOIN EVALUATION ev ON m.id_module = ev.id_module
GROUP BY f.id_formation, f.nom_formation
HAVING AVG(ev.note_obtenue) < 12;

-- Mettre en évidence les modules "à risque" (taux d'échec élevé : plus de 30% de notes sous la moyenne)
SELECT m.nom_module, 
       COUNT(ev.id_etudiant) AS total_evaluations,
       SUM(CASE WHEN ev.note_obtenue < 10 THEN 1 ELSE 0 END) AS nombre_echecs,
       ROUND((SUM(CASE WHEN ev.note_obtenue < 10 THEN 1 ELSE 0 END) * 100.0 / COUNT(ev.id_etudiant)), 2) AS taux_echec_pourcentage
FROM MODULE m
JOIN EVALUATION ev ON m.id_module = ev.id_module
GROUP BY m.id_module, m.nom_module
HAVING (SUM(CASE WHEN ev.note_obtenue < 10 THEN 1 ELSE 0 END) * 100.0 / COUNT(ev.id_etudiant)) > 30;