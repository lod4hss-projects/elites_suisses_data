
/* 
 * Multiple educational steps or degrees 
 * for the same person
 * 
 */

select e."ID_IDENTITE", count(*) as num 
from elites_suisses.education e 
group by e."ID_IDENTITE" 
order by num desc
limit 20;

-- number of different segmets per person
select e."ID_IDENTITE", count(*) as num , string_agg(distinct e."Formation niveau", ',' order by e."Formation niveau")
from elites_suisses.education e 
group by e."ID_IDENTITE" 
order by num desc;

-- distribution of counts
with tw1 as (select e."ID_IDENTITE", count(*) as num 
from elites_suisses.education e 
group by e."ID_IDENTITE" 
)
select num, count(*) as freq
from tw1
group by num
order by num desc;



-- https://elitessuisses.unil.ch/p/52223

-- example of multiple training
select i.name_forename, e.*
from elites_suisses.education e 
	join elites_suisses.identite i on i.id = e."ID_IDENTITE" 
-- where i.name_forename = 'Brenner, Ernst'
where i.id = 55864 -- 52223	
order by "ID_IDENTITE" 
limit 10;	


-- example of multiple training
select i.name_forename, e.zkp_edu, e."ID_IDENTITE", e."Date", e."Formation niveau",
	e."Titre_stxt", e."TITRE_Codé", e."Institution", e.id_institution, e."THÈSE_Directeur_IdIdentité" ,
	e."Lieu", e."Canton", e."Pays" 
from elites_suisses.education e 
	join elites_suisses.identite i on i.id = e."ID_IDENTITE" 
-- where i.name_forename = 'Brenner, Ernst'
where i.id = 55864 -- 52223	
order by "ID_IDENTITE" 
limit 10;	







/*
 * VUE pour le R2RML
 */

-- toutes renseignées
select e.zkp_edu 
from elites_suisses.education e 
where e.zkp_edu is null or length(e.zkp_edu) = 0
limit 100;

-- identifiant unique, aucun doublon
select e.zkp_edu, count(*)
from elites_suisses.education e 
group by e.zkp_edu 
having count(*) > 1
limit 100;

drop view elites_suisses.v_education ;
create view elites_suisses.v_education as
select e.zkp_edu as id_edu, e."ID_IDENTITE" as id_person, cg.pk_crm_group , 
e."THÈSE_Directeur_IdIdentité" as id_directeur, e."Date" as grade_date,
e.fk_study_discipline, e.fk_study_title
from elites_suisses.education e 
		join elites_suisses.crm_group cg on cg.fk_source_entity = e.id_institution 
where trim(lower(e."Formation niveau")) in ('doctorat', 'supérieure')
-- only four years dates
and length(e."Date") < 5 
--and e."THÈSE_Directeur_IdIdentité" is not null
--limit 100;
;



-- inspect the view
select *
from elites_suisses.v_education 
--where id_directeur is not null
order by id_person
limit 100;



select *
from elites_suisses.v_education 
where id_directeur is not null
--where id_person is null
order by id_person
limit 100;







/*
* Education level
* 
* Ceci serait un type de formation
*/

select trim(lower(e."Formation niveau")), count(*) as number
FROM elites_suisses.education e 
group by  trim(lower(e."Formation niveau")) 
order by number desc;





/*
 * Date
 */


select trim(lower(e."Date")) _date, count(*) as number
FROM elites_suisses.education e 
--where trim(lower(e."Formation niveau")) = 'base'
where length(e."Date") > 6
group by trim(lower(e."Date")) 
order by _date;

order by number desc;

with tw1 as (
select trim(lower(e."Date")) _date, count(*) as number
FROM elites_suisses.education e 
where length(e."Date") > 6 -- > 6  / = 4
group by trim(lower(e."Date")) 
)
select sum(number) total
from tw1;




/*
* Degree code
*/

select trim(lower(e."TITRE_Codé")), count(*) as number
FROM elites_suisses.education e 
where trim(lower(e."Formation niveau")) = 'base'
group by  trim(lower(e."TITRE_Codé")) 
order by number desc;


