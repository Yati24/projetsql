-- partie 3

-- Lister les étudiants inscrits à une formation donnée
SELECT e.prenom, e.nom, f.nom_formation
FROM ETUDIANT e
JOIN INSCRIPTION i ON e.id_etudiant = i.id_etudiant
JOIN FORMATION f ON i.id_formation = f.id_formation
WHERE f.nom_formation = 'Charisme Ogre Niveau 1';

-- Afficher le parcours d'un étudiant (formations, modules suivis)
SELECT e.prenom, f.nom_formation, m.nom_module
FROM ETUDIANT e
JOIN INSCRIPTION i ON e.id_etudiant = i.id_etudiant
JOIN FORMATION f ON i.id_formation = f.id_formation
JOIN MODULE m ON f.id_formation = m.id_formation
WHERE e.prenom = 'Fiona';

-- Identifier les étudiants n'ayant pas encore de note dans un module
SELECT e.prenom, e.nom, m.nom_module
FROM ETUDIANT e
JOIN INSCRIPTION i ON e.id_etudiant = i.id_etudiant
JOIN MODULE m ON i.id_formation = m.id_formation
LEFT JOIN EVALUATION ev ON e.id_etudiant = ev.id_etudiant AND m.id_module = ev.id_module
WHERE ev.note_obtenue IS NULL;

-- Afficher les étudiants en situation d'échec ou de réussite selon des critères définis par vous
SELECT e.prenom, e.nom, ROUND(AVG(ev.note_obtenue), 2) AS moyenne,
CASE 
    WHEN AVG(ev.note_obtenue) >= 10 THEN 'Réussite'
    ELSE 'Échec'
END AS situation_actuelle
FROM ETUDIANT e
JOIN EVALUATION ev ON e.id_etudiant = ev.id_etudiant
GROUP BY e.id_etudiant, e.prenom, e.nom;


-- Lister les modules composant une formation
SELECT f.nom_formation, m.nom_module, m.coefficient
FROM FORMATION f
JOIN MODULE m ON f.id_formation = m.id_formation
WHERE f.nom_formation = 'Séduction Féline Avancée';

-- Identifier les modules avec le plus grand nombre d'inscrits
SELECT m.nom_module, COUNT(i.id_etudiant) AS nombre_inscrits
FROM MODULE m
JOIN INSCRIPTION i ON m.id_formation = i.id_formation
GROUP BY m.id_module, m.nom_module
ORDER BY nombre_inscrits DESC;

-- Afficher les formations n'ayant aucun étudiant inscrit
SELECT f.nom_formation
FROM FORMATION f
LEFT JOIN INSCRIPTION i ON f.id_formation = i.id_formation
WHERE i.id_etudiant IS NULL;

-- Comparer la durée totale prévue d'une formation avec la durée réellement suivie
SELECT e.prenom, f.nom_formation, f.duree_prevue_heures AS duree_totale_prevue,
COUNT(ev.id_module) AS modules_deja_evalues
FROM ETUDIANT e
JOIN INSCRIPTION i ON e.id_etudiant = i.id_etudiant
JOIN FORMATION f ON i.id_formation = f.id_formation
LEFT JOIN EVALUATION ev ON e.id_etudiant = ev.id_etudiant
GROUP BY e.id_etudiant, e.prenom, f.nom_formation, f.duree_prevue_heures;


-- Lister les modules animés par un intervenant
SELECT i.prenom_intervenant, m.nom_module
FROM INTERVENANT i
JOIN ANIMATION a ON i.id_intervenant = a.id_intervenant
JOIN MODULE m ON a.id_module = m.id_module
WHERE i.prenom_intervenant = 'Shrek-Potté';

-- Identifier les intervenants ayant le plus de modules
SELECT i.prenom_intervenant, COUNT(a.id_module) AS nombre_de_modules
FROM INTERVENANT i
JOIN ANIMATION a ON i.id_intervenant = a.id_intervenant
GROUP BY i.id_intervenant, i.prenom_intervenant
ORDER BY nombre_de_modules DESC;

-- Repérer les modules sans intervenant affecté
SELECT m.nom_module
FROM MODULE m
LEFT JOIN ANIMATION a ON m.id_module = a.id_module
WHERE a.id_intervenant IS NULL;