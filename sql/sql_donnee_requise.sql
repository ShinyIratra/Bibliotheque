-- Statut
INSERT INTO Statut VALUES (1, 'Disponible'), (2, 'Emprunte'), (3, 'Reserve'), (4, 'Non Disponible');

-- Configuration_Profil
INSERT INTO Configuration_Profil VALUES 
   (1, 5, 2, 3), 
   (2, 10, 3, 5), 
   (3, 100, 100, 100),
   (4, 2, 1, 1),
   (5, 7, 2, 4);

-- Profil
INSERT INTO Profil VALUES 
   (1, 'Etudiant', 1), 
   (2, 'Enseignant', 2), 
   (3, 'Bibliothecaire', 3),
   (4, 'Visiteur', 4),
   (5, 'Chercheur', 5);

-- Categorie_Pret
INSERT INTO Categorie_Pret VALUES 
   (1, 'Emportable'), 
   (2, 'Non Emportable');

-- Type_Penalite
INSERT INTO Type_Penalite VALUES 
   (1, 'Retard'), 
   (2, 'Livre perdu'),
   (3, 'Dégradation'),
   (4, 'Non-respect du règlement');

-- Categorie
INSERT INTO Categorie VALUES 
   (1, 'Roman', 18), 
   (2, 'Science-fiction', 16), 
   (3, 'Essai', 21),
   (4, 'Bande dessinée', 12),
   (5, 'Documentaire', 13),
   (6, 'Jeunesse', 8);

-- Type_Pret
INSERT INTO Type_Pret VALUES 
   (1, 'Sur Place'), 
   (2, 'Emporte');

-- Configuration
INSERT INTO Configuration (nbr_retard, nbr_mois) VALUES 
   (2, 24);

-- Adherent (à insérer avant Inscription, Reservation, etc.)
INSERT INTO Adherent (id_adherent, nom, identifiant, password, date_naissance, id_profil) VALUES
(1, 'Jean Dupont', 'user1', 'user1', '2000-05-12', 1),
(2, 'Marie Claire', 'user2', 'user2', '1985-02-03', 1),
(3, 'Jacques Martin', 'user3', 'user3', '1990-10-10', 3),
(4, 'Emma Zola', 'user4', 'user4', '1990-10-10', 1),
(5, 'Albert Nobel', 'user5', 'user5', '1990-10-10', 1);