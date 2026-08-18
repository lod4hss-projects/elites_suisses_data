
/*
 * We use the view aggregating 
 */

-- canton parliaments
select *
from elites_suisses.v_groups_from_mandates
where m_organe ~* 'légis' 
and m_type_entite ~* 'can'
order by e_nom;

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif' and 
m_type_entite ~* 'can';



/*
 * entités et organes / organes dans les entités
 * crm:74 Group
*/

-- the table name avoids the reserved term 'group'
--drop table elites_suisses.sdh_group cascade;
CREATE TABLE elites_suisses.t_group (
    pk_group INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_standard varchar(255),
    na_st_language varchar(3),
    name_french varchar(255),
    name_original varchar(255),
    definition TEXT,
    fk_group_type INTEGER,
    notes text,
    wikidata_uri varchar(255),
    fk_source_entity integer,
    fk_part_of integer,
    fk_origin_of integer,
    import_notes text
);


-- 1. Create the new role (with login capability if needed)
CREATE ROLE hgb_editor WITH LOGIN PASSWORD 'ABCD';

-- 2. Grant permissions on all existing tables in the schema
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA elites_suisses TO hgb_editor;

-- 3. (Recommended) Grant usage on the schema itself
-- Without this, the role can't access the schema even if it has table permissions
GRANT USAGE ON SCHEMA elites_suisses TO hgb_editor;

-- 4. (Optional) Automate permissions for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA elites_suisses 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO hgb_editor;


ALTER TABLE new_table RENAME TO old_table;


SELECT last_value FROM elites_suisses.sdh_group_pk_sdh_group_seq1;
--SELECT setval('elites_suisses.sdh_group_pk_sdh_group_seq1', 566, true);ALTER TABLE new_table RENAME TO old_table;


SELECT last_value FROM elites_suisses.sdh_group_pk_sdh_group_seq1;
--SELECT setval('elites_suisses.sdh_group_pk_sdh_group_seq1', 566, true);


-- FOREIGN KEY 
alter table elites_suisses.sdh_group add constraint fk_source_entity_fk foreign key (fk_source_entity) 
	references elites_suisses.entites(id);


ALTER TABLE elites_suisses.sdh_group ADD COLUMN date_begin varchar(20);
ALTER TABLE elites_suisses.sdh_group ADD COLUMN date_end varchar(20);

ALTER TABLE elites_suisses.sdh_group RENAME COLUMN fk_origin_of TO fk_origin_from;

ALTER TABLE elites_suisses.mandat ADD COLUMN fk_sdh_group_organe INTEGER;

-- FOREIGN KEY 
alter table elites_suisses.mandat add constraint fk_sdh_group_organe_fk foreign key (fk_sdh_group_organe) 
	references elites_suisses.sdh_group(pk_sdh_group);


ALTER TABLE elites_suisses.mandat ADD COLUMN fk_sdh_group INTEGER;

-- FOREIGN KEY 
alter table elites_suisses.mandat add constraint fk_sdh_group_fk foreign key (fk_sdh_group) 
	references elites_suisses.sdh_group(pk_sdh_group);




-- FOREIGN KEY 
alter table elites_suisses.sdh_group add constraint fk_source_entity_fk foreign key (fk_source_entity) 
	references elites_suisses.entites(id);




drop table elites_suisses.group_type cascade;
CREATE TABLE elites_suisses.group_type (
    pk_group_type INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(255),
    description TEXT,
    notes text,
    wikidata_uri varchar(255),
    import_notes text
);

-- FOREIGN KEY 
alter table elites_suisses.sdh_group add constraint fk_group_type_fk foreign key (fk_group_type) 
	references elites_suisses.group_type(pk_group_type);




/*
 * Add foreign key to sdh_group from entities
 */

select m.entite, cg.name_standard, m.id, cg.pk_sdh_group 
from elites_suisses.v_sphere_academique m  
	join elites_suisses.sdh_group cg on cg.fk_source_entity = m.entities_id  

update elites_suisses.mandat m set fk_sdh_group = cg.pk_sdh_group 
from elites_suisses.sdh_group cg 
where cg.fk_source_entity = m.entities_id ;




--DROP TABLE elites_suisses.t_group_appellation;
CREATE TABLE elites_suisses.t_group_appellation (
	pk_group_appellation int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	fk_group integer null,
	appellation text NULL,
	appellation_language text NULL,
	date_begin TEXT NULL,
	date_end TEXT NULL,
	description text NULL,
	notes text NULL,
	import_notes text NULL,
	CONSTRAINT group_appellation_pkey PRIMARY KEY (pk_group_appellation),
	CONSTRAINT fk_group_fk FOREIGN KEY (fk_group) REFERENCES elites_suisses.t_group(pk_group)

);




-- DROP TABLE elites_suisses.t_group_follower;

CREATE TABLE elites_suisses.t_group_follower (
	pk_group_follower int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	sequence_type text null, -- add a type describing the kind of group sequence
	description text NULL,
	notes text NULL,
	fk_group_source int4 NULL,
	fk_group_target int4 NULL,
	import_notes text NULL,
	CONSTRAINT group_follower_pkey PRIMARY KEY (pk_group_follower),
	CONSTRAINT fk_group_source_fk FOREIGN KEY (fk_group_source) REFERENCES elites_suisses.t_group(pk_group),
	CONSTRAINT fk_group_target_fk FOREIGN KEY (fk_group_target) REFERENCES elites_suisses.t_group(pk_group)
);



