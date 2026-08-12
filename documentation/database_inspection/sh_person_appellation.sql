/*
 * Data Exploration
 */

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

/*
 * Data Transformation
 */

-- add column concatenanting name and forename
alter table elites_suisses.identite add column name_forename text;

select concat(nom, ', ', i.prenom  )
from elites_suisses.identite i 
limit 10;

update elites_suisses.identite i set name_forename = concat(nom, ', ', i.prenom  );
