
select *
from elites_suisses.v_sphere_academique;


select organe, count(*) as num
from elites_suisses.v_sphere_academique
--where "typeEntite" = 'Prix/Distinction'
-- where "typeEntite" = 'Enseignement'
group by organe
order by organe;


select organe, entite, count(*) as num
from elites_suisses.v_sphere_academique
--where "typeEntite" = 'Prix/Distinction'
where "typeEntite" = 'Enseignement'
group by organe, entite
order by organe, entite;




select *
from elites_suisses.entites e 
where nom = 'Worb';


select entite, e.nom, e."idEntite", e.id, sa.id_entity 
from elites_suisses.v_sphere_academique sa
 left join elites_suisses.entites e on e."idEntite" = sa."idEntite" 
 and e.nom != 'Worb'
 limit 100;

select entite, count(*) as num, e.nom, e."idEntite"
from elites_suisses.v_sphere_academique sa
 left join elites_suisses.entites e on e."idEntite" = sa."idEntite" 
 and e.nom != 'Worb'
--where sa."typeEntite" = 'Enseignement'
group by entite, e.nom,e."idEntite"
order by entite;



select entite, count(*) as num, e.nom original_entity_name, cg.name_standard, sa.fk_crm_group, cg.pk_crm_group 
from elites_suisses.v_sphere_academique sa
 left join elites_suisses.entites e on e."idEntite" = sa."idEntite" 
 and e.nom != 'Worb'
left join elites_suisses.crm_group cg on cg.pk_crm_group = sa.fk_crm_group 
where sa."typeEntite" = 'Enseignement'
group by entite, e.nom, cg.name_standard, cg.pk_crm_group,sa.fk_crm_group
order by entite;

--drop table elites_suisses.t_entity_sub_entity_education ;
--create table elites_suisses.t_entity_sub_entity_education AS
select row_number() OVER (ORDER BY 1)::INTEGER as id, count(*) as num, sa.entite, sa.fk_crm_group , null as fk_crm_group_manual, cg.name_standard,  sa.organe, 
	null as fk_crm_group_organe_manual, sa.fk_crm_group_organe, notes,
  	e.nom entity_name, e.id id_entity, string_agg(sa.id::varchar, ',')
from elites_suisses.v_sphere_academique sa
 left join elites_suisses.entites e on e."idEntite" = sa."idEntite" 
 and e.nom != 'Worb'
left join elites_suisses.crm_group cg on cg.pk_crm_group = sa.fk_crm_group 
where sa."typeEntite" = 'Enseignement'
group by sa.entite, sa.organe, e.nom, cg.name_standard, cg.pk_crm_group,sa.fk_crm_group, sa.fk_crm_group_organe, e.id
order by entite;

alter table elites_suisses.t_entity_sub_entity_education add CONSTRAINT t_entity_sub_entity_pk PRIMARY key (id);



/*
 * Table to be used to associate entities 
 * to the crm_group table identifiers
 */

select * 
from elites_suisses.t_entity_sub_entity
order by id;




/*
 * inspection des typeEntite
 */

select vsa."typeEntite", count(*) as num
from elites_suisses.v_sphere_academique vsa 
group by vsa."typeEntite" 
order by num desc;






/*
 * inspection des fonctions
 */

select vsa.fonction, count(*) as num
from elites_suisses.v_sphere_academique vsa 
group by vsa.fonction 
order by num desc;



/*
 * inspection des "partiAffiliationOfficeSecteur"
 */

select vsa."partiAffiliationOfficeSecteur", count(*) as num
from elites_suisses.v_sphere_academique vsa 
group by vsa."partiAffiliationOfficeSecteur"
order by num desc;


select vsa."partiAffiliationOfficeSecteur", vsa.fonction, count(*) as num
from elites_suisses.v_sphere_academique vsa 
group by vsa."partiAffiliationOfficeSecteur",vsa.fonction 
order by num desc;