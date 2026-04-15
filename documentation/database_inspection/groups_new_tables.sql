
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
    name varchar(255),
    description TEXT,
    fk_group_type INTEGER,
    notes text,
    wikidata_uri varchar(255),
    fk_source_entity integer,
    import_notes text
);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE elites_suisses.crm_group TO "hgb_editor";

ALTER TABLE elites_suisses.crm_group OWNER TO "hgb_editor";


ALTER TABLE elites_suisses.mandat ADD COLUMN fk_crm_group_organe INTEGER;

-- FOREIGN KEY 
alter table elites_suisses.mandat add constraint fk_crm_group_organe_fk foreign key (fk_crm_group_organe) 
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
ALTER TABLE elites_suisses.group_type OWNER TO "hgb_editor";
-- FOREIGN KEY 
alter table elites_suisses.crm_group add constraint fk_group_type_fk foreign key (fk_group_type) 
	references elites_suisses.group_type(pk_group_type);

