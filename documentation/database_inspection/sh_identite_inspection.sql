-- List all entries in identite table:
SELECT COUNT (*)
FROM elites_suisses.identite i  ;
-- = 58729


-- Count the number of empty fields in the nom column:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i.nom IS NULL
   OR TRIM(i.nom) = '';
-- = 0


-- Count the number of empty fields in the prenom column:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i.prenom IS NULL
   OR TRIM(i.prenom) = '';
-- = 222

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

-- Count the number of occurences in the lieuNaissance and cantonNaissance column:
SELECT *
from (
SELECT 'birth_place' AS column_name,
       COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i."lieuNaissance"   IS NOT NULL
  AND TRIM(i."lieuNaissance" ) <> ''

UNION ALL

SELECT 'birth_canton' AS column_name,
       COUNT(*) AS number_occurences
FROM elites_suisses.identite i 
WHERE i."cantonNaissance"  IS NOT NULL
  AND TRIM(i."cantonNaissance" ) <> ''
) as counts;

-- Query to see if we have instances where a cantonNaissance is documented without a lieuNaissance:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i."cantonNaissance" IS NOT NULL
  AND TRIM(i."cantonNaissance") <> ''
  AND (i."lieuNaissance" IS NULL OR TRIM(i."lieuNaissance") = '');

-- Query to see if we have instances where a lieuNaissance is documented without a cantonNaissance:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i."lieuNaissance" IS NOT NULL
  AND TRIM(i."lieuNaissance") <> ''
  AND (i."cantonNaissance" IS NULL OR TRIM(i."cantonNaissance") = '');

-- Count the number of unique lieuNaissance, with only lowercase and with trim
SELECT COUNT(DISTINCT LOWER(TRIM(i."lieuNaissance"))) AS unique_place_count
FROM elites_suisses.identite i 
WHERE i."lieuNaissance" IS NOT NULL
  AND TRIM(i."lieuNaissance") <> '';