-- issue with the quotes corrected
update elites_suisses.education set "TITRE_Codé" = REPLACE("TITRE_Codé", '’', '''');



with tw1 as (
select 
	CASE
      when trim(lower(e."TITRE_Codé")) like 'apprent%'
      then 'apprentissage'
      when trim(lower(e."TITRE_Codé")) like 'licenc%'
      then 'licence'
      when trim(lower(e."TITRE_Codé")) like 'doctora%'
      then 'doctorat'
      when trim(lower(e."TITRE_Codé")) like 'll.%'
      then 'll. m.'
      else trim(lower(replace(replace(e."TITRE_Codé", '?',''), 'diplome', 'diplôme'))) 
    end titre_code
FROM elites_suisses.education e 
)
select titre_code, count(*) as number
FROM tw1 e 
where length(titre_code) > 2
group by  titre_code 
having count(*) > 2
order by titre_code;
order by number desc;


-- replace on original table !!!
update elites_suisses.education e set "TITRE_Codé" = CASE
      when trim(lower(e."TITRE_Codé")) like 'apprent%'
      then 'apprentissage'
      when trim(lower(e."TITRE_Codé")) like 'licenc%'
      then 'licence'
      when trim(lower(e."TITRE_Codé")) like 'doctora%'
      then 'doctorat'
      when trim(lower(e."TITRE_Codé")) like 'll.%'
      then 'll. m.'
      else trim(lower(replace(replace(e."TITRE_Codé", '?',''), 'diplome', 'diplôme'))) 
    end;




select e."TITRE_Codé", count(*) as number
FROM elites_suisses.education e 
where length(e."TITRE_Codé") > 2
group by  e."TITRE_Codé" 
having count(*) > 2
order by e."TITRE_Codé";
order by number desc;



select i.name_forename, e.*
from elites_suisses.education e 
	join elites_suisses.identite i on i.id = e."ID_IDENTITE" 
where e.id_institution is not null
order by "ID_IDENTITE" 
limit 10;	



/*
 * Create table with study title
 */

select row_number() OVER (ORDER BY 1)::INTEGER, e."TITRE_Codé", count(*) as number
FROM elites_suisses.education e 
where length(e."TITRE_Codé") > 2
group by  e."TITRE_Codé" 
having count(*) > 2
--order by e."TITRE_Codé";
order by number desc;


drop table elites_suisses.t_study_title ;
create table elites_suisses.t_study_title as
select row_number() OVER (ORDER BY 1)::INTEGER as id, e."TITRE_Codé" study_title, count(*) as number
FROM elites_suisses.education e 
where length(e."TITRE_Codé") > 2
group by  e."TITRE_Codé" 
having count(*) > 2
--order by e."TITRE_Codé";
order by number desc;

alter table elites_suisses.t_study_title add CONSTRAINT t_study_title_pk PRIMARY key (id);

select * from elites_suisses.t_study_title ;



select st.*, e.*
from elites_suisses.education e 
	join elites_suisses.t_study_title st on st.study_title= e."TITRE_Codé" 
limit 10;


alter table elites_suisses.education add column fk_study_title integer;
-- FOREIGN KEY 
alter table elites_suisses.education add constraint fk_study_title_fk foreign key (fk_study_title) 
	references elites_suisses.t_study_title(id);


update elites_suisses.education e set fk_study_title = st.id 
from elites_suisses.t_study_title st
where st.study_title= e."TITRE_Codé";


select st.study_title, e.*
from elites_suisses.education e
	join elites_suisses.t_study_title st on st.id = e.fk_study_title 
limit 10









/*
* Catégorie, i.e. topic or discipline
*/

alter table elites_suisses.education add column categorie_norm text;

update elites_suisses.education e set categorie_norm = "Catégorie" ;

update elites_suisses.education e set categorie_norm = replace(trim(lower(e.categorie_norm)), '?', '')





select row_number() OVER (ORDER BY 1)::INTEGER, categorie_norm, count(*) as number
FROM elites_suisses.education e 
	join elites_suisses.v_education ve on ve.id_edu = e.zkp_edu
where length(categorie_norm) > 2
--where Trim( lower(e."Catégorie") ) ~ 'ingé'
--where Trim( lower(e."Catégorie") ) ~ 'scien'
--and e.id_institution is not null
group by categorie_norm
having count(*) > 4
order by categorie_norm;
order by number desc;


-- updates on tables 


-- remplacer si de nouveau nécessaire par 'categorie_norm'
update elites_suisses.education e set "Catégorie" = replace(e."Catégorie", 'economie', 'économie')
where e."Catégorie" like '%economie%';
update elites_suisses.education e set "Catégorie" = replace(e."Catégorie", 'Economie', 'Économie')
where e."Catégorie" like '%Economie%';
update elites_suisses.education e set "Catégorie" = replace(e."Catégorie", 'Genie', 'Génie')
where e."Catégorie" like '%Genie%';


-- issue with ’ that is not '

select *
from elites_suisses.education e 
where e."Catégorie" LIKE '%’%'
limit 10;

select count(*) as num
from elites_suisses.education e 
where e."Catégorie" LIKE '%’%';

--update elites_suisses.education set "Catégorie" = REPLACE("Catégorie", '’', '''');



select * 
from elites_suisses.education e
where e.categorie_norm ilike '%chemie%';


drop table elites_suisses.t_study_discipline ;
create table elites_suisses.t_study_discipline as
select row_number() OVER (ORDER BY 1)::INTEGER as id, categorie_norm, count(*) as number
FROM elites_suisses.education e 
	join elites_suisses.v_education ve on ve.id_edu = e.zkp_edu
where length(categorie_norm) > 2
--where Trim( lower(e."Catégorie") ) ~ 'ingé'
--where Trim( lower(e."Catégorie") ) ~ 'scien'
--and e.id_institution is not null
group by categorie_norm
having count(*) > 4
order by categorie_norm;

alter table elites_suisses.t_study_discipline add CONSTRAINT t_study_discipline_pk PRIMARY KEY (id);

select * from elites_suisses.t_study_discipline ;



select sd.*, e.*
from elites_suisses.education e 
	join elites_suisses.t_study_discipline sd on sd.categorie_norm = e.categorie_norm 
limit 10;


alter table elites_suisses.education add column fk_study_discipline integer;
-- FOREIGN KEY 
alter table elites_suisses.education add constraint fk_study_discipline_fk foreign key (fk_study_discipline) 
	references elites_suisses.t_study_discipline(id);


update elites_suisses.education e set fk_study_discipline = sd.id 
from elites_suisses.t_study_discipline sd 
where sd.categorie_norm = e.categorie_norm;


select sd.categorie_norm, e.*
from elites_suisses.education e
	join elites_suisses.t_study_discipline sd on sd.id = e.fk_study_discipline 
limit 10












/*
* Theses directors
*/

select e."THÈSE_Directeur_IdIdentité" directeur, count(*) as number
FROM elites_suisses.education e 
group by e."THÈSE_Directeur_IdIdentité"
order by number desc;

with tw1 as (
select e."THÈSE_Directeur_IdIdentité" directeur, count(*) as number, (array_agg(e."Catégorie"))[1] topics
FROM elites_suisses.education e 
group by e."THÈSE_Directeur_IdIdentité"
)
select tw1.*, i.nom, i.prenom, i.profession, (regexp_match(i.naissance, '\d{4}'))[1] AS year,tw1.topics  
from tw1 
	left join elites_suisses.identite i on i.id = tw1.directeur 
order by number desc;	



/*
* Institution
*/

select trim(lower(e."Institution")), count(*) as number
FROM elites_suisses.education e 
group by  trim(lower(e."Institution")) 
order by number desc;

select *
from elites_suisses.entites e 
where e.nom ~* 'uni';


-- alignment with organisations (table 'entités')

with tw1 as (select trim(lower(e."Institution")) name, count(*) as number
FROM elites_suisses.education e 
group by  trim(lower(e."Institution")) 
order by number desc)
select tw1.name, tw1."number", ' ' as sp,  e.nom, e.id, e."typeEntite"
from tw1 
	left join elites_suisses.entites e on trim(lower(e.nom)) = name
order by number desc;





/*
* Add column to education with alignment to entities
*/

-- crate column for alignment
alter table elites_suisses.education add column id_institution INTEGER;
alter table elites_suisses.education add constraint fk_education_entites FOREIGN KEY (id_institution) REFERENCES elites_suisses.entites(id);


-- preparer / vérifier alignment
select ed."Institution", ed.id_institution, ' ' as sp,  ent.nom, ent.id, ent."typeEntite"
from elites_suisses.education ed 
	join elites_suisses.entites ent on trim(lower(ent.nom)) = trim(lower(ed."Institution")) 
order by ed."ID_IDENTITE"
offset 1000
limit 50;


-- insert ids of aligned educational institutions
--update elites_suisses.education ed set id_institution = ent.id 
from elites_suisses.entites ent 
where trim(lower(ent.nom)) = trim(lower(ed."Institution")) ;


-- number of aligned entities

select count(*)
from elites_suisses.education e 
where e.id_institution is not null;


-- most frequent entities

with tw1 as (
select e.id_institution, count(*) as number
from elites_suisses.education e 
group by e.id_institution 
)
select e.id, e.nom, tw1."number" 
from tw1, elites_suisses.entites e 
where e.id = tw1.id_institution 
order by number desc;


/*
 * Import to crm_group table
 */

-- verify if already present
with tw1 as (
select e.id_institution, count(*) as number
from elites_suisses.education e 
-- restriction pour une première opération
where trim(lower(e."Formation niveau")) in ('doctorat', 'supérieure')
group by e.id_institution 
)
select e.id, e.nom, tw1."number", cg."name" group_name
from tw1 
	join elites_suisses.entites e on e.id = tw1.id_institution 
	left join elites_suisses.crm_group cg on cg.fk_source_entity = e.id 
-- where cg."name" is not null	
order by number desc;
order by nom ;


-- prepare insert
with tw1 as (
select e.id_institution, count(*) as number
from elites_suisses.education e 
where trim(lower(e."Formation niveau")) in ('doctorat', 'supérieure')
group by e.id_institution 
)
select e.id, e.nom, e.nom
from tw1 
	join elites_suisses.entites e on e.id = tw1.id_institution 
	left join elites_suisses.crm_group cg on cg.fk_source_entity = e.id 
where cg."name" is null	
order by number desc;
order by nom ;

-- insert
with tw1 as (
select e.id_institution, count(*) as number
from elites_suisses.education e 
where trim(lower(e."Formation niveau")) in ('doctorat', 'supérieure')
group by e.id_institution 
)
insert into elites_suisses.crm_group ("name", description, fk_source_entity, fk_group_type, import_notes )
select e.nom, e.nom, e.id, 6, '20260616_imp1'
from tw1 
	join elites_suisses.entites e on e.id = tw1.id_institution 
	left join elites_suisses.crm_group cg on cg.fk_source_entity = e.id 
where cg."name" is null	
order by number desc;
order by nom ;















/*
 * Institutions non reconnues par la jointure précédente
 */

select e.*
FROM elites_suisses.education e 
where e.id_institution is null
and length(e."Institution") > 2
limit 100;

select count(*) as number
FROM elites_suisses.education e 
where e.id_institution is null
and length(e."Institution") > 2;



select e."Institution", count(*) as number
FROM elites_suisses.education e 
where e.id_institution is null
and length(e."Institution") > 2
group by e."Institution" 
order by number DESC;



/*
* Instances of education without organisations (entities)
*/


-- inspect
select e.*
FROM elites_suisses.education e 
where length(e."Institution") < 2
limit 100;


select count(*)
FROM elites_suisses.education e 
where length(e."Institution") < 2;


select trim(lower(e."Formation niveau")) niveau, trim(lower(e."Catégorie")) matiere, 
trim(lower(e."Lieu")) lieu, trim(lower(e."Pays")) pays, count(*) number
FROM elites_suisses.education e 
where length(e."Institution") < 2
group by  trim(lower(e."Formation niveau")), trim(lower(e."Catégorie")), 
trim(lower(e."Lieu")), trim(lower(e."Pays"))
order by number desc;
