/*
 * Data Exploration
 */

-- Not sure of the goal of this query
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

-- Count the number of empty values in the column gradMilitaryMax:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i."gradeMilitaireMax" IS NULL
   OR TRIM(i."gradeMilitaireMax") = '';

-- Count the number of Non values in the column gradMilitaryMax:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE LOWER(TRIM(i."gradeMilitaireMax")) = 'non'
   OR LOWER(TRIM(i."gradeMilitaireMax")) = 'non?'
   OR LOWER(TRIM(i."gradeMilitaireMax")) = '?'

-- Count the number of empty values in the column gradMilitaryMax, including the "Non"
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i."gradeMilitaireMax" IS NULL
   OR TRIM(i."gradeMilitaireMax") = ''
   OR LOWER(TRIM(i."gradeMilitaireMax")) = 'non'
   OR LOWER(TRIM(i."gradeMilitaireMax")) = 'non?'
   OR LOWER(TRIM(i."gradeMilitaireMax")) = '?'
;

-- The list of distinct values, with the frequency
select
	distinct i."gradeMilitaireMax",
	COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i."gradeMilitaireMax" is NOT NULL
   AND TRIM(i."gradeMilitaireMax") <> ''
   AND LOWER(TRIM(i."gradeMilitaireMax")) <> 'non'
   AND LOWER(TRIM(i."gradeMilitaireMax")) <> 'non?'
   AND LOWER(TRIM(i."gradeMilitaireMax")) <> '?'
group by "gradeMilitaireMax"
order by number_occurences desc;


