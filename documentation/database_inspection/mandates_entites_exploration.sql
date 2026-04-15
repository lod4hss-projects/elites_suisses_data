
/*
 * inspection
 */

SELECT *
FROM elites_suisses.mandat
LIMIT 100;

-- nombre de mandats: 112'471
SELECT count(*) number
FROM elites_suisses.mandat
LIMIT 100;

/*
 * First data cleaning, replace trailing spaces in names,
 * in view of simplifying queries
 */

update elites_suisses.mandat m set fonction =trim(fonction);

update elites_suisses.mandat m set entite =trim(entite);

update elites_suisses.mandat m set "typeEntite" =trim("typeEntite");

update elites_suisses.mandat m set "partiAffiliationOfficeSecteur" =trim("partiAffiliationOfficeSecteur");

/*
 * [March 2026, FB] I add the entity_id column as a column to be used as foreign key
 */

ALTER TABLE elites_suisses.mandat ADD COLUMN entities_id INTEGER;


select *
from elites_suisses.mandat m 
limit 10;

select m.*, e.*
from elites_suisses.mandat m 
	left join elites_suisses.entites e on e."idEntite" = m."idEntite" 
where e.nom != 'Worb'
and m."idEntite" is not null and m."idEntite" != ''
--and e."idEntite" is null or e."idEntite" = ''
limit 100;

-- added the values
update elites_suisses.mandat m set entities_id = e.id
from elites_suisses.entites e 
where e.nom != 'Worb'
and e."idEntite" = m."idEntite" 
and m."idEntite" is not null and m."idEntite" != '';


-- FOREIGN KEY 
alter table elites_suisses.mandat add constraint fk_entities foreign key (entities_id) 
	references elites_suisses.entites(id);


select *
from elites_suisses.mandat m 
where m.entite ~* 'Worb'
limit 10;

-- Worb id : 3291
select *
from elites_suisses.entites e
where e.nom  ~* 'Worb'
limit 10;

update elites_suisses.mandat m set entities_id = 3291
where m.entite ~* 'Worb';



/*
 * Missing links
 */


-- mandats sans entité correspondante dans la table entites
select m.*
from elites_suisses.mandat m 
where m.entities_id is null;

-- 7558
select count(*)
from elites_suisses.mandat m 
where m.entities_id is null;




/*
 * Inspection of 'mandates'
 */


--- distribution of functions
SELECT fonction, COUNT(*) as number
FROM elites_suisses.mandat m 
-- inconsistency of the data
-- add column and clean up
--where fonction ~* 'prof'
where fonction ~* 'avoc'
GROUP BY fonction
ORDER BY number DESC;




--- distribution of entitites' types
with tw1 as (
select m."typeEntite" AS type_entite
from elites_suisses.mandat m )
SELECT type_entite, COUNT(*) as number
FROM tw1
-- inconsistency of the data
-- add column and clean up
where type_entite~* 'Féd'
GROUP BY type_entite
ORDER BY number DESC;



--- distribution of organs

SELECT organe, COUNT(*) as number
FROM mandat
-- inconsistency of the data
-- add column and clean up
--where organe ~* 'comi'
GROUP BY organe
ORDER BY number DESC;




--- distribution of functions, types, organs
with tw1 as (
select fonction,organe,"typeEntite" AS type_entite,
case 
	when entities_id > 0 then 'avec_id_org'
	else 'sans_id_org'
end available_id
from elites_suisses.mandat m )
SELECT fonction, organe, type_entite, available_id, COUNT(*) as number
FROM tw1
-- identification of missing entities
where available_id !~ 'sans'
GROUP BY fonction, organe, type_entite, available_id
ORDER BY number DESC;



--- distribution of functions, types, organs
with tw1 as (
select fonction, organe,"typeEntite" AS type_entite,
case 
	when entities_id > 0 then 'avec_id_org'
	else 'sans_id_org'
end available_id,
m."idEntite" 
from elites_suisses.mandat m )
SELECT fonction, organe, type_entite, available_id, COUNT(*) as number, string_agg(distinct e.nom, '|') entities
FROM tw1
   left join elites_suisses.entites e on e."idEntite" =  tw1."idEntite" 
