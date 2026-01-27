
-- Number of persons
-- December 2025 : 58729 



select count(*) as effectif
from elites_suisses.identite i ;




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
order by number desc;