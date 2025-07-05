-- Livre
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

-- Statut_Exemplaire
INSERT INTO Statut_Exemplaire VALUES 
   (1, '2024-06-01 10:00:00', 1, 1),
   (2, '2024-06-02 11:00:00', 2, 2),
   (3, '2024-06-03 09:00:00', 3, 1),
   (4, '2024-06-04 12:00:00', 4, 3),
   (5, '2024-06-05 13:00:00', 5, 1),
   (6, '2024-06-06 14:00:00', 6, 1),
   (7, '2024-06-07 15:00:00', 7, 1),
   (8, '2024-06-08 16:00:00', 8, 2),
   (9, '2024-06-09 17:00:00', 9, 1),
   (10, '2024-06-10 18:00:00', 10, 1);

-- Adherent (à insérer avant Inscription, Reservation, etc.)
INSERT INTO Adherent VALUES
   (1, 'Iratra', 'Shiny', '123', '2000-05-12', 1),
   (2, 'Bob Martin', 'bob.martin', 'motdepasse', '1985-11-03', 2),
   (3, 'Claire Dubois', 'claire.dubois', 'pass1234', '1992-07-21', 1),
   (4, 'Bibliothecaire', 'admin', '123', '1978-02-15', 3),
   (5, 'Emma Petit', 'emma.petit', 'emma2024', '2003-09-30', 4);

-- Inscription
INSERT INTO Inscription VALUES 
   (1, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 1),
   (2, '2024-02-01 00:00:00', '2025-01-31 23:59:59', 2),
   (3, '2024-03-01 00:00:00', '2025-02-28 23:59:59', 3),
   (4, '2024-04-01 00:00:00', '2025-03-31 23:59:59', 4);

-- Reservation
INSERT INTO Reservation VALUES 
   (1, '2024-06-15 09:00:00', '2024-06-20 09:00:00', 1, 1),
   (2, '2024-06-16 14:00:00', '2024-06-21 14:00:00', 2, 3),
   (3, '2024-06-17 10:00:00', '2024-06-22 10:00:00', 5, 2),
   (4, '2024-06-18 11:00:00', '2024-06-23 11:00:00', 6, 1);

-- Penalite
INSERT INTO Penalite VALUES 
   (1, 'Justificatif médical', '2024-06-21 09:00:00', 1, 1),
   (2, 'Livre perdu lors d un déménagement', '2024-06-22 10:00:00', 2, 2),
   (3, 'Pages arrachées', '2024-06-23 11:00:00', 3, 3),
   (4, 'Comportement inapproprié', '2024-06-24 12:00:00', 4, 4);

-- Blacklisting
INSERT INTO Blacklisting VALUES 
   (1, '2024-07-01 00:00:00', '2024-07-15 23:59:59', 2),
   (2, '2024-08-01 00:00:00', '2024-08-10 23:59:59', 3);

-- Pret
INSERT INTO Pret VALUES 
   (1, '2024-06-10 10:00:00', '2024-06-20 10:00:00', 1, 1, 1),
   (2, '2024-06-12 15:00:00', '2024-06-22 15:00:00', 2, 2, 2),
   (3, '2024-06-13 16:00:00', '2024-06-23 16:00:00', 1, 3, 3),
   (4, '2024-06-14 17:00:00', '2024-06-24 17:00:00', 2, 4, 4),
   (5, '2024-06-15 18:00:00', '2024-06-25 18:00:00', 1, 5, 1);

-- Prolongement
INSERT INTO Prolongement VALUES 
   (1, '2024-06-27 10:00:00', 1),
   (2, '2024-06-28 11:00:00', 2);

-- Retour_Pret
INSERT INTO Retour_Pret VALUES 
   (1, '2024-06-21 09:00:00', 1),
   (2, '2024-06-23 16:00:00', 3);

-- Jour_Ferie
INSERT INTO Jour_Ferie VALUES 
   (1, '2024-01-01'),
   (2, '2024-04-01'),
   (3, '2024-05-01'),
   (4, '2024-12-25');

-- Note
INSERT INTO Note VALUES 
   (1, 5, 'Super livre, à recommander !', 1, 1),
   (2, 4, 'Très intéressant.', 2, 2),
   (3, 3, 'Lecture difficile.', 3, 3),
   (4, 5, 'Excellent pour les enfants.', 1, 9),
   (5, 2, 'Pas à mon goût.', 2, 4);

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