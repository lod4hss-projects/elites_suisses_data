

select m.id, m.sphere, m."typeEntite", '' as type_ent_cleaned,  null as fk_type_ent,
entite, '' as entite_clean, m.id_entity, null as fk_group,
m.organe, '' as organe_clean_1, null as fk_group_organe_clean_1,
'' as organe_clean_2, null as fk_group_organe_clean_2,
m."partiAffiliationOfficeSecteur", '' as parti_clean_1, null as fk_group_parti_clean_1,
entite, '' as entite_clean, null as fk_group,
*
FROM elites_suisses.mandat m
limit 200;

drop table elites_suisses.t_mandates_cleaning_up ;
create table elites_suisses.t_mandates_cleaning_up as 
select row_number() OVER (ORDER BY 1)::INTEGER pk_t_mandates_cleaning_up, m.id, m.sphere, m."typeEntite", '' as type_ent_cleaned, null as fk_type_ent,
entite, '' as entite_clean, m.id_entity, null as fk_group,
m.organe, '' as organe_clean_1, null as fk_group_organe_clean_1,
'' as organe_clean_2, null as fk_group_organe_clean_2,
m."partiAffiliationOfficeSecteur", '' as parti_clean_1, null as fk_group_parti_clean_1
FROM elites_suisses.mandat m;

-- primary key
alter table elites_suisses.	 add CONSTRAINT t_mandates_cleaning_up_pk PRIMARY key (pk_t_mandates_cleaning_up);

-- FOREIGN KEY 
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_mandat foreign key (id) 
	references elites_suisses.mandat(id);







select organe, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* 'cda'
where tmcu.organe ~* 'cda.*dir.*gén'
group by organe;

select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* 'CdA';

update elites_suisses.t_mandates_cleaning_up tmcu set organe_clean_1 = 'conseil d''administration'
where tmcu.organe ~* 'CdA';

select tmcu.organe_clean_1, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.organe ~* 'cda'
group by organe_clean_1;



