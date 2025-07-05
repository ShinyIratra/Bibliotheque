\c postgres
drop database bibliotheque;
create database bibliotheque; 
\c bibliotheque

CREATE TABLE Statut(
   id_statut SERIAL,
   nom VARCHAR(100)  NOT NULL,
   PRIMARY KEY(id_statut)
);

-- Statut
INSERT INTO Statut VALUES (1, 'Disponible'), (2, 'Emprunte'), (3, 'Reserve'), (4, 'Non Disponible');

CREATE TABLE Configuration_Profil(
   id_configuration_profil SERIAL,
   quota INTEGER NOT NULL,
   nbr_prolongement INTEGER NOT NULL,
   quota_reservation INTEGER,
   PRIMARY KEY(id_configuration_profil)
);

CREATE TABLE Profil(
   id_profil SERIAL,
   nom VARCHAR(100)  NOT NULL,
   id_configuration_profil INTEGER NOT NULL,
   PRIMARY KEY(id_profil),
   FOREIGN KEY(id_configuration_profil) REFERENCES Configuration_Profil(id_configuration_profil)
);

CREATE TABLE Categorie_Pret(
   id_categorie_pret SERIAL,
   nom VARCHAR(100)  NOT NULL,
   PRIMARY KEY(id_categorie_pret)
);

CREATE TABLE Type_Penalite(
   id_type_penalite INTEGER,
   nom VARCHAR(100) ,
   PRIMARY KEY(id_type_penalite)
);

CREATE TABLE Categorie(
   id_categorie SERIAL,
   nom VARCHAR(50)  NOT NULL,
   restriction INTEGER NOT NULL,
   PRIMARY KEY(id_categorie)
);

CREATE TABLE Type_Pret(
   id_type_pret SERIAL,
   nom VARCHAR(100)  NOT NULL,
   PRIMARY KEY(id_type_pret)
);

CREATE TABLE Configuration(
   id_configuration SERIAL,
   nbr_retard INTEGER NOT NULL,
   nbr_mois INTEGER NOT NULL,
   PRIMARY KEY(id_configuration)
);

CREATE TABLE Livre(
   id_livre SERIAL,
   titre VARCHAR(100)  NOT NULL,
   id_categorie INTEGER,
   id_categorie_pret INTEGER NOT NULL,
   PRIMARY KEY(id_livre),
   FOREIGN KEY(id_categorie) REFERENCES Categorie(id_categorie),
   FOREIGN KEY(id_categorie_pret) REFERENCES Categorie_Pret(id_categorie_pret)
);

CREATE TABLE Exemplaire(
   id_exemplaire SERIAL,
   Reference VARCHAR(100)  NOT NULL,
   id_livre INTEGER NOT NULL,
   PRIMARY KEY(id_exemplaire),
   FOREIGN KEY(id_livre) REFERENCES Livre(id_livre)
);

CREATE TABLE Statut_Exemplaire(
   id_status_exemplaire SERIAL,
   date_ajout TIMESTAMP NOT NULL,
   id_exemplaire INTEGER NOT NULL,
   id_statut INTEGER NOT NULL,
   PRIMARY KEY(id_status_exemplaire),
   FOREIGN KEY(id_exemplaire) REFERENCES Exemplaire(id_exemplaire),
   FOREIGN KEY(id_statut) REFERENCES Statut(id_statut)
);

CREATE TABLE Adherent(
   id_adherent SERIAL,
   nom VARCHAR(100)  NOT NULL,
   identifiant VARCHAR(100)  NOT NULL,
   password VARCHAR(50)  NOT NULL,
   date_naissance DATE NOT NULL,
   id_profil INTEGER NOT NULL,
   PRIMARY KEY(id_adherent),
   UNIQUE(identifiant),
   FOREIGN KEY(id_profil) REFERENCES Profil(id_profil)
);

CREATE TABLE Reservation(
   id_reservation SERIAL,
   date_reservation TIMESTAMP NOT NULL,
   date_reserver TIMESTAMP NOT NULL,
   id_exemplaire INTEGER NOT NULL,
   id_adherent INTEGER NOT NULL,
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_exemplaire) REFERENCES Exemplaire(id_exemplaire),
   FOREIGN KEY(id_adherent) REFERENCES Adherent(id_adherent)
);

CREATE TABLE Penalite(
   id_penalite SERIAL,
   justificatif TEXT,
   date_penalite TIMESTAMP,
   id_type_penalite INTEGER NOT NULL,
   id_adherent INTEGER NOT NULL,
   PRIMARY KEY(id_penalite),
   FOREIGN KEY(id_type_penalite) REFERENCES Type_Penalite(id_type_penalite),
   FOREIGN KEY(id_adherent) REFERENCES Adherent(id_adherent)
);


CREATE TABLE Inscription(
   id SERIAL,
   date_debut TIMESTAMP NOT NULL,
   date_fin TIMESTAMP NOT NULL,
   id_adherent INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_adherent) REFERENCES Adherent(id_adherent)
);

CREATE TABLE Blacklisting(
   id_blacklisting SERIAL,
   date_debut TIMESTAMP,
   date_fin TIMESTAMP,
   id_adherent INTEGER NOT NULL,
   PRIMARY KEY(id_blacklisting),
   FOREIGN KEY(id_adherent) REFERENCES Adherent(id_adherent)
);

CREATE TABLE Pret(
   id_pret SERIAL,
   date_pret TIMESTAMP NOT NULL,
   date_retour TIMESTAMP NOT NULL,
   id_type_pret INTEGER NOT NULL,
   id_exemplaire INTEGER NOT NULL,
   id_adherent INTEGER NOT NULL,
   PRIMARY KEY(id_pret),
   FOREIGN KEY(id_type_pret) REFERENCES Type_Pret(id_type_pret),
   FOREIGN KEY(id_exemplaire) REFERENCES Exemplaire(id_exemplaire),
   FOREIGN KEY(id_adherent) REFERENCES Adherent(id_adherent)
);

CREATE TABLE Prolongement(
   id_prolongement SERIAL,
   date_retour TIMESTAMP NOT NULL,
   id_pret INTEGER NOT NULL,
   PRIMARY KEY(id_prolongement),
   FOREIGN KEY(id_pret) REFERENCES Pret(id_pret)
);

CREATE TABLE Retour_Pret(
   id_retour_pret SERIAL,
   date_retourne TIMESTAMP NOT NULL,
   id_pret INTEGER NOT NULL,
   PRIMARY KEY(id_retour_pret),
   FOREIGN KEY(id_pret) REFERENCES Pret(id_pret)
);

CREATE TABLE Jour_Ferie(
   id_ferie SERIAL,
   date_ferie DATE NOT NULL,
   PRIMARY KEY(id_ferie)
);

CREATE TABLE Note(
   id_note SERIAL,
   note SMALLINT NOT NULL,
   commentaire TEXT NOT NULL,
   id_adherent INTEGER NOT NULL,
   id_livre INTEGER NOT NULL,
   PRIMARY KEY(id_note),
   FOREIGN KEY(id_adherent) REFERENCES Adherent(id_adherent),
   FOREIGN KEY(id_livre) REFERENCES Livre(id_livre)
);