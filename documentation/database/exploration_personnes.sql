

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

select trim(UPPER(i."cantonNaissance")) canton, count(*) as effectif
from elites_suisses.identite i 
group by trim(UPPER(i."cantonNaissance"))
order by effectif desc;



/*
 * Birth Place
 */

select trim(lower(i."lieuNaissance")) canton, count(*) as effectif
from elites_suisses.identite i 
group by trim(lower(i."lieuNaissance"))
order by effectif desc;


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



/*
 * Military position
 */

select 
 case 
 	when position('/' in i."gradeMilitaireMax") > 0
 	then trim(lower(SPLIT_PART(i."gradeMilitaireMax", '/', 1)))
 	else trim(lower(i."gradeMilitaireMax"))
 end grade, 
i."gradeMilitaireMax"
from elites_suisses.identite i ;

with tw1 as (
select 
 case 
 	when position('/' in i."gradeMilitaireMax") > 0
 	then trim(lower(SPLIT_PART(i."gradeMilitaireMax", '/', 1)))
 	else trim(lower(i."gradeMilitaireMax"))
 end grade, 
i."gradeMilitaireMax"
from elites_suisses.identite i 
)
select grade, count(*) as effectif
from tw1
group by grade
order by effectif desc;


SELECT SPLIT_PART('capitaine/captain', '/', 1);




/*
 * Profession
 */

select count(*)
from elites_suisses.identite i 
--where length(i.profession ) < 2
where trim(i.profession) = '';

select trim(lower(i.profession)) profession, count(*) as effectif
from elites_suisses.identite i 
group by trim(lower(i.profession))
order by effectif desc;

