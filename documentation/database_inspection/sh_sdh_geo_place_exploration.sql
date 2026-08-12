/*
 * Data Exploration
 */

-- Exploring Settlments, Cantons and Countries

-- Query in the identite table counting the number of occurences in the lieuNaissance and cantonNaissance column:
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

-- Query in the education table counting the number of occurences in the lieuNaissance and cantonNaissance column:
SELECT *
from (
SELECT 'education_place' AS column_name,
       COUNT(*) AS number_occurences
FROM elites_suisses.education e 
WHERE e."Lieu" IS NOT NULL
  AND TRIM(e."Lieu") <> ''

UNION ALL

SELECT 'education_canton' AS column_name,
       COUNT(*) AS number_occurences
FROM elites_suisses.education e 
WHERE e."Canton" IS NOT NULL
  AND TRIM(e."Canton") <> ''
  
UNION ALL

SELECT 'education_country' AS column_name,
       COUNT(*) AS number_occurences
FROM elites_suisses.education e 
WHERE e."Pays" IS NOT NULL
  AND TRIM(e."Pays") <> ''
) as counts;

-- Query in the identite table counting the number of unique values in the cantonNaissance when there is no value in lieuNaissance:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i."cantonNaissance" IS NOT NULL
  AND TRIM(i."cantonNaissance") <> ''
  AND (i."lieuNaissance" IS NULL OR TRIM(i."lieuNaissance") = '');

-- Query in the identite table counting the number of unique values in the lieuNaissance when there is no value in cantonNaissance:
SELECT COUNT(*)
FROM elites_suisses.identite i 
WHERE i."lieuNaissance" IS NOT NULL
  AND TRIM(i."lieuNaissance") <> ''
  AND (i."cantonNaissance" IS NULL OR TRIM(i."cantonNaissance") = '');

-- Query in the education table counting the number of unique values in the Canton when there is no value in Lieu:
SELECT COUNT(*)
from elites_suisses.education e 
WHERE e."Canton" IS NOT NULL
  AND TRIM(e."Canton") <> ''
  AND (e."Lieu" IS NULL OR TRIM(e."Lieu") = '');

-- Query in the education table counting the number of unique values in the Pays when there is no value in Lieu:
SELECT COUNT(*)
from elites_suisses.education e 
WHERE e."Pays" IS NOT NULL
  AND TRIM(e."Pays") <> ''
  AND (e."Lieu" IS NULL OR TRIM(e."Lieu") = '');

-- Query in the entite table counting the number of unique values in the siegeCanton when there is no value in siege:
SELECT COUNT(*)
from elites_suisses.entites e 
WHERE e."siegeCanton" IS NOT NULL
  AND TRIM(e."siegeCanton") <> ''
  AND (e.siege IS NULL OR TRIM(e.siege) = '');

-- Query in the entite table counting the number of unique values in the pays when there is no value in siege:
SELECT COUNT(*)
from elites_suisses.entites e 
WHERE e.pays IS NOT NULL
  AND TRIM(e.pays) <> ''
  AND (e.siege IS NULL OR TRIM(e.siege) = '');

-- Query in the entite table counting the number of unique values in the creationCanton when there is no value in creationLieu:
SELECT COUNT(*)
from elites_suisses.entites e 
WHERE e."creationCanton" IS NOT NULL
  AND TRIM(e."creationCanton") <> ''
  AND (e."creationLieu" IS NULL OR TRIM(e."creationLieu") = '');

-- Listing the value that do not follow the 2 letter code for cantonNaissance in the table identite
select
    LOWER(TRIM(i."cantonNaissance")) AS identite_cantonNaissance,
    COUNT(*) AS frequency
FROM elites_suisses.identite i 
WHERE i."cantonNaissance" IS NOT NULL
  AND TRIM(i."cantonNaissance") <> ''
  AND LENGTH(TRIM(i."cantonNaissance")) <> 2
GROUP BY LOWER(TRIM(i."cantonNaissance"))
ORDER BY frequency DESC;

-- Listing the value that do not follow the 2 letter code for Canton in the table education
select
    LOWER(TRIM(e."Canton")) AS education_canton,
    COUNT(*) AS frequency
FROM elites_suisses.education e 
WHERE e."Canton" IS NOT NULL
  AND TRIM(e."Canton") <> ''
  AND LENGTH(TRIM(e."Canton")) <> 2
GROUP BY LOWER(TRIM(e."Canton"))
ORDER BY frequency DESC;

