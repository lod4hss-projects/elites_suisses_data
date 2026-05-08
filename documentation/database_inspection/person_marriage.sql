
SELECT *
FROM elites_suisses.mariage m 
limit 10;

-- requête exploratoire
select distinct m."idMariage", m."idFemme", m."idMari",
m."anneeMariage_Utilisee", m."anneeDivorce_Utilisee" ,
m."dateExacte_mariage", m."dateExacte_divorce",
m."debut_EnToutCas", m."fin_EnToutCas" 
from elites_suisses.mariage m 
 join elites_suisses.identite if on if.id = m."idFemme" 
 join elites_suisses.identite ip on ip.id = m."idMari" 
 offset 1000
limit 20;



/*
 * données sales qui font un probléme de URI
 */
SELECT *
FROM elites_suisses.mariage m 
where m."idMariage" like '51262104964%'
limit 10;


-- donnes sales corrigées
update elites_suisses.mariage set "idMariage"='51262104964'
where "idMariage" like '51262104964%';


SELECT *
FROM elites_suisses.mariage m 
where m."idMariage" ~ 'base'
limit 10;

-- vue SQL
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

