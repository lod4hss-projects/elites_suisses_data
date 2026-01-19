

/*
* Education level
*/

select trim(lower(e."Formation niveau")), count(*) as number
FROM elites_suisses.education e 
group by  trim(lower(e."Formation niveau")) 
order by number desc;



/*
* Degree code
*/

select trim(lower(e."TITRE_Codé")), count(*) as number
FROM elites_suisses.education e 
group by  trim(lower(e."TITRE_Codé")) 
order by number desc;



/*
* Catégorie, i.e. topic or discipline
*/

select trim(lower(e."Catégorie")) name, count(*) as number
FROM elites_suisses.education e 
--where Trim( lower(e."Catégorie") ) ~ 'ingé'
where Trim( lower(e."Catégorie") ) ~ 'scien'
group by  trim(lower(e."Catégorie")) 
order by number desc;





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

-- insert ids
update elites_suisses.education ed set id_institution = ent.id 
from elites_suisses.entites ent 
where trim(lower(ent.nom)) = trim(lower(ed."Institution")) ;


-- number of aligned entities

select count(*)
from elites_suisses.education e 
where e.id_institution is not null;

select count(*)
from elites_suisses.education e 
where e.id_institution is null;


-- most frequent entities

with tw1 as (
select e.id_institution, count(*) as number
from education e 
group by e.id_institution 
)
select e.id, e.nom, tw1."number" 
from tw1, elites_suisses.entites e 
where e.id = tw1.id_institution 
order by number desc;






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
