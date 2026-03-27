
CREATE ROLE role_admin;
CREATE ROLE role_intervenant;
CREATE ROLE role_etudiant;


CREATE USER direction_shrek WITH PASSWORD 'Oignons123';
GRANT role_admin TO direction_shrek;


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_admin;


GRANT SELECT ON ETUDIANT, FORMATION, MODULE, INSCRIPTION TO role_intervenant;

GRANT SELECT, INSERT, UPDATE ON EVALUATION TO role_intervenant;

GRANT SELECT ON FORMATION, MODULE TO role_etudiant;
