/*
 * Data Exploration
 */

-- Exploring the first 10 rows of the table
SELECT *
FROM elites_suisses.mariage m 
limit 10;

-- Exploring the table with only the relevant columns
select distinct m."idMariage", m."idFemme", m."idMari",
m."anneeMariage_Utilisee", m."anneeDivorce_Utilisee" ,
m."dateExacte_mariage", m."dateExacte_divorce",
m."debut_EnToutCas", m."fin_EnToutCas" 
from elites_suisses.mariage m 
 join elites_suisses.identite if on if.id = m."idFemme" 
 join elites_suisses.identite ip on ip.id = m."idMari" 
 offset 1000
limit 20;

-- Exploring the sources
SELECT
	'sources' AS column_name,
    COUNT(*) filter (
    	WHERE m.sources IS NULL
  		OR TRIM(m.sources) = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE m.sources is NOT NULL
  		AND TRIM(m.sources) <> ''
    ) AS nbr_values,
    COUNT(distinct TRIM(m.sources)) filter (
    	WHERE m.sources is NOT NULL
  		AND TRIM(m.sources) <> ''
    ) AS nbr_distinct_values
from elites_suisses.mariage m
;

-- Exploring the dates
SELECT *
from (
SELECT
	'anneeMariage_Utilisee' AS column_name,
    COUNT(*) filter (
    	WHERE m."anneeMariage_Utilisee" IS NULL
  		OR TRIM(m."anneeMariage_Utilisee") = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE m."anneeMariage_Utilisee" is NOT null
  		AND TRIM(m."anneeMariage_Utilisee") <> ''
    ) AS nbr_values
from elites_suisses.mariage m
    
union all

SELECT
	'anneeDivorce_Utilisee' AS column_name,
    COUNT(*) filter (
    	WHERE m."anneeDivorce_Utilisee" IS NULL
  		OR TRIM(m."anneeDivorce_Utilisee") = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE m."anneeDivorce_Utilisee" is NOT NULL
  		AND TRIM(m."anneeDivorce_Utilisee") <> ''
    ) AS nbr_values
    
from elites_suisses.mariage m

union all

SELECT
	'dateExacte_mariage' AS column_name,
    COUNT(*) filter (
    	WHERE m."dateExacte_mariage" IS NULL
  		OR TRIM(m."dateExacte_mariage") = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE m."dateExacte_mariage" is NOT NULL
  		AND TRIM(m."dateExacte_mariage") <> ''
    ) AS nbr_values
    
from elites_suisses.mariage m

union all

SELECT
	'dateExacte_divorce' AS column_name,
    COUNT(*) filter (
    	WHERE m."dateExacte_divorce" IS NULL
  		OR TRIM(m."dateExacte_divorce") = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE m."dateExacte_divorce" is NOT NULL
  		AND TRIM(m."dateExacte_divorce") <> ''
    ) AS nbr_values
    
from elites_suisses.mariage m

union all

SELECT
	'debut_EnToutCas' AS column_name,
    COUNT(*) filter (
    	WHERE m."debut_EnToutCas" IS NULL
  		OR TRIM(m."debut_EnToutCas") = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE m."debut_EnToutCas" is NOT NULL
  		AND TRIM(m."debut_EnToutCas") <> ''
    ) AS nbr_values
    
from elites_suisses.mariage m

union all

SELECT
	'fin_EnToutCas' AS column_name,
    COUNT(*) filter (
    	WHERE m."fin_EnToutCas" IS NULL
  		OR TRIM(m."fin_EnToutCas") = ''
    ) AS nbr_empty_values,
    COUNT(*) filter (
    	WHERE m."fin_EnToutCas" is NOT NULL
  		AND TRIM(m."fin_EnToutCas") <> ''
    ) AS nbr_values
    
from elites_suisses.mariage m

) as counts;

/*
 * Data Transformation
 */

-- Data with a URI issue
SELECT *
FROM elites_suisses.mariage m 
where m."idMariage" like '51262104964%'
limit 10;


-- correcting the URI issue in table
update elites_suisses.mariage set "idMariage"='51262104964'
where "idMariage" like '51262104964%';

-- checking the results after transformation
SELECT *
FROM elites_suisses.mariage m 
where m."idMariage" ~ 'base'
limit 10;

-- creating an SQL view adding the social relationship type
drop view elites_suisses.v_mariage;
CREATE view elites_suisses.v_mariage AS
select distinct m."idMariage" id, m."idFemme" femme, m."idMari" homme,
1 as fk_social_relationship_type,
m."anneeMariage_Utilisee" annee_debut, m."anneeDivorce_Utilisee" ,
m."dateExacte_mariage", m."dateExacte_divorce",
m."debut_EnToutCas", m."fin_EnToutCas" 
from elites_suisses.mariage m 
 join elites_suisses.identite if on if.id = m."idFemme" 
 join elites_suisses.identite ip on ip.id = m."idMari"; 

-- Exploring the new view
select *
from elites_suisses.v_mariage
limit 10;

/*
 * Add social relationship type table 
 */

--drop table  elites_suisses.social_role ;
CREATE TABLE elites_suisses.social_relationship_type (
    pk_social_relationship_type INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(255),
    description TEXT,
    notes text,
    wikidata_uri varchar(255),
    import_notes text
);

select *
from elites_suisses.social_relationship_type;

