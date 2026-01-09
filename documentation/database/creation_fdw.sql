SELECT * 
FROM pg_extension;



select *
from pg_available_extensions;



/*
 * Dans le container de PostgreSQL, importer l'extension pour le mysql-fdw


-- mettre à jour la liste des paquets

$ apt-get update
$ apt-get install postgresql-18-mysql-fdw

-- pour tester la connexion avec la BD MySQL
$ apt-get install -y dnsutils telnet
$ nslookup mariadb


Noter que les deux applications, donc les deux containers doivent se trouver sur le même réseau interne docker.
D'où le fait que on ajoute au docker run pour créer les deux conteneurs (postgresl et mariadb) le paramètre:
  --network myapp-net
pour disposer du même réseau commun myapp-net.

Pour les ports bien ajouter par ex. -p 5432:5432 et ajouter plusieurs -p pour même docker avec différentes applications:
docker run -p <host_port1>:<container_port1> -p <host_port2>:<container_port2>
 * 
 */


CREATE EXTENSION mysql_fdw;


SELECT * 
FROM pg_extension;


DROP SERVER mysql_server CASCADE;

CREATE SERVER mysql_server FOREIGN DATA WRAPPER mysql_fdw OPTIONS (host 'mariadb', port '3306');


CREATE USER MAPPING FOR postgres SERVER mysql_server OPTIONS (username 'root', password 'cle_root');

-- in mysql schema = database
IMPORT FOREIGN SCHEMA elites_suisses
--LIMIT TO (identite, filiation)
FROM SERVER mysql_server INTO elites_suisses_fdw;



--ERROR: primary key constraints are not supported on foreign tables



/*
 * Copy all foreign tables to real tables
 * using this PLpgSQL script
 */

DO $$
DECLARE
    r RECORD;
    sql TEXT;
    local_schema TEXT := 'elites_suisses'; -- You can change this
BEGIN
    -- Create local schema if not exists
    EXECUTE format('CREATE SCHEMA IF NOT EXISTS %I', local_schema);

    -- Loop through all tables in elites_suisses_fdw
    FOR r IN
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'elites_suisses_fdw'
          AND table_type = 'FOREIGN'
    LOOP
        -- Create local table as copy of foreign table
        sql := format('CREATE TABLE %I.%I AS SELECT * FROM elites_suisses_fdw.%I;', local_schema, r.table_name, r.table_name);
        RAISE NOTICE 'Creating local table: %', sql;
        EXECUTE sql;

        -- Optional: Add primary key if known (you may need to customize this)
        -- Example: if you know 'id' is PK for all tables
        -- BEGIN
        --     EXECUTE format('ALTER TABLE %I.%I ADD PRIMARY KEY (id);', local_schema, r.table_name);
        -- EXCEPTION WHEN undefined_column THEN
        --     RAISE NOTICE 'No id column in %, skipping PK', r.table_name;
        -- END;
    END LOOP;

    RAISE NOTICE '✅ All foreign tables copied to schema "%".', local_schema;
END $$;


/*
 * Add the foreign keys
 */

ALTER TABLE elites_suisses.identite ADD CONSTRAINT pk_identite_id PRIMARY KEY (id);

ALTER TABLE elites_suisses.education ADD CONSTRAINT fk_education_identite_id FOREIGN KEY ("ID_IDENTITE") REFERENCES elites_suisses.identite(id);
ALTER TABLE elites_suisses.education ADD CONSTRAINT fk_dir_these_identite_id FOREIGN KEY ("THÈSE_Directeur_IdIdentité") REFERENCES elites_suisses.identite(id);


ALTER TABLE elites_suisses.filiations ADD CONSTRAINT fk_fils_identite_id FOREIGN KEY ("idFils") REFERENCES elites_suisses.identite(id);
ALTER TABLE elites_suisses.filiations ADD CONSTRAINT fk_parent_identite_id FOREIGN KEY ("idParent") REFERENCES elites_suisses.identite(id);

ALTER TABLE elites_suisses.mariage ADD CONSTRAINT fk_mari_identite_id FOREIGN KEY ("idMari") REFERENCES elites_suisses.identite(id);
ALTER TABLE elites_suisses.mariage ADD CONSTRAINT fk_femme_identite_id FOREIGN KEY ("idFemme") REFERENCES elites_suisses.identite(id);


