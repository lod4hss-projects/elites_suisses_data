

/*
 * inspection
 */


select count(*) as effectif
from elites_suisses.entites e   ;


select count(*) as effectif
from elites_suisses.entites e
where e.nom is null or e.nom = '' or length(e.nom)< 3;


select e.*
from  elites_suisses.entites e
where e.nom is null or e.nom = '' or length(e.nom)< 3
order by id 
LIMIT 50;

select e.entity_id, e."typeEntite", e.nom 
from  elites_suisses.entites e
where e.nom is null or e.nom = '' or length(e.nom)< 3
order by id 
LIMIT 50;


select t1.*
from  elites_suisses.entites t1
order by nom
LIMIT 50;



/*
 * First data cleaning, replace trailing spaces in names,
 * in view of simplifying queries
 */

update elites_suisses.entites e set sphere =trim(sphere);

update elites_suisses.entites e set nom =trim(nom);

update elites_suisses.entites e set "typeEntite" =trim("typeEntite");


-- add column with entity ids as integers
-- all

alter table elites_suisses.entites add column entity_id integer;

update elites_suisses.entites
set entity_id =(replace("idEntite", 'entite', ''))::integer
where length("idEntite" ) > 6 ;

select entity_id
from elites_suisses.entites
limit 10;




-- pas de doubons, apparemment
select t1.id, count(*) as effectif
from elites_suisses.entites t1
group by t1.id
HAVING count(*) > 1
order by effectif desc
limit 50;


-- inspect entities types
select e."typeEntite", count(*) as n
from elites_suisses.entites e 
group by  e."typeEntite" 
order by n desc;

select *
from elites_suisses.entites e 
where e."typeEntite" is null or e."typeEntite"=''
;

-- inspect sphere
select sphere, count(*) as n
from elites_suisses.entites e 
group by e.sphere
order by n desc;





-- sphere and type
select e.sphere, e."typeEntite", count(*) as n
from elites_suisses.entites e 
group by e.sphere, e."typeEntite" 
order by e.sphere, n desc;


/*
 * Compare entity types in table entities and mandates
 * 
 * Quite a mess ?
 */

-- inspect entities types
select e."typeEntite" type_e_entite, m."typeEntite" type_e_mandat, count(*) as n
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
group by  e."typeEntite", m."typeEntite"
order by  e."typeEntite", m."typeEntite";
--order by n desc;
order by n desc;



/*
 * Issue with organisations that cover many different groups
 */

select *
from elites_suisses.entites e 
where e.nom ~ 'TI';

select *
from elites_suisses.entites e 
where e.nom = 'TI';

select e."idEntite", e.nom, e."typeEntite", m."typeEntite", m.organe, m.fonction, m."partiAffiliationOfficeSecteur" 
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
where e.nom = 'TI'
limit 100;

/* 
 * in fact there are at least two groups: legislative, executive, sometimes judiciary
 * 
 * the kind of group is availabel in the 'organe' field of the _mandat_ table
 */
select e."idEntite", e.nom, m.organe, count(*) as number
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
where e.nom = 'TI'
group by e."idEntite", e.nom, m.organe;


select e."idEntite", e.nom, lower(m.organe) organe, count(*) as number
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
where e.nom = 'ZH'
group by e."idEntite", e.nom, lower(m.organe);

--
select e."idEntite", e.nom, lower(m.organe) organe, count(*) as number
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
where e.nom = 'BE'
group by e."idEntite", e.nom, lower(m.organe);











