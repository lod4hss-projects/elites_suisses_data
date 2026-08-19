/*
 * Data Exploration
 */

-- Count the number of empty values in the column `nationalite`:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i.nationalite IS NULL
   OR TRIM(i.nationalite) = '';

-- Count the number of distinct values in the column `nationalite` (excluding empty ones):
SELECT COUNT(distinct TRIM(i.nationalite))
FROM elites_suisses.identite i 
WHERE i.nationalite is NOT NULL
   AND TRIM(i.nationalite) <> '';

-- The list of distinct values, with the frequency
select
	distinct i.nationalite,
	COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i.nationalite is NOT NULL
   AND TRIM(i.nationalite) <> ''
group by i.nationalite
order by number_occurences desc
limit 20;

-- The list of distinct values, with the frequency, ordered by name
select
	distinct LOWER(TRIM(i.nationalite)),
	COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i.nationalite is NOT NULL
   AND LOWER(TRIM(i.nationalite)) <> ''
group by LOWER(TRIM(i.nationalite))
order by LOWER(TRIM(i.nationalite)) asc
limit 40;

 /*
 * Data Transformation
 */