-- Listing the value that do not follow the 2 letter code for siegeCanton in the table entite
select
    LOWER(TRIM(e."siegeCanton")) AS entite_siegeCanton,
    COUNT(*) AS frequency
FROM elites_suisses.entites e 
WHERE e."siegeCanton" IS NOT NULL
  AND TRIM(e."siegeCanton") <> ''
  AND LENGTH(TRIM(e."siegeCanton")) <> 2
GROUP BY LOWER(TRIM(e."siegeCanton"))
ORDER BY frequency DESC;

-- Listing the value that do not follow the 2 letter code for creationCanton in the table entite
select
    LOWER(TRIM(e."creationCanton")) AS entite_creationCanton,
    COUNT(*) AS frequency
FROM elites_suisses.entites e 
WHERE e."creationCanton" IS NOT NULL
  AND TRIM(e."creationCanton") <> ''
  AND LENGTH(TRIM(e."creationCanton")) <> 2
GROUP BY LOWER(TRIM(e."creationCanton"))
ORDER BY frequency DESC;

/*
 * Exploring Settlments
 */

-- Count the number of unique lieuNaissance, with only lowercase and with trim
SELECT COUNT(DISTINCT LOWER(TRIM(i."lieuNaissance"))) AS unique_place_count
FROM elites_suisses.identite i 
WHERE i."lieuNaissance" IS NOT NULL
  AND TRIM(i."lieuNaissance") <> '';

-- Query in all the tables counting the number of distinct settlements

SELECT *
from (
SELECT
    'identite_lieuNaissance' AS column_name,
    COUNT(DISTINCT LOWER(TRIM(i."lieuNaissance"))) AS distinct_places
FROM elites_suisses.identite i
WHERE i."lieuNaissance" IS NOT NULL
  AND TRIM(i."lieuNaissance") <> ''

UNION ALL

SELECT
    'entite_siege' AS column_name,
    COUNT(DISTINCT LOWER(TRIM(e.siege))) AS distinct_places
FROM elites_suisses.entites e
WHERE e.siege IS NOT NULL
  AND TRIM(e.siege) <> ''
  
UNION ALL

SELECT
    'entite_creation_lieu' AS column_name,
    COUNT(DISTINCT LOWER(TRIM(e."creationLieu"))) AS distinct_places
FROM elites_suisses.entites e
WHERE e."creationLieu" IS NOT NULL
  AND TRIM(e."creationLieu") <> ''

UNION ALL

SELECT
    'education_lieu' AS column_name,
    COUNT(DISTINCT LOWER(TRIM(ed."Lieu"))) AS distinct_places
FROM elites_suisses.education ed
WHERE ed."Lieu" IS NOT NULL
  AND TRIM(ed."Lieu") <> ''
  ) as counts;

-- Count the number of distinct values of settlement not present in identite_lieuNaissance
SELECT *
from (
SELECT 'education_lieu' AS column_name,
       COUNT(DISTINCT LOWER(TRIM(e."Lieu"))) AS missing_from_lieunaissance
FROM elites_suisses.education e 
WHERE e."Lieu" IS NOT NULL
  AND TRIM(e."Lieu") <> ''
  AND NOT EXISTS (
      SELECT 1
      FROM elites_suisses.identite i
      WHERE LOWER(TRIM(i."lieuNaissance")) = LOWER(TRIM(e."Lieu"))
  )

UNION ALL

SELECT 'entite_siege',
       COUNT(DISTINCT LOWER(TRIM(en.siege)))
FROM elites_suisses.entites en
WHERE en.siege IS NOT NULL
  AND TRIM(en.siege) <> ''
  AND NOT EXISTS (
      SELECT 1
      FROM elites_suisses.identite i
      WHERE LOWER(TRIM(i."lieuNaissance")) = LOWER(TRIM(en.siege))
  )

UNION ALL

SELECT 'entite_creationLieu',
       COUNT(DISTINCT LOWER(TRIM(en."creationLieu")))
FROM elites_suisses.entites en
WHERE en."creationLieu" IS NOT NULL
  AND TRIM(en."creationLieu") <> ''
  AND NOT EXISTS (
      SELECT 1
      FROM elites_suisses.identite i
      WHERE LOWER(TRIM(i."lieuNaissance")) = LOWER(TRIM(en."creationLieu"))
  )
  ) as counts;

/*
 * Data Transformation
 */

