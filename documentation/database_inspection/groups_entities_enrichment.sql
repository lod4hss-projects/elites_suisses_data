
/*
 * We use the view aggregating 
 */

-- canton parliaments
select *
from elites_suisses.v_groups_from_mandates
where m_organe ~* 'légis' 
and m_type_entite ~* 'can'
order by e_nom;






/*
 * entités et organes / organes dans les entités
 * crm:74 Group
*/

select *
from elites_suisses.crm_group ;




/*
 * Social roles 
*/

select * 
from elites_suisses.social_role;



/*
 * canton governments
 */

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif' and
length(e_nom) > 2 and
m_type_entite ~* 'can';

select *
from elites_suisses.mandat m 
where organe ~* 'cutif' and
length(entite) > 2 and
m."typeEntite" ~* 'can';

select distinct e_id, concat(e'Conseil d\'État du canton ', e_nom), e_nom
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif' and 
m_type_entite ~* 'can'
and e_nom !~ 'orpa'
and e_nom !~ 'ossa'
and e_nom !~ 'uri'
order by e_nom;


--insert into elites_suisses.crm_group ("name", description, import_notes)
select distinct concat(e'Conseil d\'État du canton ', e_nom) nom, concat(e'Conseil d\'État du canton ', e_nom),  '20260415_imp1'
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif' and 
m_type_entite ~* 'can'
and e_nom !~ 'orpa'
and e_nom !~ 'ossa'
and e_nom !~ 'uri'
order by nom;



--insert into elites_suisses.crm_group ("name", description, fk_source_entity, import_notes)
select distinct concat(e'Canton ', e_nom), concat(e'Canton ', e_nom),
e_id, '20260415_imp2'
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif'
and m_type_entite ~* 'can'
and length(e_nom) = 2;



/*
 * canton parlaments
 */

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'gislati' and
length(e_nom) > 2 and
m_type_entite ~* 'can';

select *
from elites_suisses.mandat m 
where organe ~* 'gislati' and
length(entite) > 2 and
m."typeEntite" ~* 'can';

select distinct e_id, concat(e'Parlement cantonal du Canton de ', e_nom), e_nom
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'gislati' 
and  m_type_entite ~* 'can'
and length(e_nom) = 2
order by e_nom;


--insert into elites_suisses.crm_group ("name", description, fk_source_entity, import_notes, fk_group_type)
select distinct concat(e'Parlement cantonal du Canton de ', e_nom) nom, concat(e'Législatif du canton ', e_nom),
'20260415_imp3', 3
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'gislati' 
and  m_type_entite ~* 'can'
and length(e_nom) = 2
order by nom;


--insert into elites_suisses.crm_group ("name", description, fk_source_entity, import_notes)
select distinct concat(e'Canton ', e_nom), concat(e'Canton ', e_nom),
e_id, '20260415_imp2'
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif'
and m_type_entite ~* 'can'
and length(e_nom) = 2;




/*
 * Add missing entities to groups
 */
select * 
from elites_suisses.entites e
limit 100;

select distinct e.nom, e."typeEntite", e. , cg.name_standard, cg.name_original, cg.fk_source_entity 
from elites_suisses.entites e
   left join elites_suisses.crm_group cg on e.id = cg.fk_source_entity     
order by e.nom ; 



select *
from elites_suisses.crm_group cg 
order by cg.pk_crm_group ;



/*
 * 
 * Import from table coming from OpenRefine alignment
 * by Stefan Kessler
 * 

select *
from elites_suisses.sk_crm_group_matched sk, elites_suisses.crm_group cg 
where cg.pk_crm_group = sk.pk_crm_group 
and cg.wikidata_uri is null;

update elites_suisses.crm_group cg set notes = sk.notes_sk, wikidata_uri = sk.wikidata_uri 
from elites_suisses.sk_crm_group_matched sk
where cg.pk_crm_group = sk.pk_crm_group ;

* the imported table was deleted after update
*/



/*
 * insert missing entities into crm_group
 * we will clean up in the crm_group table
 */

select e.nom, e.id 
from elites_suisses.entites e 
	left join elites_suisses.crm_group cg 
	on cg.fk_source_entity = e.id
where cg.pk_crm_group is null	
order by e.nom ;

with tw1 as (select e.nom, e.id 
from elites_suisses.entites e 
	left join elites_suisses.crm_group cg 
	on cg.fk_source_entity = e.id
where cg.pk_crm_group is null)
--insert into elites_suisses.crm_group (name_original, fk_source_entity, name_standard, name_french , na_st_language, import_notes)
select nom, id, nom, nom, 'fr', '20260724_imp1'
where pk_crm_group > 567;
from tw1;



/*
 * Import dates
 */

select cg.pk_crm_group, e."dateCreation", e."dateDisparition" 
from elites_suisses.crm_group cg
		join elites_suisses.entites e on cg.fk_source_entity = e.id
where (length(e."dateCreation") > 0 or length(e."dateDisparition" ) > 0)
order by cg.pk_crm_group 
limit 100;

--update elites_suisses.crm_group cg set date_begin = e."dateCreation", 
	date_end = e."dateDisparition" 
from elites_suisses.entites e 
where cg.fk_source_entity = e.id
and (length(e."dateCreation") > 0 or length(e."dateDisparition" ) > 0);

select *
from elites_suisses.crm_group cg
order by cg.pk_crm_group 
limit 100;



--create view elites_suisses.v_crm_group_with_types as
select cg.pk_crm_group, e.id, cg.name_standard, cg.date_begin, cg.date_end, 
		cg.fk_part_of, cg_po.name_standard name_parent, cg.fk_group_type ,
		e.sphere, e."typeEntite", e."affiliationSecteurType"
from elites_suisses.crm_group cg
		left join elites_suisses.entites e on cg.fk_source_entity = e.id
		left join elites_suisses.crm_group cg_po on cg_po.pk_crm_group = cg.fk_part_of 
order by cg.pk_crm_group ;	


select *
from elites_suisses.v_crm_group_with_types
offset 565;



--update elites_suisses.v_crm_group_with_types set date_begin = null, date_end = null;



-- function for UPDATE
CREATE OR REPLACE FUNCTION elites_suisses.v_crm_group_with_types_update()
RETURNS TRIGGER AS $$
BEGIN
    -- Update the main table: crm_group
    UPDATE elites_suisses.crm_group
    SET 
        name_standard = NEW.name_standard,
        date_begin = NEW.date_begin,
        date_end = NEW.date_end,
        fk_part_of = NEW.fk_part_of,
        fk_group_type = NEW.fk_group_type
        -- Add fk_source_entity update if exposed in view
    WHERE pk_crm_group = OLD.pk_crm_group;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger for UPDATE
CREATE TRIGGER trg_v_crm_group_with_types_update
INSTEAD OF UPDATE ON elites_suisses.v_crm_group_with_types
FOR EACH ROW EXECUTE FUNCTION elites_suisses.v_crm_group_with_types_update();

-- verify tregger existence
SELECT 
    trigger_name, 
    event_manipulation, 
    event_object_table
FROM information_schema.triggers
WHERE event_object_table = 'v_crm_group_with_types' -- Use your view name here
  AND trigger_schema = 'elites_suisses';
