-- LIVRE (20 livres)
INSERT INTO Livre (id_livre, titre, id_categorie, id_categorie_pret) VALUES
(1, 'Le Petit Prince', 1, 1),
(2, '1984', 2, 1),
(3, 'L Etranger', 1, 1),
(4, 'La Peste', 1, 1),
(5, 'Le Seigneur des Anneaux', 2, 1),
(6, 'Astérix le Gaulois', 4, 2),
(7, 'Tintin au Tibet', 4, 2),
(8, 'Le Monde de Sophie', 3, 1),
(9, 'Cosmos', 5, 1),
(10, 'Harry Potter à l école des sorciers', 6, 1),
(11, 'Le Meilleur des mondes', 2, 1),
(12, 'Le Comte de Monte-Cristo', 1, 1),
(13, 'Les Misérables', 1, 1),
(14, 'Le Livre de la Jungle', 6, 1),
(15, 'Le Capital', 3, 1),
(16, 'Le Grand Bleu', 5, 2),
(17, 'La Guerre des boutons', 6, 1),
(18, 'Le Horla', 1, 1),
(19, 'Voyage au centre de la Terre', 2, 1),
(20, 'Le Petit Nicolas', 6, 1);

-- EXEMPLAIRE (30 exemplaires, 1 à 3 par livre)
INSERT INTO Exemplaire (id_exemplaire, Reference, id_livre) VALUES
(1, 'LP-001', 1), (2, 'LP-002', 1),
(3, '1984-001', 2), (4, '1984-002', 2),
(5, 'ETR-001', 3),
(6, 'PES-001', 4),
(7, 'SDA-001', 5), (8, 'SDA-002', 5), (9, 'SDA-003', 5),
(10, 'AST-001', 6),
(11, 'TIN-001', 7),
(12, 'SOP-001', 8),
(13, 'COS-001', 9),
(14, 'HP-001', 10), (15, 'HP-002', 10),
(16, 'MDM-001', 11),
(17, 'CMC-001', 12),
(18, 'MIS-001', 13), (19, 'MIS-002', 13),
(20, 'LJ-001', 14),
(21, 'CAP-001', 15),
(22, 'GB-001', 16),
(23, 'GDB-001', 17),
(24, 'HOR-001', 18),
(25, 'VCT-001', 19),
(26, 'PN-001', 20), (27, 'PN-002', 20), (28, 'PN-003', 20),
(29, 'ROM-001', 1), (30, 'ROM-002', 1);

-- STATUT_EXEMPLAIRE (statut actuel pour chaque exemplaire)
-- INSERT INTO Statut_Exemplaire (id_status_exemplaire, date_ajout, id_exemplaire, id_statut) VALUES
-- (1, '2025-07-01 10:00:00', 1, 1),
-- (2, '2025-07-01 10:00:00', 2, 2),
-- (3, '2025-07-01 10:00:00', 3, 1),
-- (4, '2025-07-01 10:00:00', 4, 1),
-- (5, '2025-07-01 10:00:00', 5, 1),
-- (6, '2025-07-01 10:00:00', 6, 1),
-- (7, '2025-07-01 10:00:00', 7, 1),
-- (8, '2025-07-01 10:00:00', 8, 3),
-- (9, '2025-07-01 10:00:00', 9, 1),
-- (10, '2025-07-01 10:00:00', 10, 1),
-- (11, '2025-07-01 10:00:00', 11, 1),
-- (12, '2025-07-01 10:00:00', 12, 1),
-- (13, '2025-07-01 10:00:00', 13, 1),
-- (14, '2025-07-01 10:00:00', 14, 2),
-- (15, '2025-07-01 10:00:00', 15, 1),
-- (16, '2025-07-01 10:00:00', 16, 1),
-- (17, '2025-07-01 10:00:00', 17, 1),
-- (18, '2025-07-01 10:00:00', 18, 1),
-- (19, '2025-07-01 10:00:00', 19, 1),
-- (20, '2025-07-01 10:00:00', 20, 1),
-- (21, '2025-07-01 10:00:00', 21, 1),
-- (22, '2025-07-01 10:00:00', 22, 1),
-- (23, '2025-07-01 10:00:00', 23, 1),
-- (24, '2025-07-01 10:00:00', 24, 1),
-- (25, '2025-07-01 10:00:00', 25, 1),
-- (26, '2025-07-01 10:00:00', 26, 1),
-- (27, '2025-07-01 10:00:00', 27, 1),
-- (28, '2025-07-01 10:00:00', 28, 1),
-- (29, '2025-07-01 10:00:00', 29, 1),
-- (30, '2025-07-01 10:00:00', 30, 1);

