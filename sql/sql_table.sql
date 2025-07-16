\c postgres
drop database if exists bibliotheque;
create database bibliotheque;
\c bibliotheque

CREATE TABLE before (
    id serial primary key,
    value boolean not null
);

CREATE TABLE public_holiday (
    id           SERIAL       PRIMARY KEY,
    name         TEXT         NOT NULL,
    date_holiday DATE         NOT NULL
);

CREATE TABLE member_type (
    id                 SERIAL       PRIMARY KEY,
    value              TEXT         NOT NULL,
    quota_loan         INTEGER      NOT NULL,
    quota_reservation  INTEGER      NOT NULL,
    quota_extension    INTEGER      NOT NULL,
    loan_duration      INTEGER      NOT NULL,
    extension_duration INTEGER     NOT NULL,
    penality_duration  INTEGER      NOT NULL
);

CREATE TABLE status (
    id    SERIAL       PRIMARY KEY,
    value TEXT         NOT NULL
);

CREATE TABLE member (
    id                 SERIAL       PRIMARY KEY,
    email              TEXT         NOT NULL,
    id_member_type     INTEGER      NOT NULL,
    username           TEXT         NOT NULL,
    birth              DATE         NOT NULL,
    password           TEXT         NOT NULL,
    registration_date  DATE         NOT NULL,

    CONSTRAINT fk_member_type
        FOREIGN KEY (id_member_type)
        REFERENCES member_type(id)
        ON DELETE CASCADE
);

CREATE TABLE member_status (
    id          SERIAL  PRIMARY KEY,
    id_member   INTEGER NOT NULL,
    id_status   INTEGER NOT NULL,
    status_date DATE    NOT NULL,

    CONSTRAINT fk_member_status_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_member_status_status
        FOREIGN KEY (id_status)
        REFERENCES status(id)
        ON DELETE CASCADE
);

CREATE TABLE librarian (
    id       SERIAL PRIMARY KEY,
    username TEXT   NOT NULL,
    password TEXT   NOT NULL
);

CREATE TABLE subscription_type (
    id       SERIAL        PRIMARY KEY,
    name     TEXT          NOT NULL,
    duration INTEGER       NOT NULL
);

