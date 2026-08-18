/*
 * These scripts are about the inspection and cleaning
 * of the mandates in the domain of the economic life
 */


select *
from elites_suisses.v_sphere_economique vse 
limit 100;


select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.sphere = 'Economique'
limit 100;





/*
 * Fonctions
 */


select vse.fonction, count(*) as num
from elites_suisses.v_sphere_economique vse
	left join elites_suisses.entites e on e.id = vse.id_entity 
--where "typeEntite" = 'Prix/Distinction'
group by vse.fonction
order by num desc;
order by vse.fonction;


select fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Economique'
group by fonction
having count(*) > 0
order by fonction;

-- membre
select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Economique'
and fonction ~* 'membre.*cda'
and fonction ~* 'membre';

-- membre
select fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Economique'
and fonction ~* 'membre'
group by fonction
order by num desc;



select fonction, tmcu.organe_clean_1, tmcu.organe_clean_2, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Economique'
and fonction ~* 'membre'
group by fonction, tmcu.organe_clean_1, tmcu.organe_clean_2
order by num desc;


select fonction, tmcu.organe, tmcu.organe_clean_1, tmcu.organe_clean_2, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Economique'
and fonction ~* 'membre'
group by fonction, tmcu.organe,tmcu.organe_clean_1, tmcu.organe_clean_2
order by num desc;





/*
 * Organes
 */
select lower(trim(organe)) as organe_norm, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Economique'
--where "typeEntite" = 'Prix/Distinction'
-- where "typeEntite" = 'Enseignement'
group by lower(trim(organe))
having count(*) > 1
order by num desc;
order by organe_norm;







select organe, entite, count(*) as num
from elites_suisses.v_sphere_economique
--where entite ~ 'Crédit Suisse'
group by organe, entite
order by num desc;
order by organe, entite;

-- same query as above but order by entities
select entite, organe, count(*) as num
from elites_suisses.v_sphere_economique
where entite ~ 'Crédit Suisse'
group by organe, entite
order by entite, organe;



select organe, entite, count(*) as num, e.nom
from elites_suisses.v_sphere_economique vse
	left join elites_suisses.entites e on e.id = vse.id_entity 
--where "typeEntite" = 'Prix/Distinction'
group by organe, entite
order by organe, entite;



/*
 * CdA - Dir. générale
 */

select organe, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* 'cda'
where tmcu.organe ~* 'cda.*dir.*gén'
group by organe;

select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* 'CdA';

-- updates 13896
--update elites_suisses.t_mandates_cleaning_up tmcu set organe_clean_1 = 'conseil d''administration'
where tmcu.organe ~* 'CdA';

select tmcu.organe_clean_1, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* 'cda'
group by organe_clean_1;




select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* 'dir.*gén';

-- updates 2577
--update elites_suisses.t_mandates_cleaning_up tmcu set organe_clean_2 = 'direction générale'
where tmcu.organe ~* 'dir.*gén'



select tmcu.organe_clean_2, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* 'cda'
group by organe_clean_2;


/*
 * Comité dir.
 */

select organe, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* 'comit'
--where tmcu.organe ~* 'comit.*dir.{1,3}$'
group by organe
order by num desc;

select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* 'comit.*dir.{1,3}';

select organe, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* '^comit.{1,2}$'
--where tmcu.organe ~* 'comit.*dir.{1,3}$'
group by organe
order by num desc;



-- updates 1051
--update elites_suisses.t_mandates_cleaning_up tmcu set organe_clean_1 = 'comité directeur'
where tmcu.organe ~* 'comit.*dir.{1,3}$'
and length(organe_clean_1)=0 or tmcu.organe_clean_1 is null;

-- updates 3019
--update elites_suisses.t_mandates_cleaning_up tmcu set organe_clean_1 = 'comité'
where tmcu.organe ~* '^comit.{1,2}$'
and length(organe_clean_1)=0 or tmcu.organe_clean_1 is null;



select tmcu.organe_clean_1, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* 'cda'
group by organe_clean_1;








