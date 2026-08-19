/*
 * Data Exploration
 */

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
 * Data Transformation
 */

 -- extract birth year

alter table elites_suisses.identite add column birth_year integer;

select
case when (regexp_match(naissance, '\d{4}')) is not null
then (regexp_match(naissance, '\d{4}'))[1]::integer
else 0
end as birth_year
from elites_suisses.identite i
limit 100;



update elites_suisses.identite set birth_year = case when (regexp_match(naissance, '\d{4}')) is not null
then (regexp_match(naissance, '\d{4}'))[1]::integer
else 0
end;


select birth_year, count(*) number
from elites_suisses.identite i 
group by birth_year
--order by birth_year 
order by count(*) desc
limit 100;

select count(*) number
from elites_suisses.identite i 
where birth_year != 0;