CREATE TABLE subscription (
    id                    SERIAL  PRIMARY KEY,
    id_member             INTEGER NOT NULL,
    id_subscription_type  INTEGER NOT NULL,
    id_librarian          INTEGER ,
    subscription_date     DATE    NOT NULL,
    subscription_start    DATE    NOT NULL,
    subscription_end      DATE    NOT NULL,

    CONSTRAINT fk_subscription_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_subscription_type
        FOREIGN KEY (id_subscription_type)
        REFERENCES subscription_type(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_subscription_librarian
        FOREIGN KEY (id_librarian)
        REFERENCES librarian(id)
        ON DELETE CASCADE
);

CREATE TABLE book_genre (
    id    SERIAL PRIMARY KEY,
    value TEXT   NOT NULL
);

CREATE TABLE book_theme (
    id    SERIAL PRIMARY KEY,
    value TEXT   NOT NULL
);

CREATE TABLE author (
    id          SERIAL PRIMARY KEY,
    name        TEXT   NOT NULL,
    artist_name TEXT   NULL
);

CREATE TABLE book (
    id             SERIAL  PRIMARY KEY,
    title          TEXT    NOT NULL,
    id_author      INTEGER NOT NULL,
    id_book_genre  INTEGER NOT NULL,
    edition_date   DATE    NOT NULL,
    age            INTEGER NOT NULL,

    CONSTRAINT fk_book_author
        FOREIGN KEY (id_author)
        REFERENCES author(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_book_genre
        FOREIGN KEY (id_book_genre)
        REFERENCES book_genre(id)
        ON DELETE CASCADE
);

CREATE TABLE book_details (
    id             SERIAL  PRIMARY KEY,
    id_book        INTEGER NOT NULL,
    id_book_theme  INTEGER NOT NULL,

    CONSTRAINT fk_book_details_book
        FOREIGN KEY (id_book)
        REFERENCES book(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_book_details_theme
        FOREIGN KEY (id_book_theme)
        REFERENCES book_theme(id)
        ON DELETE CASCADE
);

CREATE TABLE copy (
    id       SERIAL  PRIMARY KEY,
    id_book  INTEGER NOT NULL,
    copy_id  INTEGER NOT NULL,

    CONSTRAINT fk_copy_book
        FOREIGN KEY (id_book)
        REFERENCES book(id)
        ON DELETE CASCADE
);

CREATE TABLE loan (
    id                  SERIAL  PRIMARY KEY,
    id_member           INTEGER NOT NULL,
    id_copy             INTEGER NOT NULL,
    id_librarian_loan   INTEGER NOT NULL,
    loan_date           DATE    NOT NULL,
    start_date          DATE    NOT NULL,
    due_date            DATE    NOT NULL,
    id_librarian_return INTEGER,
    return_date         DATE,

    CONSTRAINT fk_loan_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_loan_copy
        FOREIGN KEY (id_copy)
        REFERENCES copy(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_loan_librarian_loan
        FOREIGN KEY (id_librarian_loan)
        REFERENCES librarian(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_loan_librarian_return
        FOREIGN KEY (id_librarian_return)
        REFERENCES librarian(id)
        ON DELETE SET NULL
);

CREATE TABLE reservation (
    id                SERIAL  PRIMARY KEY,
    id_member         INTEGER NOT NULL,
    id_book           INTEGER NOT NULL,
    reservation_date  DATE    NOT NULL,
    ask_start_date    DATE    NOT NULL,
    ask_due_date      DATE    NOT NULL,
    id_librarian      INTEGER,
    treatment_date    DATE,
    id_loan           INTEGER,

    CONSTRAINT fk_reservation_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_reservation_book
        FOREIGN KEY (id_book)
        REFERENCES book(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_reservation_librarian
        FOREIGN KEY (id_librarian)
        REFERENCES librarian(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_reservation_loan
        FOREIGN KEY (id_loan)
        REFERENCES loan(id)
        ON DELETE SET NULL
);

CREATE TABLE extension (
    id               SERIAL  PRIMARY KEY,
    id_loan          INTEGER NOT NULL,
    extension_date   DATE    NOT NULL,
    actual_due_date  DATE    NOT NULL,
    ask_due_date     DATE    NOT NULL,
    id_librarian     INTEGER,
    treatment_date   DATE,
    is_allowed       BOOLEAN,

    CONSTRAINT fk_extension_loan
        FOREIGN KEY (id_loan)
        REFERENCES loan(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_extension_librarian
        FOREIGN KEY (id_librarian)
        REFERENCES librarian(id)
        ON DELETE SET NULL
);

CREATE TABLE penality (
    id          SERIAL        PRIMARY KEY,
    id_loan     INTEGER       NOT NULL,
    id_member   INTEGER       NOT NULL,
    start_date    DATE          NOT NULL,
    end_date DATE NOT NULL,

    CONSTRAINT fk_penality_loan
        FOREIGN KEY (id_loan)
        REFERENCES loan(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_penality_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
        ON DELETE CASCADE
);

CREATE TABLE member_quota_loan (
    id         SERIAL  PRIMARY KEY,
    id_member  INTEGER NOT NULL,
    quota      INTEGER NOT NULL,
    quota_date DATE    NOT NULL,
    id_loan    INTEGER NULL,

    CONSTRAINT fk_member_quota_loan_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
        ON DELETE CASCADE
);

CREATE TABLE member_quota_reservation (
    id              SERIAL  PRIMARY KEY,
    id_member       INTEGER NOT NULL,
    quota           INTEGER NOT NULL,
    quota_date      DATE    NOT NULL,
    id_reservation  INTEGER NULL,

    CONSTRAINT fk_member_quota_reservation_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
        ON DELETE CASCADE
);

CREATE TABLE member_quota_extension (
    id             SERIAL  PRIMARY KEY,
    id_member      INTEGER NOT NULL,
    quota          INTEGER NOT NULL,
    quota_date     DATE    NOT NULL,
    id_extension   INTEGER NULL,

    CONSTRAINT fk_member_quota_extension_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
        ON DELETE CASCADE
);

CREATE TABLE authorisation (
    id               SERIAL  PRIMARY KEY,
    id_member_type   INTEGER NOT NULL,
    id_book          INTEGER NOT NULL,

    CONSTRAINT fk_authorisation_member_type
        FOREIGN KEY (id_member_type)
        REFERENCES member_type(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_authorisation_book
        FOREIGN KEY (id_book)
        REFERENCES book(id)
        ON DELETE CASCADE
);
