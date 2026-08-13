/*
 * Data Exploration
 */

-- Count the number of empty values, values and distinct values in the column `sourcesBio` and `sourcesFormations`:
SELECT *
from (
select
	'sources_bio' AS column_name,
    COUNT(*) filter (
    	WHERE i."sourcesBio" IS NULL
  		OR TRIM(i."sourcesBio") = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE i."sourcesBio" is NOT NULL
  		AND TRIM(i."sourcesBio") <> ''
    ) AS nbr_values,
    COUNT(distinct TRIM(i."sourcesBio")) filter (
    	WHERE i."sourcesBio" is NOT NULL
  		AND TRIM(i."sourcesBio") <> ''
    ) AS nbr_distinct_values
from elites_suisses.identite i

UNION ALL

select
	'sources_formation' AS column_name,
    COUNT(*) filter (
    	WHERE i."sourcesFormations" IS NULL
  		OR TRIM(i."sourcesFormations") = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE i."sourcesFormations" is NOT NULL
  		AND TRIM(i."sourcesFormations") <> ''
    ) AS nbr_values,
    COUNT(distinct TRIM(i."sourcesFormations")) filter (
    	WHERE i."sourcesFormations" is NOT NULL
  		AND TRIM(i."sourcesFormations") <> ''
    ) AS nbr_distinct_values
from elites_suisses.identite i

) as counts;

-- The list of distinct values, with the frequency, for sourcesBio
select
	distinct i."sourcesBio",
	COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i."sourcesBio" is NOT NULL
   AND TRIM(i."sourcesBio") <> ''
group by i."sourcesBio"
order by number_occurences desc
limit 20;

-- The list of distinct values, with the frequency, for sourcesFormation
select
	distinct i."sourcesFormations",
	COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i."sourcesFormations" is NOT NULL
   AND TRIM(i."sourcesFormations") <> ''
group by i."sourcesFormations"
order by number_occurences desc
limit 20;