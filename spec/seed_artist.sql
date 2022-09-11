-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Pixie', 'Rock');
INSERT INTO artists (name, genre) VALUES ('Abba', 'Pop');

INSERT INTO albums (title, release_year, artist_id) VALUES ('Doolittle', '1989', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Surfer Rosa', '1988', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Waterloo', '1974', 2);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Super Trouper', '1980', 2);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Bossonova', '1990', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Lover', '2019', 2);