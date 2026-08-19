-- List all entries in identite table:
SELECT COUNT (*)
FROM elites_suisses.identite i  ;
-- = 58729

/*
 * PhD
 */

select trim(lower(i."formationDoctorat")) canton, count(*) as effectif
from elites_suisses.identite i 
group by trim(lower(i."formationDoctorat"))
order by effectif desc;


/*
 * University Degree or Training
 */

select trim(lower(i."formationUniversitaire")) canton, count(*) as effectif
from elites_suisses.identite i 
group by trim(lower(i."formationUniversitaire"))
order by effectif desc;