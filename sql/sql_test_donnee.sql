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
   (5, 'Documentaire', 0),
   (6, 'Jeunesse', 8);

-- Type_Pret
INSERT INTO Type_Pret VALUES 
   (1, 'Sur Place'), 
   (2, 'Emporte');

-- Configuration
INSERT INTO Configuration (nbr_retard, nbr_mois) VALUES 
   (3, 12), 
   (5, 6),
   (2, 24);
   
--- Configuration Requise ----


INSERT INTO Livre VALUES 
   (1, 'Le Petit Prince', 1, 1),
   (2, '1984', 2, 1),
   (3, 'L Etranger', 1, 1),
   (4, 'Brave New World', 2, 2),
   (5, 'Tintin au Tibet', 4, 1),
   (6, 'Python pour les nuls', 5, 1),
   (7, 'Le Monde de Sophie', 3, 1),
   (8, 'Astérix Gladiateur', 4, 1),
   (9, 'Le Livre de la Jungle', 6, 1),
   (10, 'Voyage au centre de la Terre', 2, 1);

-- Exemplaire
INSERT INTO Exemplaire VALUES 
   (1, 'LP-001', 1),
   (2, 'N84-001', 2),
   (3, 'ET-001', 3),
   (4, 'BNW-001', 4),
   (5, 'TT-001', 5),
   (6, 'PY-001', 6),
   (7, 'MS-001', 7),
   (8, 'AG-001', 8),
   (9, 'LJ-001', 9),
   (10, 'VC-001', 10),
   (11, 'LP-002', 1),
   (12, 'N84-002', 2);

   -- Adherent (à insérer avant Inscription, Reservation, etc.)
INSERT INTO Adherent VALUES
   (1, 'Iratra', 'Shiny', '123', '2000-05-12', 1),
   (2, 'Bob Martin', 'bob.martin', 'motdepasse', '1985-11-03', 2),
   (3, 'Claire Dubois', 'claire.dubois', 'pass1234', '1992-07-21', 1),
   (4, 'Bibliothecaire', 'admin', '123', '1978-02-15', 3),
   (5, 'Emma Petit', 'emma.petit', 'emma2024', '2003-09-30', 4);

-- Jour_Ferie
INSERT INTO Jour_Ferie VALUES 
   (1, '2024-01-01'),
   (2, '2024-04-01'),
   (3, '2024-05-01'),
   (4, '2024-12-25');

-- Synchronisation des séquences
SELECT setval('statut_id_statut_seq', COALESCE((SELECT MAX(id_statut) FROM Statut), 1), true);
SELECT setval('configuration_profil_id_configuration_profil_seq', COALESCE((SELECT MAX(id_configuration_profil) FROM Configuration_Profil), 1), true);
SELECT setval('profil_id_profil_seq', COALESCE((SELECT MAX(id_profil) FROM Profil), 1), true);
SELECT setval('categorie_pret_id_categorie_pret_seq', COALESCE((SELECT MAX(id_categorie_pret) FROM Categorie_Pret), 1), true);
SELECT setval('categorie_id_categorie_seq', COALESCE((SELECT MAX(id_categorie) FROM Categorie), 1), true);
SELECT setval('type_pret_id_type_pret_seq', COALESCE((SELECT MAX(id_type_pret) FROM Type_Pret), 1), true);
SELECT setval('configuration_id_configuration_seq', COALESCE((SELECT MAX(id_configuration) FROM Configuration), 1), true);
SELECT setval('livre_id_livre_seq', COALESCE((SELECT MAX(id_livre) FROM Livre), 1), true);
SELECT setval('exemplaire_id_exemplaire_seq', COALESCE((SELECT MAX(id_exemplaire) FROM Exemplaire), 1), true);
SELECT setval('statut_exemplaire_id_status_exemplaire_seq', COALESCE((SELECT MAX(id_status_exemplaire) FROM Statut_Exemplaire), 1), true);
SELECT setval('adherent_id_adherent_seq', COALESCE((SELECT MAX(id_adherent) FROM Adherent), 1), true);
SELECT setval('reservation_id_reservation_seq', COALESCE((SELECT MAX(id_reservation) FROM Reservation), 1), true);
SELECT setval('penalite_id_penalite_seq', COALESCE((SELECT MAX(id_penalite) FROM Penalite), 1), true);
SELECT setval('inscription_id_seq', COALESCE((SELECT MAX(id) FROM Inscription), 1), true);
SELECT setval('blacklisting_id_blacklisting_seq', COALESCE((SELECT MAX(id_blacklisting) FROM Blacklisting), 1), true);
SELECT setval('pret_id_pret_seq', COALESCE((SELECT MAX(id_pret) FROM Pret), 1), true);
SELECT setval('prolongement_id_prolongement_seq', COALESCE((SELECT MAX(id_prolongement) FROM Prolongement), 1), true);
SELECT setval('retour_pret_id_retour_pret_seq', COALESCE((SELECT MAX(id_retour_pret) FROM Retour_Pret), 1), true);