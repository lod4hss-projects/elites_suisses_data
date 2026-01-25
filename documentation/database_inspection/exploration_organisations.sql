

/*
 * inspection
 */


select count(*) as effectif
from elites_suisses.entites e   ;



select t1.*
from  elites_suisses.entites t1
order by id 
LIMIT 50;


/*
 * First data cleaning, replace trailing spaces in names,
 * in view of simplifying queries
 */

update elites_suisses.entites e set sphere =trim(sphere);

update elites_suisses.entites e set nom =trim(nom);

update elites_suisses.entites e set "typeEntite" =trim("typeEntite");


-- pas de doubons, apparemment
select t1.id, count(*) as effectif
from elites_suisses.entites t1
group by t1.id
HAVING count(*) > 1
order by effectif desc
limit 50;




select e.sphere, e."typeEntite", count(*) as n
from elites_suisses.entites e 
group by e.sphere, e."typeEntite" 
order by e.sphere, n desc;





/*
 * mandats
 */


