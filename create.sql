-- odeberu pokud existuje funkce na oodebrání tabulek a sekvencí
DROP FUNCTION IF EXISTS remove_all();

-- vytvořím funkci která odebere tabulky a sekvence
-- chcete také umět psát PLSQL? Zapište si předmět BI-SQL ;-)
CREATE or replace FUNCTION remove_all() RETURNS void AS $$
DECLARE
    rec RECORD;
    cmd text;
BEGIN
    cmd := '';

    FOR rec IN SELECT
            'DROP SEQUENCE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace
        WHERE
            relkind = 'S' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    FOR rec IN SELECT
            'DROP TABLE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace WHERE relkind = 'r' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    EXECUTE cmd;
    RETURN;
END;
$$ LANGUAGE plpgsql;
-- zavolám funkci co odebere tabulky a sekvence - Mohl bych dropnout
--celé schéma a znovu jej vytvořit, použíjeme však PLSQL
select remove_all();

-- Remove conflicting tables
DROP TABLE IF EXISTS ban CASCADE;
DROP TABLE IF EXISTS download CASCADE;
DROP TABLE IF EXISTS event CASCADE;
DROP TABLE IF EXISTS film CASCADE;
DROP TABLE IF EXISTS moderator CASCADE;
DROP TABLE IF EXISTS service_user CASCADE;
DROP TABLE IF EXISTS subscription CASCADE;
DROP TABLE IF EXISTS upload CASCADE;
DROP TABLE IF EXISTS view CASCADE;
-- End of removing

CREATE TABLE ban (
    id_ban SERIAL NOT NULL,
    moderator_id_user INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    duration INTEGER NOT NULL,
    date DATE NOT NULL,
    -- IO1: moderátor nemůže dát sobě ban
    CONSTRAINT chk_moderator_cannot_ban_self CHECK (moderator_id_user <> id_user)
);
ALTER TABLE ban ADD CONSTRAINT pk_ban PRIMARY KEY (id_ban);

CREATE TABLE download (
    id_event INTEGER NOT NULL,
    duration INTEGER NOT NULL
);
ALTER TABLE download ADD CONSTRAINT pk_download PRIMARY KEY (id_event);

CREATE TABLE event (
    id_event SERIAL NOT NULL,
    id_upload INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    date DATE NOT NULL
);
ALTER TABLE event ADD CONSTRAINT pk_event PRIMARY KEY (id_event);

CREATE TABLE film (
    id_film SERIAL NOT NULL,
    name VARCHAR(256) NOT NULL,
    genre VARCHAR(256) NOT NULL,
    country VARCHAR(256) NOT NULL,
    release_date DATE NOT NULL
);
ALTER TABLE film ADD CONSTRAINT pk_film PRIMARY KEY (id_film);

CREATE TABLE moderator (
    id_user INTEGER NOT NULL,
    start_date DATE NOT NULL,
    country VARCHAR(256)
);
ALTER TABLE moderator ADD CONSTRAINT pk_moderator PRIMARY KEY (id_user);

CREATE TABLE service_user (
    id_user SERIAL NOT NULL,
    registration_date DATE NOT NULL,
    nickname VARCHAR(256) NOT NULL
);
ALTER TABLE service_user ADD CONSTRAINT pk_service_user PRIMARY KEY
(id_user);
ALTER TABLE service_user ADD CONSTRAINT uc_service_user_nickname UNIQUE
(nickname);

CREATE TABLE subscription (
    id_user INTEGER NOT NULL,
    end_date DATE NOT NULL
);
ALTER TABLE subscription ADD CONSTRAINT pk_subscription PRIMARY KEY
(id_user);

CREATE TABLE upload (
    id_upload SERIAL NOT NULL,
    id_film INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    size VARCHAR(256) NOT NULL,
    quality VARCHAR(256) NOT NULL,
    -- IO2: atribut quality u uploadu může mít pouze hodnoty HD, FullHD nebo 4K
    CONSTRAINT chk_upload_quality CHECK (quality IN ('HD', 'FullHD', '4K'))
);
ALTER TABLE upload ADD CONSTRAINT pk_upload PRIMARY KEY (id_upload);

CREATE TABLE view (
    id_event INTEGER NOT NULL,
    duration INTEGER NOT NULL
);
ALTER TABLE view ADD CONSTRAINT pk_view PRIMARY KEY (id_event);

ALTER TABLE ban ADD CONSTRAINT fk_ban_moderator FOREIGN KEY
(moderator_id_user) REFERENCES moderator (id_user) ON DELETE CASCADE;
ALTER TABLE ban ADD CONSTRAINT fk_ban_service_user FOREIGN KEY (id_user)
 REFERENCES service_user (id_user) ON DELETE CASCADE;

ALTER TABLE download ADD CONSTRAINT fk_download_event FOREIGN KEY
(id_event) REFERENCES event (id_event) ON DELETE CASCADE;

ALTER TABLE event ADD CONSTRAINT fk_event_upload FOREIGN KEY (id_upload)
 REFERENCES upload (id_upload) ON DELETE CASCADE;
ALTER TABLE event ADD CONSTRAINT fk_event_service_user FOREIGN KEY
(id_user) REFERENCES service_user (id_user) ON DELETE CASCADE;

ALTER TABLE moderator ADD CONSTRAINT fk_moderator_service_user FOREIGN
KEY (id_user) REFERENCES service_user (id_user) ON DELETE CASCADE;

ALTER TABLE subscription ADD CONSTRAINT fk_subscription_service_user
FOREIGN KEY (id_user) REFERENCES service_user (id_user) ON DELETE
CASCADE;

ALTER TABLE upload ADD CONSTRAINT fk_upload_film FOREIGN KEY (id_film)
REFERENCES film (id_film) ON DELETE CASCADE;
ALTER TABLE upload ADD CONSTRAINT fk_upload_service_user FOREIGN KEY
(id_user) REFERENCES service_user (id_user) ON DELETE CASCADE;

ALTER TABLE view ADD CONSTRAINT fk_view_event FOREIGN KEY (id_event)
REFERENCES event (id_event) ON DELETE CASCADE;