-- -- RESERVATION (quelques réservations)
-- INSERT INTO Reservation (id_reservation, date_reservation, date_reserver, id_exemplaire, id_adherent) VALUES
-- (1, '2025-07-02 09:00:00', '2025-07-05 09:00:00', 2, 1),
-- (2, '2025-07-03 14:00:00', '2025-07-06 14:00:00', 8, 2),
-- (3, '2025-07-04 11:00:00', '2025-07-07 11:00:00', 14, 3);

-- -- PENALITE (quelques pénalités)
-- INSERT INTO Penalite (id_penalite, justificatif, date_penalite, id_type_penalite, id_adherent) VALUES
-- (1, 'Retard de 3 jours', '2025-06-20 10:00:00', 1, 1),
-- (2, 'Livre perdu', '2025-06-25 15:00:00', 2, 2);

-- INSCRIPTION (inscriptions des adhérents)
INSERT INTO Inscription (id, date_debut, date_fin, id_adherent) VALUES
(1, '2025-01-01 09:00:00', '2025-12-31 18:00:00', 1),
(2, '2025-01-01 09:00:00', '2025-12-31 18:00:00', 2),
(3, '2025-01-01 09:00:00', '2025-12-31 18:00:00', 3),
(4, '2025-01-01 09:00:00', '2025-12-31 18:00:00', 4),
(5, '2025-01-01 09:00:00', '2025-12-31 18:00:00', 5);

-- -- BLACKLISTING (un adhérent blacklisté)
-- INSERT INTO Blacklisting (id_blacklisting, date_debut, date_fin, id_adherent) VALUES
-- (1, '2025-06-15 09:00:00', '2025-07-15 18:00:00', 2);

-- -- PRET (quelques prêts)
-- INSERT INTO Pret (id_pret, date_pret, date_retour, id_type_pret, id_exemplaire, id_adherent) VALUES
-- (1, '2025-07-01 10:00:00', '2025-07-15 10:00:00', 2, 1, 1),
-- (2, '2025-07-02 11:00:00', '2025-07-16 11:00:00', 2, 3, 2),
-- (3, '2025-07-03 12:00:00', '2025-07-17 12:00:00', 2, 5, 3);

-- -- PROLONGEMENT (un prolongement)
-- INSERT INTO Prolongement (id_prolongement, date_retour, id_pret) VALUES
-- (1, '2025-07-22 10:00:00', 1);

-- -- RETOUR_PRET (un retour)
-- INSERT INTO Retour_Pret (id_retour_pret, date_retourne, id_pret) VALUES
-- (1, '2025-07-15 09:30:00', 1);

-- JOUR_FERIE (quelques jours fériés)
INSERT INTO Jour_Ferie (id_ferie, date_ferie) VALUES
(1, '2025-01-01'),
(2, '2025-05-01'),
(3, '2025-07-14');

-- NOTE (quelques notes)
INSERT INTO Note (id_note, note, commentaire, id_adherent, id_livre) VALUES
(1, 5, 'Excellent livre !', 1, 1),
(2, 4, 'Très intéressant.', 2, 2),
(3, 3, 'Lecture difficile.', 3, 3);

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