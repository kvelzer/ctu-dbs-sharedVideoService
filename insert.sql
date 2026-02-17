-- Smazání stávajících dat ze všech relevantních tabulek a resetování sekvencí
-- Používáme TRUNCATE s RESTART IDENTITY a CASCADE pro zajištění čistého stavu
TRUNCATE TABLE ban, download, event, film, moderator, service_user, subscription, upload, view RESTART IDENTITY CASCADE;

-- Vložení dat do tabulky service_user (Uživatelé služby)
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (1, '2023-01-15', 'KarelNovak');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (2, '2023-02-20', 'JanaSvobodova');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (3, '2023-03-10', 'PetrDvorak');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (4, '2023-04-05', 'EvaCerna');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (5, '2023-05-12', 'TomasMarek');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (6, '2023-06-18', 'LuciePokorna');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (7, '2023-07-22', 'MartinHajek');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (8, '2023-08-30', 'VeronikaKralova');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (9, '2024-01-05', 'PavelRuzicka');
INSERT INTO service_user (id_user, registration_date, nickname) VALUES (10, '2024-02-10', 'SimonaFialova');

-- Vložení dat do tabulky film (Filmy) -- DOPLNĚN NÁZEV
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (1, 'Pelíšky Revival', 'Komedie', 'Česká republika', '2022-05-20');
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (2, 'Tatranský Příběh', 'Drama', 'Slovensko', '2021-11-15');
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (3, 'Vesmírná Odyssea 2023', 'Sci-Fi', 'USA', '2023-01-30'); -- Film pro dotaz D1
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (4, 'Londýnský Stín', 'Thriller', 'Velká Británie', '2022-09-05');
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (5, 'Cesta Samuraje', 'Animovaný', 'Japonsko', '2023-03-12');
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (6, 'Berlínská Zeď: Pád', 'Dokumentární', 'Německo', '2020-08-25');
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (7, 'Pařížské Rendezvous', 'Komedie', 'Francie', '2023-06-10');
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (8, 'Noc Hrůzy v Texasu', 'Horor', 'USA', '2023-10-31');
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (9, 'Projekt Pegasus', 'Akční', 'USA', '2024-01-15');
INSERT INTO film (id_film, name, genre, country, release_date) VALUES (10, 'Karel IV: Cesta na trůn', 'Historický', 'Česká republika', '2022-03-01');

-- Vložení dat do tabulky moderator (Moderátoři)
INSERT INTO moderator (id_user, start_date, country) VALUES (1, '2023-06-01', 'Česká republika'); -- KarelNovak
INSERT INTO moderator (id_user, start_date, country) VALUES (3, '2023-07-15', 'Česká republika'); -- PetrDvorak
INSERT INTO moderator (id_user, start_date, country) VALUES (5, '2023-08-01', NULL); -- TomasMarek, země NULL
INSERT INTO moderator (id_user, start_date, country) VALUES (7, '2024-01-20', 'Slovensko'); -- MartinHajek

-- Vložení dat do tabulky subscription (Předplatné)
INSERT INTO subscription (id_user, end_date) VALUES (2, '2025-02-20');
INSERT INTO subscription (id_user, end_date) VALUES (4, '2024-12-31');
INSERT INTO subscription (id_user, end_date) VALUES (6, '2025-06-18');
INSERT INTO subscription (id_user, end_date) VALUES (8, '2024-11-30');
INSERT INTO subscription (id_user, end_date) VALUES (10, '2025-08-10');
INSERT INTO subscription (id_user, end_date) VALUES (1, '2025-01-15'); -- KarelNovak (moderátor a uploader všech filmů ID=3)
INSERT INTO subscription (id_user, end_date) VALUES (3, '2026-01-01');
INSERT INTO subscription (id_user, end_date) VALUES (5, '2026-01-01');
INSERT INTO subscription (id_user, end_date) VALUES (7, '2026-01-01');
INSERT INTO subscription (id_user, end_date) VALUES (9, '2026-01-01');

