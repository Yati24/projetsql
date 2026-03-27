-- creation des tables de la bdd

CREATE TABLE ETUDIANT (
    id_etudiant SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    statut VARCHAR(20) DEFAULT 'en cours' CHECK (statut IN ('en cours', 'réussite', 'échec'))
);

CREATE TABLE FORMATION (
    id_formation SERIAL PRIMARY KEY,
    nom_formation VARCHAR(150) NOT NULL,
    duree_prevue_heures INTEGER NOT NULL
);

CREATE TABLE MODULE (
    id_module SERIAL PRIMARY KEY,
    nom_module VARCHAR(150) NOT NULL,
    coefficient INTEGER DEFAULT 1,
    id_formation INTEGER NOT NULL,
    FOREIGN KEY (id_formation) REFERENCES FORMATION(id_formation) ON DELETE CASCADE
);

CREATE TABLE INTERVENANT (
    id_intervenant SERIAL PRIMARY KEY,
    nom_intervenant VARCHAR(100) NOT NULL,
    prenom_intervenant VARCHAR(100) NOT NULL,
    email_intervenant VARCHAR(150) UNIQUE NOT NULL,
    specialite VARCHAR(150)
);

CREATE TABLE INSCRIPTION (
    id_etudiant INTEGER NOT NULL,
    id_formation INTEGER NOT NULL,
    date_inscription DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_etudiant, id_formation),
    FOREIGN KEY (id_etudiant) REFERENCES ETUDIANT(id_etudiant) ON DELETE CASCADE,
    FOREIGN KEY (id_formation) REFERENCES FORMATION(id_formation) ON DELETE CASCADE
);

CREATE TABLE ANIMATION (
    id_intervenant INTEGER NOT NULL,
    id_module INTEGER NOT NULL,
    PRIMARY KEY (id_intervenant, id_module),
    FOREIGN KEY (id_intervenant) REFERENCES INTERVENANT(id_intervenant) ON DELETE CASCADE,
    FOREIGN KEY (id_module) REFERENCES MODULE(id_module) ON DELETE CASCADE
);

CREATE TABLE EVALUATION (
    id_etudiant INTEGER NOT NULL,
    id_module INTEGER NOT NULL,
    note_obtenue NUMERIC(4,2) CHECK (note_obtenue >= 0 AND note_obtenue <= 20),
    date_evaluation DATE NOT NULL,
    PRIMARY KEY (id_etudiant, id_module),
    FOREIGN KEY (id_etudiant) REFERENCES ETUDIANT(id_etudiant) ON DELETE CASCADE,
    FOREIGN KEY (id_module) REFERENCES MODULE(id_module) ON DELETE CASCADE
);

-- inserttion des données dans la base

INSERT INTO FORMATION (nom_formation, duree_prevue_heures) VALUES
('Charisme Ogre Niveau 1', 50),
('Séduction Féline Avancée', 30),
('Gouvernance et Dictature', 40);

INSERT INTO MODULE (nom_module, coefficient, id_formation) VALUES
('Rugissement basique', 2, 1),
('Hygiène de la boue', 1, 1),
('Regard larmoyant', 3, 2),
('Bottes et chapeau : le style', 1, 2),
('Intimidation par la taille', 2, 3);

INSERT INTO INTERVENANT (nom_intervenant, prenom_intervenant, email_intervenant, specialite) VALUES
('Ogre', 'Shrek-Grogneur', 'grogneur@marais.com', 'Territoire et survie'),
('Chat', 'Shrek-Potté', 'potte@shrekschool.com', 'Charme et escrime'),
('Farquaad', 'Shrek-Dictateur', 'dictateur@duloc.com', 'Management toxique');

INSERT INTO ETUDIANT (nom, prenom, email, statut) VALUES
('Bavard', 'L''Âne', 'ane@waffles.com', 'en cours'),
('De Bois', 'Pinocchio', 'pino@mensonge.com', 'échec'),
('Biscuit', 'Ti', 'tibiscuit@glaçage.com', 'réussite'),
('Ogre', 'Fiona', 'fiona@marais.com', 'réussite'),
('Volante', 'Dragonne', 'dragonne@feu.com', 'en cours');

INSERT INTO INSCRIPTION (id_etudiant, id_formation, date_inscription) VALUES
(1, 1, '2023-09-01'), (4, 1, '2023-09-01'), (2, 2, '2023-09-15'), (3, 2, '2023-09-15'), (5, 2, '2023-09-20');

INSERT INTO ANIMATION (id_intervenant, id_module) VALUES
(1, 1), (1, 2), (2, 3), (2, 4);

INSERT INTO EVALUATION (id_etudiant, id_module, note_obtenue, date_evaluation) VALUES
(1, 1, 8.50, '2023-11-10'), (4, 1, 19.00, '2023-11-10'), (4, 2, 16.50, '2023-12-05'), (2, 3, 4.00, '2023-11-15'), (3, 3, 14.00, '2023-11-15');