select *
from elites_suisses.entites e 
where nom = 'Worb';


select entite, e.nom, e."idEntite", e.id, sa.id_entity 
from elites_suisses.v_sphere_economique sa
 left join elites_suisses.entites e on e."idEntite" = sa."idEntite" 
 and e.nom != 'Worb'
 limit 100;

select entite, count(*) as num, e.nom, e."idEntite"
from elites_suisses.v_sphere_economique sa
 left join elites_suisses.entites e on e."idEntite" = sa."idEntite" 
 and e.nom != 'Worb'
--where sa."typeEntite" = 'Enseignement'
group by entite, e.nom,e."idEntite"
order by entite;



select entite, count(*) as num, e.nom original_entity_name, cg.name_standard, sa.fk_crm_group, cg.pk_crm_group 
from elites_suisses.v_sphere_economique sa
 left join elites_suisses.entites e on e."idEntite" = sa."idEntite" 
 and e.nom != 'Worb'
left join elites_suisses.crm_group cg on cg.pk_crm_group = sa.fk_crm_group 
--where sa."typeEntite" = 'Enseignement'
group by entite, e.nom, cg.name_standard, cg.pk_crm_group,sa.fk_crm_group
order by entite;

--drop table elites_suisses.t_entity_sub_entity_education ;
--create table elites_suisses.t_entity_sub_entity_education AS
select row_number() OVER (ORDER BY 1)::INTEGER as id, count(*) as num, sa.entite, sa.fk_crm_group , null as fk_crm_group_manual, cg.name_standard,  sa.organe, 
	null as fk_crm_group_organe_manual, sa.fk_crm_group_organe, notes,
  	e.nom entity_name, e.id id_entity, string_agg(sa.id::varchar, ',')
from elites_suisses.v_sphere_economique sa
 left join elites_suisses.entites e on e."idEntite" = sa."idEntite" 
 and e.nom != 'Worb'
left join elites_suisses.crm_group cg on cg.pk_crm_group = sa.fk_crm_group 
--where sa."typeEntite" = 'Enseignement'
group by sa.entite, sa.organe, e.nom, cg.name_standard, cg.pk_crm_group,sa.fk_crm_group, sa.fk_crm_group_organe, e.id
order by entite;

alter table elites_suisses.t_entity_sub_entity_education add CONSTRAINT t_entity_sub_entity_pk PRIMARY key (id);



/*
 * Table to be used to associate entities 
 * to the crm_group table identifiers
 */

select * 
from elites_suisses.t_entity_sub_entity_education
order by id;


/*
 * add pk from crm_group
 */

select cg.pk_crm_group, cg.name_standard, tesee.entity_name  
from elites_suisses.t_entity_sub_entity_education tesee 
 join elites_suisses.crm_group cg on cg.fk_source_entity  = tesee.id_entity ;

--update elites_suisses.t_entity_sub_entity_education tesee set fk_crm_group = cg.pk_crm_group
from elites_suisses.crm_group cg 
where cg.fk_source_entity  = tesee.id_entity 
and tesee.fk_crm_group is null;



select *
from elites_suisses.mandat m 
where id in (66454,64080)


/*
 * inspection des typeEntite
 */

select vsa."typeEntite", count(*) as num
from elites_suisses.v_sphere_economique vsa 
group by vsa."typeEntite" 
order by num desc;






/*
 * inspection des fonctions
 */

select vsa.fonction, count(*) as num
from elites_suisses.v_sphere_economique vsa 
group by vsa.fonction 
order by num desc;



/*
 * inspection des "partiAffiliationOfficeSecteur"
 */

select vsa."partiAffiliationOfficeSecteur", count(*) as num
from elites_suisses.v_sphere_economique vsa 
group by vsa."partiAffiliationOfficeSecteur"
order by num desc;


select vsa."partiAffiliationOfficeSecteur", vsa.fonction, count(*) as num
from elites_suisses.v_sphere_economique vsa 
group by vsa."partiAffiliationOfficeSecteur",vsa.fonction 
order by num desc;