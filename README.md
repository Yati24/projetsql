# Projet sql


## choix de conception

* **Modélisation des données en Mérise :** Modélisation MLD MCD MPD.
* **Tables claires :** Répartition simple en 4 tables principales
* **Tables de liaison :** Création de 3 tables de liaison pour gérer les relations

* **Sécurité :** 3 types de roles différents pour limiter les problèmes de sécurité au niveau des droits

---

## logique des requêtes

* **Jointure JOIN** 
* **Jointure LEFT JOIN** 
* **Agrégation GROUP BY** 
* **Filtrage HAVING & CASE**

---

## instructions d'exécution

### prérequis :
* Un serveur PostgreSQL 
* Un serveur MongoDB

### base relationnelle postgre
1. créer une base de données `shrek_school` et se connecter.
2. exécuter le script `01_creation_et_donnees.sql`
3. exécutez le script `02_requetes_exploitation.sql`
4. exécutez le script `03_requetes_analyse.sql` 


### base secondaire mongodb
1. se connecter à mongodb 
2. ouvrir le fichier `05_nosql.mongodb.js`
3. exécutez le script. `nosql.mongodb.sql`# projetsql