-- identification d'entités qui manquent
where available_id !~ 'sans'
GROUP BY fonction, organe, type_entite, available_id
ORDER BY number DESC;





-- inspection with filter on values
select *
from elites_suisses.mandat m
where m.fonction = 'Membre'
and m.organe = 'Exécutif'
and m."typeEntite" = 'Autorités cant.'
limit 50;


-- distribution of diverse entities
select m."partiAffiliationOfficeSecteur", COUNT(*) as number
FROM elites_suisses.mandat m
GROUP BY m."partiAffiliationOfficeSecteur"
ORDER BY number DESC;

-- which are present in the enties table? 
-- joined on name
with tw1 as (-- distribution of diverse entities
select m."partiAffiliationOfficeSecteur" nom, COUNT(*) as number
FROM elites_suisses.mandat m
GROUP BY m."partiAffiliationOfficeSecteur"
)
select tw1.nom, tw1."number", e.nom, e."idEntite", e."typeEntite"
from tw1
    left join elites_suisses.entites e on e.nom = tw1.nom
order by tw1."number" desc;





-- filtered query for R2RML test

select m."idIdentite", m.entite, m.entities_id, e.nom  
from elites_suisses.mandat m 
    join elites_suisses.entites e on e.id = m.entities_id
where m.fonction = 'Membre'
and m.entities_id > 0
offset 50
limit 10;






/*
 * Identification of new organisations
 * 
 * There are several organisations that are only implicit defined, 
 * notably as 'organs' of other
 * 
 */


--- distribution of entities, types, organs
with tw1 as (
select entite, organe,"typeEntite" AS type_entite,
case 
	when entities_id > 0 then 'avec_id_org'
	else 'sans_id_org'
end available_id,
m.entities_id, m.id
from elites_suisses.mandat m )
SELECT e.nom e_nom, e.id e_id, tw1.entite m_nom, type_entite m_type_entite, organe m_organe, 
	COUNT(*) as number, string_agg(tw1.id::text, ',') as m_ids
FROM tw1
   left join elites_suisses.entites e on e.id =  tw1.entities_id 
-- only identified entities
where available_id !~ 'sans'
GROUP BY nom, e.id, entite, organe, type_entite, available_id
ORDER BY number DESC;



-- this view represents organisations implicitly present in mandates
-- same query as above
drop view elites_suisses.v_groups_from_mandates;
create view elites_suisses.v_groups_from_mandates AS 
with tw1 as (
select entite, organe,"typeEntite" AS type_entite,
case 
	when entities_id > 0 then 'avec_id_org'
	else 'sans_id_org'
end available_id,
m.entities_id, m.id
from elites_suisses.mandat m )
SELECT e.nom e_nom, e.id e_id, tw1.entite m_nom, type_entite m_type_entite, organe m_organe, 
	COUNT(*) as number, string_agg(tw1.id::text, ',') as m_ids
FROM tw1
   left join elites_suisses.entites e on e.id =  tw1.entities_id 
-- only identified entities
where available_id !~ 'sans'
GROUP BY nom, e.id, entite, organe, type_entite, available_id
ORDER BY number DESC;

-- canton parliaments
select *
from elites_suisses.v_groups_from_mandates
where m_organe ~* 'gisla' 
and m_type_entite ~* 'can'
order by e_id;

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif' and 
m_type_entite ~* 'can'
order by e_nom;



select *
from elites_suisses.v_groups_from_mandates
where   ~* 'féd' ;


-- observe this data about
SELECT m.*
FROM elites_suisses.mandat AS m
WHERE "idIdentite"=50352;

SELECT m."idIdentite", count(*) as number
FROM elites_suisses.mandat AS m
group by "idIdentite" 
order by number desc;

SELECT m.*
FROM elites_suisses.mandat AS m
WHERE "idIdentite" in (SELECT m."idIdentite"
FROM elites_suisses.mandat AS m
group by "idIdentite" 
having count(*) > 30)
order by "idIdentite", m.sphere  ;





