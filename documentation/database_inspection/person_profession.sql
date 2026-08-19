/*
 * Data Exploration
 */

-- Count of the number of non-empty value in the column "profession"
select count(*)
from elites_suisses.identite i 
--where length(i.profession ) < 2
WHERE i.profession IS NOT NULL
  AND TRIM(i.profession) <> '';

-- Count of the number of distinct value in the column "profession"
select count(DISTINCT LOWER(TRIM(i.profession)))
from elites_suisses.identite i 
WHERE i.profession IS NOT NULL
  AND TRIM(i.profession) <> '';

-- List of all professions with their frequencies
select trim(lower(i.profession)) profession, count(*) as effectif
from elites_suisses.identite i
WHERE i.profession IS NOT NULL
  AND TRIM(i.profession) <> ''
group by trim(lower(i.profession))
order by effectif desc
limit 10;

/*
 * Data Transformation
 */

-- test splitting occupations
select
	i.id, i.name_forename, i.profession,
    CASE
	    WHEN position(',' in i.profession ) > 0 
	    THEN trim(SUBSTR(i.profession , 1, position(',' in i.profession ) - 1))
		ELSE
			trim(i.profession)
	END part,
	case
		WHEN position(',' in i.profession ) > 0  
	    THEN trim(SUBSTR(i.profession , position(',' in i.profession ) + 1))
		ELSE
			''
	END remainder
FROM elites_suisses.identite i 
limit 100;


-- en ajoutant la récursivité
WITH RECURSIVE splitter AS (
	    SELECT
		    i.id, i.name_forename, i.profession,
	    CASE
		    WHEN position(',' in i.profession ) > 0 
		    THEN SUBSTR(i.profession , 1, position(',' in i.profession ) - 1)
			ELSE
				i.profession
		END part,
		CASE 
		    WHEN position(',' in i.profession ) > 0  
		    THEN SUBSTR(i.profession , position(',' in i.profession ) + 1)
			ELSE
				''
		END remainder
			FROM elites_suisses.identite i
	    UNION ALL
			SELECT
			    id, name_forename, profession,
			    CASE 
		    WHEN position(',' in remainder ) > 0  
		    THEN SUBSTR(remainder , 1, position(',' in remainder) - 1)
			ELSE
				remainder
		END part,
		CASE 
		    when position(',' in remainder ) > 0
		    THEN SUBSTR(remainder, position(',' in remainder) + 1)
			ELSE
				''
		END remainder
			FROM
	        splitter
	    WHERE
	        remainder != ''
)
SELECT
    id, name_forename, profession, lower(TRIM(part)), remainder
FROM
    splitter
order by id ;



-- create table with result
--DROP table t_person_occupation;
create table t_person_occupation AS
WITH RECURSIVE splitter AS (
	    SELECT
		    i.id, i.name_forename, i.profession,
	    CASE
		    WHEN position(',' in i.profession ) > 0 
		    THEN SUBSTR(i.profession , 1, position(',' in i.profession ) - 1)
			ELSE
				i.profession
		END part,
		CASE 
		    WHEN position(',' in i.profession ) > 0  
		    THEN SUBSTR(i.profession , position(',' in i.profession ) + 1)
			ELSE
				''
		END remainder
			FROM elites_suisses.identite i
	    UNION ALL
			SELECT
			    id, name_forename, profession,
			    CASE 
		    WHEN position(',' in remainder ) > 0  
		    THEN SUBSTR(remainder , 1, position(',' in remainder) - 1)
			ELSE
				remainder
		END part,
		CASE 
		    when position(',' in remainder ) > 0
		    THEN SUBSTR(remainder, position(',' in remainder) + 1)
			ELSE
				''
		END remainder
			FROM
	        splitter
	    WHERE
	        remainder != ''
)
SELECT
    id, name_forename, lower(TRIM(part)) as occupation
FROM
    splitter
order by id ;


select *
from t_person_occupation
limit 10;


SELECT occupation, count(*) as number
FROM t_person_occupation
group by occupation 
--having occupation like 'Photo%'
--'Prof%'
having occupation ilike 'avoc%'
order by number desc;