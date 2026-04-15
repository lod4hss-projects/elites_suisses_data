

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
order by nom
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

/*
 * Issue of having a primary key 
 * for foreign key references from other tables
 * 
 * Note that the education table refers to the 'id' column
 * while the mandates table refers to the "idEntite" column
 * 
 */

-- pas de doubons
select t1.id, count(*) as effectif
from elites_suisses.entites t1
group by t1.id
HAVING count(*) > 1
order by effectif desc
limit 5;

select *
from elites_suisses.entites t1
where t1.id is null or t1.id = 0;

-- the column 'id' is therefore used as the primary key of the entities tables




-- trois sans idEntité : Worb, trois versions
-- sinon pas de entités multiples
select t1."idEntite", count(*) as effectif
from elites_suisses.entites t1
group by t1."idEntite"
HAVING count(*) > 1
order by effectif desc
limit 50;

select *
from elites_suisses.entites t1
where t1.nom = 'Worb';


-- max:3937
select max(e.entity_id )
from elites_suisses.entites e 

-- new identifiers from 10001

update elites_suisses.entites t1
set entity_id = 10001
where t1."idEntite" = '';

select *
from elites_suisses.entites t1
where entity_id = 10001;


select *
-- delete 
from elites_suisses.entites t1
where entity_id = 10001
and t1."versionDate"::text < '2024';

-- Create the sequence starting at 10002
CREATE SEQUENCE elites_suisses.entites_entity_id_seq START WITH 10002;

-- Set the column default to the next value from the sequence
ALTER TABLE elites_suisses.entites 
ALTER COLUMN entity_id SET DEFAULT nextval('elites_suisses.entites_entity_id_seq');

-- Add the primary key constraint
ALTER TABLE elites_suisses.entites  
ADD PRIMARY KEY (entity_id);

-- Optional: Link the sequence to the column so it drops automatically if the column is dropped
ALTER SEQUENCE table_name_column_name_seq OWNED BY table_name.column_name;


/*
 * inspect entities types
 */



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
-- requête important pour inspection
select e.sphere, e."typeEntite", count(*) as n, string_agg(distinct nom, '; ')
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











