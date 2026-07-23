
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
 * Social roles 
*/

--drop table  elites_suisses.social_role ;
CREATE TABLE elites_suisses.social_role (
    pk_social_role INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(255),
    description TEXT,
    notes text,
    wikidata_uri varchar(255),
    fk_crm_group integer, -- points to the group in which this function is defined
    fk_group_type integer, -- points to the type of group in which this function is defined
    fk_source_es_entity integer, -- points to the Elites suisses related entity
    import_notes text

);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE elites_suisses.social_role TO "hgb_editor";
ALTER TABLE elites_suisses.social_role OWNER TO "hgb_editor";



ALTER TABLE elites_suisses.mandat ADD COLUMN fk_social_role_fonction INTEGER;

-- FOREIGN KEY 
alter table elites_suisses.mandat add constraint fk_social_role_fonction_fk foreign key (fk_social_role_fonction) 
	references elites_suisses.social_role(pk_social_role);

-- FOREIGN KEY 
alter table elites_suisses.social_role add constraint fk_crm_group_fk foreign key (fk_crm_group) 
	references elites_suisses.crm_group (pk_crm_group);



/*
 * entités et organes / organes dans les entités
 * crm:74 Group
*/

-- the table name avoids the reserved term 'group'
--drop table elites_suisses.crm_group cascade;
CREATE TABLE elites_suisses.crm_group (
    pk_crm_group INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
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







-- FOREIGN KEY 
alter table elites_suisses.crm_group add constraint fk_source_entity_fk foreign key (fk_source_entity) 
	references elites_suisses.entites(id);






ALTER TABLE elites_suisses.mandat ADD COLUMN fk_crm_group_organe INTEGER;

-- FOREIGN KEY 
alter table elites_suisses.mandat add constraint fk_crm_group_organe_fk foreign key (fk_crm_group_organe) 
	references elites_suisses.crm_group(pk_crm_group);


ALTER TABLE elites_suisses.mandat ADD COLUMN fk_crm_group INTEGER;

-- FOREIGN KEY 
alter table elites_suisses.mandat add constraint fk_crm_group_fk foreign key (fk_crm_group) 
	references elites_suisses.crm_group(pk_crm_group);




-- FOREIGN KEY 
alter table elites_suisses.crm_group add constraint fk_source_entity_fk foreign key (fk_source_entity) 
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
alter table elites_suisses.crm_group add constraint fk_group_type_fk foreign key (fk_group_type) 
	references elites_suisses.group_type(pk_group_type);




/*
 * Add foreign key to crm_group from entities
 */

select m.entite, cg.name_standard, m.id, cg.pk_crm_group 
from elites_suisses.v_sphere_academique m  
	join elites_suisses.crm_group cg on cg.fk_source_entity = m.entities_id  

update elites_suisses.mandat m set fk_crm_group = cg.pk_crm_group 
from elites_suisses.crm_group cg 
where cg.fk_source_entity = m.entities_id ;
