INSERT INTO before (value) VALUES (true); 

INSERT INTO pub
-- Les Misérables : thèmes "Politics", "Society"
INSERT INTO book_details (id_book, id_book_theme) VALUES (1, 1), (1, 2);

-- 1984 : thèmes "Politics"
INSERT INTO book_details (id_book, id_book_theme) VALUES (2, 1);

-- L'Homme qui rit : thème "Adventure"
INSERT INTO book_details (id_book, id_book_theme) VALUES (3, 6);

day (name, date_holiday) VALUES
('New Year Day', '2025-01-01'),
('Labour Day', '2025-05-01'),
('Independence Day', '2025-06-26'),
('Christmas', '2025-12-25');

INSERT INTO status (value) VALUES
('Active'),     -- id = 1
('Inactive'),   -- id = 2
('Penalized');  -- id = 3

INSERT INTO member_type (
    value, quota_loan, quota_reservation, quota_extension,
    loan_duration, extension_duration, penality_duration
) VALUES
('Student', 3, 2, 1, 15, 7, 10),
('Teacher', 5, 3, 2, 30, 15, 5),
('Public', 2, 1, 1, 10, 5, 15);

INSERT INTO subscription_type (name, duration) VALUES
('Monthly', 30),
('Quarterly', 90),
('Annual', 365);

INSERT INTO book_genre (value) VALUES
('Novel'),
('Science Fiction'),
('Fantasy'),
('Biography'),
('History');

INSERT INTO book_theme (value) VALUES
('Politics'),     -- id = 1
('Society'),      -- id = 2  
('Magic'),        -- id = 3
('War'),          -- id = 4
('Friendship'),   -- id = 5
('Adventure'),    -- id = 6
('Science');      -- id = 7

INSERT INTO author (name, artist_name) VALUES
('Victor Hugo', NULL),     -- id = 1
('George Orwell', NULL),   -- id = 2  
('Isaac Asimov', NULL),    -- id = 3
('J.R.R. Tolkien', NULL),  -- id = 4
('Yuval Noah Harari', NULL); -- id = 5

INSERT INTO librarian (username, password) VALUES
('admin', 'admin123'),
('jeanne', 'jeanne123'), 
('paul', 'paul123');

INSERT INTO book (title, id_author, id_book_genre, edition_date, age)
VALUES 
('Les Misérables', 1, 1, '1862-04-03', 12),
('1984', 2, 2, '1949-06-08', 16),
('L Homme qui rit', 1, 1, '1869-01-01', 14);


-- Les Misérables : thèmes "Politique", "Société"
INSERT INTO book_details (id_book, id_book_theme) VALUES (1, 1), (1, 3);

-- 1984 : thèmes "Politique"
INSERT INTO book_details (id_book, id_book_theme) VALUES (2, 1);

-- L’Homme qui rit : thème "Aventure"
INSERT INTO book_details (id_book, id_book_theme) VALUES (3, 2);


-- Les Misérables (2 copies)
INSERT INTO copy (id_book, copy_id) VALUES (1, 1), (1, 2);

-- 1984 (3 copies)
INSERT INTO copy (id_book, copy_id) VALUES (2, 1), (2, 2), (2, 3);

-- L’Homme qui rit (1 copie)
INSERT INTO copy (id_book, copy_id) VALUES (3, 1);