-- Vložení dat do tabulky upload (Nahrané soubory) - cca 35 záznamů
-- Upraveny hodnoty 'quality' na 'HD', 'FullHD', '4K' dle CHECK constraintu
-- Upraven id_user pro film 3 (uploady 2, 10, 18, 26) pro účely dotazu D1
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (1, 1, 2, '1.5 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (2, 3, 1, '2.2 GB', '4K');         -- Film 3, User 1 (pro D1)
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (3, 2, 6, '1.1 GB', 'HD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (4, 5, 8, '800 MB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (5, 4, 10, '1.8 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (6, 7, 1, '1.3 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (7, 6, 3, '2.5 GB', '4K');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (8, 8, 5, '950 MB', 'HD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (9, 1, 7, '1.6 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (10, 3, 1, '2.0 GB', 'FullHD');    -- Film 3, User 1 (pro D1)
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (11, 2, 2, '1.2 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (12, 5, 4, '750 MB', 'HD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (13, 4, 6, '1.9 GB', '4K');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (14, 7, 8, '1.4 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (15, 6, 10, '2.6 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (16, 8, 1, '1.0 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (17, 1, 3, '1.7 GB', '4K');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (18, 3, 1, '2.1 GB', 'FullHD');    -- Film 3, User 1 (pro D1)
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (19, 2, 7, '1.0 GB', 'HD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (20, 5, 9, '850 MB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (21, 4, 2, '1.7 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (22, 7, 4, '1.2 GB', 'HD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (23, 6, 6, '2.4 GB', '4K');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (24, 8, 8, '900 MB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (25, 1, 10, '1.5 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (26, 3, 1, '2.3 GB', '4K');         -- Film 3, User 1 (pro D1)
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (27, 2, 3, '1.1 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (28, 5, 5, '820 MB', 'HD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (29, 4, 7, '1.9 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (30, 7, 9, '1.4 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (31, 6, 2, '2.7 GB', '4K');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (32, 8, 4, '1.1 GB', 'HD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (33, 9, 6, '2.8 GB', '4K');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (34, 10, 8, '1.4 GB', 'FullHD');
INSERT INTO upload (id_upload, id_film, id_user, size, quality) VALUES (35, 9, 10, '2.9 GB', 'FullHD');

-- Vložení dat do tabulky event (Události - základ pro view/download) - 40 záznamů
-- Každý upload má alespoň jednu událost, některé více
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (1, 1, 1, '2023-05-21');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (2, 1, 3, '2023-05-22');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (3, 2, 5, '2023-02-01'); -- Upload 2 (Film 3) viewed by User 5
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (4, 3, 7, '2023-06-20');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (5, 4, 9, '2023-05-15');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (6, 5, 2, '2023-04-10');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (7, 6, 4, '2023-07-25');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (8, 7, 6, '2023-08-05');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (9, 8, 8, '2023-09-01');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (10, 9, 10, '2023-07-23');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (11, 10, 1, '2024-01-06'); -- Upload 10 (Film 3) viewed by User 1 (uploader)
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (12, 11, 3, '2023-03-01');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (13, 12, 5, '2023-05-13');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (14, 13, 7, '2023-06-25');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (15, 14, 9, '2023-08-31');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (16, 15, 2, '2024-02-11');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (17, 16, 4, '2023-09-10');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (18, 17, 6, '2023-06-19');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (19, 18, 8, '2023-08-02'); -- Upload 18 (Film 3) viewed by User 8
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (20, 19, 10, '2023-07-24');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (21, 20, 1, '2024-01-07');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (22, 21, 3, '2023-04-06');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (23, 22, 5, '2023-06-11');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (24, 23, 7, '2023-07-01');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (25, 24, 9, '2023-09-02');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (26, 25, 2, '2024-02-15');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (27, 26, 4, '2023-06-05'); -- Upload 26 (Film 3) viewed by User 4
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (28, 27, 6, '2023-07-16');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (29, 28, 8, '2023-08-03');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (30, 29, 10, '2024-01-21');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (31, 30, 1, '2024-01-10');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (32, 31, 3, '2023-08-15');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (33, 32, 5, '2023-11-01');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (34, 33, 7, '2024-02-01');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (35, 34, 9, '2023-03-05');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (36, 35, 2, '2024-02-20');
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (37, 1, 5, '2023-05-23'); -- Další událost pro upload 1
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (38, 2, 7, '2023-02-05'); -- Další událost pro upload 2 (Film 3)
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (39, 3, 9, '2023-06-22'); -- Další událost pro upload 3
INSERT INTO event (id_event, id_upload, id_user, date) VALUES (40, 4, 1, '2023-05-16'); -- Další událost pro upload 4

-- Vložení dat do tabulky view (Zhlédnutí) - 20 záznamů (podmnožina event)
INSERT INTO view (id_event, duration) VALUES (1, 120);
INSERT INTO view (id_event, duration) VALUES (3, 5400); -- View for Upload 2 (Film 3)
INSERT INTO view (id_event, duration) VALUES (5, 7200);
INSERT INTO view (id_event, duration) VALUES (7, 300);
INSERT INTO view (id_event, duration) VALUES (9, 6500);
INSERT INTO view (id_event, duration) VALUES (11, 7100); -- View for Upload 10 (Film 3)
INSERT INTO view (id_event, duration) VALUES (13, 4800);
INSERT INTO view (id_event, duration) VALUES (15, 2400);
INSERT INTO view (id_event, duration) VALUES (17, 1800);
INSERT INTO view (id_event, duration) VALUES (19, 5000); -- View for Upload 18 (Film 3)
INSERT INTO view (id_event, duration) VALUES (21, 6800);
INSERT INTO view (id_event, duration) VALUES (23, 7000);
INSERT INTO view (id_event, duration) VALUES (25, 3600);
INSERT INTO view (id_event, duration) VALUES (27, 1200); -- View for Upload 26 (Film 3)
INSERT INTO view (id_event, duration) VALUES (29, 4500);
INSERT INTO view (id_event, duration) VALUES (31, 6900);
INSERT INTO view (id_event, duration) VALUES (33, 5200);
INSERT INTO view (id_event, duration) VALUES (35, 3100);
INSERT INTO view (id_event, duration) VALUES (37, 900);
INSERT INTO view (id_event, duration) VALUES (39, 6000);

-- Vložení dat do tabulky download (Stažení) - 20 záznamů (podmnožina event, jiná než view)
INSERT INTO download (id_event, duration) VALUES (2, 15);
INSERT INTO download (id_event, duration) VALUES (4, 25);
INSERT INTO download (id_event, duration) VALUES (6, 18);
INSERT INTO download (id_event, duration) VALUES (8, 30);
INSERT INTO download (id_event, duration) VALUES (10, 12);
INSERT INTO download (id_event, duration) VALUES (12, 22);
INSERT INTO download (id_event, duration) VALUES (14, 17);
INSERT INTO download (id_event, duration) VALUES (16, 35);
INSERT INTO download (id_event, duration) VALUES (18, 10);
INSERT INTO download (id_event, duration) VALUES (20, 14);
INSERT INTO download (id_event, duration) VALUES (22, 28);
INSERT INTO download (id_event, duration) VALUES (24, 19);
INSERT INTO download (id_event, duration) VALUES (26, 40);
INSERT INTO download (id_event, duration) VALUES (28, 13);
INSERT INTO download (id_event, duration) VALUES (30, 21);
INSERT INTO download (id_event, duration) VALUES (32, 33);
INSERT INTO download (id_event, duration) VALUES (34, 16);
INSERT INTO download (id_event, duration) VALUES (36, 45);
INSERT INTO download (id_event, duration) VALUES (38, 20); -- Download for Upload 2 (Film 3)
INSERT INTO download (id_event, duration) VALUES (40, 11);

-- Vložení dat do tabulky ban (Bany) - 5 záznamů
-- Moderátor 1 banuje uživatele 9
INSERT INTO ban (id_ban, moderator_id_user, id_user, duration, date) VALUES (1, 1, 9, 7, '2024-01-08');
-- Moderátor 3 banuje uživatele 2
INSERT INTO ban (id_ban, moderator_id_user, id_user, duration, date) VALUES (2, 3, 2, 30, '2023-09-15');
-- Moderátor 5 banuje uživatele 4
INSERT INTO ban (id_ban, moderator_id_user, id_user, duration, date) VALUES (3, 5, 4, 14, '2023-10-01');
-- Moderátor 7 banuje uživatele 6
INSERT INTO ban (id_ban, moderator_id_user, id_user, duration, date) VALUES (4, 7, 6, 3, '2024-02-05');
-- Moderátor 1 banuje uživatele 8
INSERT INTO ban (id_ban, moderator_id_user, id_user, duration, date) VALUES (5, 1, 8, 90, '2023-11-10');
-- Případný další ban od moderátora 1 na uživatele 5 (jen pro ukázku, není nutné pro D1)
-- INSERT INTO ban (id_ban, moderator_id_user, id_user, duration, date) VALUES (6, 1, 5, 5, '2024-03-01');


-- Nastavení sekvencí na správnou hodnotu (na základě nejvyššího vloženého ID + 1)
-- Pro tabulky se SERIAL/IDENTITY sloupci
SELECT setval(pg_get_serial_sequence('service_user', 'id_user'), COALESCE(MAX(id_user), 1), MAX(id_user) IS NOT NULL) FROM service_user;
SELECT setval(pg_get_serial_sequence('film', 'id_film'), COALESCE(MAX(id_film), 1), MAX(id_film) IS NOT NULL) FROM film;
SELECT setval(pg_get_serial_sequence('upload', 'id_upload'), COALESCE(MAX(id_upload), 1), MAX(id_upload) IS NOT NULL) FROM upload;
SELECT setval(pg_get_serial_sequence('event', 'id_event'), COALESCE(MAX(id_event), 1), MAX(id_event) IS NOT NULL) FROM event;
SELECT setval(pg_get_serial_sequence('ban', 'id_ban'), COALESCE(MAX(id_ban), 1), MAX(id_ban) IS NOT NULL) FROM ban;