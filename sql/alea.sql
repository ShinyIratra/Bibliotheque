INSERT INTO before (value) VALUES (true); 

INSERT INTO status (value) VALUES
('Active'),     -- id = 1
('Inactive'),   -- id = 2
('Penalized');  -- id = 3

INSERT INTO member_type (
    value, quota_loan, quota_reservation, quota_extension,
    loan_duration, extension_duration, penality_duration
) VALUES
('Etudiant', 2, 1, 3, 7, 100, 10),
('Enseignant', 3, 2, 5, 9, 100, 9),
('Professionnel', 4, 3, 7, 12, 100, 8);

INSERT INTO subscription_type (name, duration) VALUES
('Monthly', 30),
('Quarterly', 90),
('Annual', 365),
('Custom', 0);

INSERT INTO author (name, artist_name) VALUES
('Victor Hugo', NULL),     -- id = 1
('Albert Camus', NULL),   -- id = 2  
('J.K. Rowling', NULL);    -- id = 3

INSERT INTO librarian (username, password) VALUES
('admin', 'admin'),
('jeanne', 'jeanne123'), 
('paul', 'paul123');

INSERT INTO book_genre (value) VALUES
('Littérature Classique'),
('Philosophie'),
('Jeunesse/Fantastique');

INSERT INTO book (title, id_author, id_book_genre, edition_date, age)
VALUES 
('Les Misérables', 1, 1, '1862-04-03', 12),
('L Etranger', 2, 2, '1949-06-08', 16),
('Harry Potter à l ecole des sorciers', 3, 3, '1997-06-26', 11);

INSERT INTO book_theme (value) VALUES
('Politics'),     -- id = 1
('Society'),      -- id = 2  
('Magic'),        -- id = 3
('War'),          -- id = 4
('Friendship'),   -- id = 5
('Adventure'),    -- id = 6
('Science');      -- id = 7

-- Les Misérables : thèmes "Politics", "Society"
INSERT INTO book_details (id_book, id_book_theme) VALUES (1, 1), (1, 2);

-- L'Etranger : thème "Society"
INSERT INTO book_details (id_book, id_book_theme) VALUES (2, 2);

-- Harry Potter à l'école des sorciers : thème "Magic"
INSERT INTO book_details (id_book, id_book_theme) VALUES (3, 3);

INSERT INTO public_holiday (name, date_holiday) VALUES
('Dimanche', '2025-07-13'),
('Dimanche', '2025-07-20'),
('Dimanche', '2025-07-27'),
('Dimanche', '2025-08-03'),
('Dimanche', '2025-08-10'),
('Dimanche', '2025-08-17'),
('Jour Férié', '2025-07-26'),
('Jour Férié', '2025-07-19'),
('Dimanche', '2025-12-25');

-- Les Misérables (3 copies)
INSERT INTO copy (id_book, copy_id) VALUES (1, 1), (1, 2), (1, 3);

-- L'Etranger (2 copies)
INSERT INTO copy (id_book, copy_id) VALUES (2, 1), (2, 2);

-- Harry Potter (1 copie)
INSERT INTO copy (id_book, copy_id) VALUES (3, 1);

INSERT INTO member (email, id_member_type, username, birth, password, registration_date) VALUES
('etu001@gmail.com', 1, 'ETU001', '2000-01-01', 'etu001', '2025-07-16'),
('etu002@gmail.com', 1, 'ETU002', '1987-03-22', 'etu002', '2025-07-16'),
('etu003@gmail.com', 1, 'ETU003', '1999-11-05', 'etu003', '2025-07-16'),
('ens001@gmail.com', 2, 'ENS001', '1975-06-30', 'ens001', '2025-07-16'),
('ens002@gmail.com', 2, 'ENS002', '1982-12-14', 'ens002', '2025-07-16'),
('ens003@gmail.com', 2, 'ENS003', '1990-04-18', 'ens003', '2025-07-16'),
('prof001@gmail.com', 3, 'PROF001', '1988-09-09', 'prof001', '2025-07-16'),
('prof002@gmail.com', 3, 'PROF002', '1992-02-27', 'prof002', '2025-07-16');

INSERT INTO subscription (id_member, id_subscription_type, id_librarian, subscription_date, subscription_start, subscription_end) VALUES
(1, 4, 1, '2025-07-16', '2025-02-01', '2025-07-24'),
(2, 4, 1, '2025-07-16', '2025-02-01', '2025-07-01'),
(3, 4, 1, '2025-07-16', '2025-04-01', '2025-12-01'),
(4, 4, 1, '2025-07-16', '2025-07-01', '2026-07-01'),
(5, 4, 1, '2025-07-16', '2025-08-01', '2026-05-01'),
(6, 4, 1, '2025-07-16', '2025-07-01', '2026-06-01'),
(7, 4, 1, '2025-07-16', '2025-06-01', '2025-12-01'),
(8, 4, 1, '2025-07-16', '2025-10-01', '2025-06-01');


