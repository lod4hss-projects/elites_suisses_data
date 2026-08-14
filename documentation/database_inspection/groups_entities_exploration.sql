

/*
 * inspection
 */


select count(*) as effectif
from elites_suisses.entites e   ;



-- entities with empty or very short name
select count(*) as effectif
from elites_suisses.entites e
where e.nom is null or e.nom = '' or length(e.nom)< 3;

select e.*
from  elites_suisses.entites e
where e.nom is null or e.nom = '' or length(e.nom)< 3
order by nom
LIMIT 50;


-- entity types
select e.id, e."typeEntite", e.nom 
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

-- test if unique objects
select t1.id, count(*) as effectif
from elites_suisses.entites t1
group by t1.id
HAVING count(*) > 1
order by effectif desc
limit 5;

-- no row without 'id' value
-- the column 'id' will be used as the primary key of the entities tables
select *
from elites_suisses.entites t1
where t1.id is null or t1.id = 0;



-- rows without 'idEntite' : Worb
select *
from elites_suisses.entites t1
where t1."idEntite" is null or length(t1."idEntite") < 1
limit 50;

select *
from elites_suisses.entites t1
where t1.nom = 'Worb';



-- no multiple rows for 'idEntite'
select t1."idEntite", count(*) as effectif
from elites_suisses.entites t1
group by t1."idEntite"
HAVING count(*) > 1
order by effectif desc
limit 50;




/*
 * Issue with organisations that cover different organisations-groups
 * 
 * The queries in this document "database_inspection/groups_additional_entities.sql" show 
 * that serveral political entities, like parlaments and governements of cantons, 
 * are not explicitely defined but just appear in the "organe" column of the mandates table.
 * E.g. : Swiss cantons are identified but in the Grand Conseil ou Gouvernement cantonal are not
 * 
 */


