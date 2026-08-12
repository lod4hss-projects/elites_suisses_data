-- List all entries in identite table:
SELECT COUNT (*)
FROM elites_suisses.identite i  ;
-- = 58729

-- Count the number of dates in the naissance column:
SELECT COUNT(*)
FROM elites_suisses.identite i
WHERE NOT (
    i.naissance  IS NULL
    OR TRIM(i.naissance) = '');
-- = 45.512

-- Count the number of dates in the naissance and death column:
SELECT *
from (
SELECT 'birth' AS column_name,
       COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i.naissance  IS NOT NULL
  AND TRIM(i.naissance) <> ''

UNION ALL

SELECT 'death' AS column_name,
       COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i.mort IS NOT NULL
  AND TRIM(i.mort) <> ''
) as counts;

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