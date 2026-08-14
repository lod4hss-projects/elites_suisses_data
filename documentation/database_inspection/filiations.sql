/*
 * Data Exploration
 */

-- Count the number of lignes in the table
select count(*)
from elites_suisses.filiations f  ;

-- Display the first 10 rows of the table
select fv."sysid", fv."idFils", fv."idParent", fv."sexeParent", 
fv.creation, fv.saisie, fv."auteurModif" , fv.zkp_filiation, fv."versionDate" 
from elites_suisses.filiations fv 
limit 10;

-- version, effectifs: appatently unique relationships
select fv."idFils", fv."idParent", fv."sexeParent",  count(*) as eff
from elites_suisses.filiations fv 
group by fv."idFils", fv."idParent",fv."sexeParent"  
order by eff desc
limit 10;


-- version, effectifs: appatently unique relationships
select distinct fv."idFils", fv."idParent", fv."sexeParent"
from elites_suisses.filiations fv 
where fv."idFils" IN (107295, 107100, 100083, 74066)
limit 10;

-- version de base pour chaque personne
select distinct fv."idFils", fv."idParent", fv."sexeParent"
from elites_suisses.filiations fv 
where fv."idFils" IN (107295, 107100, 100083, 74066)
limit 10;

-- version de base pour chaque personne
select distinct fv."idFils", if.sexe, fv."idParent", fv."sexeParent", ip.sexe sexe_parent
from elites_suisses.filiations fv 
 join elites_suisses.identite if on if.id = fv."idFils" 
 join elites_suisses.identite ip on ip.id = fv."idParent" 
where fv."idFils" IN (107295, 107100, 100083, 74066)
limit 10;

select i.birth_year 
from elites_suisses.identite i ;

-- Error in the gender of the parents
select distinct fv."idFils", if.birth_year, fv."idParent", fv."sexeParent", ip.sexe sexe_parent
from elites_suisses.filiations fv 
 join elites_suisses.identite if on if.id = fv."idFils" 
 join elites_suisses.identite ip on ip.id = fv."idParent" 
where upper(fv."sexeParent") != upper(ip.sexe)
and fv."idFils" != fv."idParent" 
limit 10;

-- Error where the child has the same id as the parent
select distinct fv."idFils",  fv."idParent", fv."sexeParent"
from elites_suisses.filiations fv 
where fv."idFils" = fv."idParent" 
limit 10;


//*
 * Data Transformation
 */

-- Creation of the view
drop view elites_suisses.v_person_birth ;
create or replace view elites_suisses.v_person_birth AS
with tw1 as (
select distinct fv."idFiliation" id_filiation, fv."idFils" id_fils, if.birth_year, 
	fv."idParent", fv."sexeParent", ip.sexe sexe_parent
from elites_suisses.filiations fv 
 join elites_suisses.identite if on if.id = fv."idFils" 
 join elites_suisses.identite ip on ip.id = fv."idParent" 
where fv."idFils" != fv."idParent" 
--and fv."idFils" IN (101579)
--limit 100
),
tw2 as (
select id_filiation, id_fils, birth_year,
	-- P96
	case
		when upper("sexeParent") = 'F'
		then "idParent"
		else NULL
	end mother,	
	-- P97
	case
		when upper("sexeParent") = 'H'
		then "idParent"
		else NULL
	end father	
from tw1)
--select * 
--from tw2;
select string_agg(id_filiation::text,'_'),
		concat('bir_',id_fils::varchar) as id_birth,
		id_fils as child,
		birth_year,
		min(NULLIF(mother, NULL)) as mother,
		min(NULLIF(father, NULL)) as father
from tw2
group by id_fils, birth_year ;


-- First 20 rows of the new view
select *
from elites_suisses.v_person_birth 
limit 20;










