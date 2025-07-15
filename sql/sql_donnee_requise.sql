-- Statut
INSERT INTO Statut VALUES (1, 'Disponible'), (2, 'Emprunte'), (3, 'Reserve'), (4, 'Non Disponible');

-- Configuration_Profil
INSERT INTO Configuration_Profil VALUES 
   (1, 5, 2, 3), 
   (2, 10, 3, 5), 
   (3, 100, 100, 100);

-- Profil
INSERT INTO Profil VALUES 
   (1, 'Etudiant', 1), 
   (2, 'Enseignant', 2), 
   (3, 'Bibliothecaire', 3);

-- Categorie_Pret
INSERT INTO Categorie_Pret VALUES 
   (1, 'Emportable'), 
   (2, 'Non Emportable');

-- Type_Penalite
INSERT INTO Type_Penalite VALUES 
   (1, 'Retard'), 

-- Type_Pret
INSERT INTO Type_Pret VALUES 
   (1, 'Sur Place'), 
   (2, 'Emporte');

-- Configuration
INSERT INTO Configuration (nbr_retard, nbr_mois) VALUES 
   (2, 24);