ALTER TABLE elites_suisses.identifier ADD CONSTRAINT fk_identifier_identite_id FOREIGN KEY ("zkf_ID_linked") REFERENCES elites_suisses.identite(id);


ALTER TABLE elites_suisses.mandat
ADD COLUMN entite_id INTEGER DEFAULT 0;

UPDATE elites_suisses.mandat
SET entite_id =  NULLIF(regexp_replace("idEntite", '[^0-9]', '', 'g'), '')::INTEGER;

ALTER TABLE elites_suisses.mandat ADD CONSTRAINT fk_mandat_identite_id FOREIGN KEY ("idIdentite") REFERENCES elites_suisses.identite(id);


ALTER TABLE elites_suisses.entites ADD CONSTRAINT pk_entite_id PRIMARY KEY (id);


/*
 * Manquent un certain nombre 
 * 
 * SQL Error [23503]: ERROR: insert or update on table "mandat" violates foreign key constraint "fk_mandat_entite_id"
  Detail: Key (entite_id)=(650) is not present in table "entites".
  */
select *
from elites_suisses_fdw.mandat where "idEntite" ='entite650';

select *
from elites_suisses.mandat where entite_id in (650, 3931, 3934, 3933, 2095);

select
from elites_suisses.identite i 
where i.id in (650, 3931, 3933, 3934, 2095);

-- mandats sans entité
select m.*
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null;

select count(*) as n
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null;


-- entités manquantes
select m.entite_id, m.entite, count(*) as n, m."idEntite"
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null
group by m.entite_id, m."idEntite", m.entite
order by n desc;


--delete from elites_suisses.mandat where entite_id in (650, 3931, 3933, 3934, 2095);


-- pas possible tant qu'il y a des entités manquantes
ALTER TABLE elites_suisses.mandat ADD CONSTRAINT fk_mandat_entite_id FOREIGN KEY (entite_id) REFERENCES elites_suisses.entites(id);







-- Autres noms des entités

ALTER TABLE elites_suisses."autresNomsEntites" 
ADD COLUMN entite_id INTEGER DEFAULT 0;

UPDATE elites_suisses."autresNomsEntites"
SET entite_id =  NULLIF(regexp_replace("idEntite", '[^0-9]', '', 'g'), '')::INTEGER;


select count(*) as n
from elites_suisses."autresNomsEntites" m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null;


-- entités manquantes
select m.entite_id, m."autreNom", count(*) as n, m."idEntite"
from elites_suisses."autresNomsEntites" m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null
group by m.entite_id, m."idEntite", m."autreNom"
order by n desc;



ALTER TABLE elites_suisses."autresNomsEntites" ADD CONSTRAINT fk_autre_noms_entite_id FOREIGN KEY (entite_id) REFERENCES elites_suisses.entites(id);



/*
 * Produce markdown tables list
 */

DO $$
DECLARE
    r RECORD;
    md TEXT;
    tbl_comment TEXT;
BEGIN
    RAISE NOTICE '# Schema: elites_suisses';
    RAISE NOTICE '';

    FOR r IN
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'elites_suisses'
          AND table_type = 'BASE TABLE'
        ORDER BY table_name
    LOOP
        -- Get table comment
        SELECT obj_description(c.oid, 'pg_class')
        INTO tbl_comment
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE n.nspname = 'elites_suisses'
          AND c.relname = r.table_name;

        RAISE NOTICE '';
        RAISE NOTICE '### %', r.table_name;
        IF tbl_comment IS NOT NULL THEN
            RAISE NOTICE '%', tbl_comment;
        END IF;

        md := format(
            '| Column Name | Data Type | %s | %s | %s |%s' ||
            '|-------------|-----------|------|------|------|%s' ||
            '%s',
            ' ', ' ', ' ', E'\n',
            E'\n',
            (
                SELECT string_agg(
                    format('| %s | %s | %s | %s | %s |', 
                        column_name, 
                        data_type, 
                        ' ', ' ', ' '
                    ),
                    E'\n'
                )
                FROM information_schema.columns
                WHERE table_schema = 'elites_suisses'
                  AND table_name = r.table_name
                ORDER BY ordinal_position
            )
        );

        RAISE NOTICE '%', md;
    END LOOP;
END $$;



