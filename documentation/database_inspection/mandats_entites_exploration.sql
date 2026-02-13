
/*
 * inspection
 */

SELECT *
FROM elites_suisses.mandat
LIMIT 100;

SELECT count(*) number
FROM elites_suisses.mandat
LIMIT 100;

/*
 * First data cleaning, replace trailing spaces in names,
 * in view of simplifying queries
 */

update mandat m set fonction =trim(fonction);

update mandat m set entite =trim(entite);

update mandat m set "typeEntite" =trim("typeEntite");

update mandat m set "partiAffiliationOfficeSecteur" =trim("partiAffiliationOfficeSecteur");



-- mandats sans entité correspondante dans la table entites
select e."idEntite", m.*
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null;

select count(*) as n
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null;


-- entities without corresponding row in the 'entities' table
select m.entite_id, m.entite, count(*) as n, m."idEntite"
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null
group by m.entite_id, m."idEntite", m.entite
order by n desc;




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
	when entite_id > 0 then 'avec_id_org'
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
	when entite_id > 0 then 'avec_id_org'
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

select m."idIdentite", m.entite, e.entity_id, e.nom  
from elites_suisses.mandat m 
    join elites_suisses.entites e on e.entity_id = m.entite_id 
where m.fonction = 'Membre'
and m.entite_id > 0
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
	when entite_id > 0 then 'avec_id_org'
	else 'sans_id_org'
end available_id,
m."idEntite" 
from elites_suisses.mandat m )
SELECT e.nom, e."idEntite", tw1.entite,  type_entite, organe, COUNT(*) as number
FROM tw1
   left join elites_suisses.entites e on e."idEntite" =  tw1."idEntite" 
-- only identified entities
where available_id !~ 'sans'
GROUP BY nom, e."idEntite", entite, organe, type_entite, available_id
ORDER BY number DESC;



-- this view represents organisations implicitly present in mandates
drop view elites_suisses.v_groups_from_mandates;
create view elites_suisses.v_groups_from_mandates AS 
with tw1 as (
select entite, organe,"typeEntite" AS type_entite,
case 
	when entite_id > 0 then 'avec_id_org'
	else 'sans_id_org'
end available_id,
m."idEntite" 
from elites_suisses.mandat m )
SELECT e.nom, e."idEntite", tw1.entite,  type_entite, organe, COUNT(*) as number
FROM tw1
   left join elites_suisses.entites e on e."idEntite" =  tw1."idEntite" 
-- only identified entities
where available_id !~ 'sans'
GROUP BY nom, e."idEntite", entite, organe, type_entite, available_id
ORDER BY number DESC;

-- canton parliaments
select *
from elites_suisses.v_groups_from_mandates
where organe ~* 'légis' 
and type_entite ~* 'can';

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where 
organe ~* 'cutif' and 
type_entite ~* 'can';



select *
from elites_suisses.v_groups_from_mandates
where type_entite ~* 'féd' ;


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





