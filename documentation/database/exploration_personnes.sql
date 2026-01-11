

-- Number of persons
-- December 2025 : 58729 


select count(*) as effectif
from elites_suisses_fdw.identite i ;


select count(*) as effectif
from elites_suisses.identite i ;


select i.*
from elites_suisses_fdw.identite i 
order by i.id 
limit 100;


/*
 * Gender
 */


select UPPER(i.sexe) gender, count(*) as effectif
from elites_suisses.identite i 
group by UPPER(i.sexe);


/*
 * Birth Cantons
 */


select UPPER(i."cantonNaissance") canton, count(*) as effectif
from elites_suisses.identite i 
group by UPPER(i."cantonNaissance")
order by effectif desc;
