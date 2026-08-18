

select m.id, m.sphere, m."typeEntite", '' as type_ent_cleaned,  null as fk_type_ent,
entite, '' as entite_clean, m.id_entity, null as fk_group,
m.organe, '' as organe_clean_1, null as fk_group_organe_clean_1,
'' as organe_clean_2, null as fk_group_organe_clean_2,
m.fonction, null as fk_fonction,
m."partiAffiliationOfficeSecteur", '' as parti_clean_1, null as fk_group_parti_clean_1,
entite, '' as entite_clean, null as fk_group,
*
FROM elites_suisses.mandat m
limit 200;

drop table elites_suisses.t_mandates_cleaning_up ;
create table elites_suisses.t_mandates_cleaning_up as 
select row_number() OVER (ORDER BY 1)::INTEGER pk_t_mandates_cleaning_up, m.id, 
m.sphere, m."typeEntite", '' as type_ent_cleaned,
entite, '' as entite_clean, m.id_entity, null::integer as fk_group, null::integer as fk_type_group,
m.fonction, '' as fonction_clean_1, null::integer as fk_fonction_1,
'' as fonction_clean_2, null::integer as fk_fonction_2,
m.organe, '' as organe_clean_1, null::integer as fk_group_organe_clean_1,
'' as organe_clean_2, null::integer as fk_group_organe_clean_2,
m."partiAffiliationOfficeSecteur", '' as parti_clean_1, null::integer as fk_group_parti_clean_1
FROM elites_suisses.mandat m;

-- primary key
alter table elites_suisses.t_mandates_cleaning_up add CONSTRAINT t_mandates_cleaning_up_pk PRIMARY key (pk_t_mandates_cleaning_up);

-- FOREIGN KEY to mandat
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_mandat foreign key (id) 
	references elites_suisses.mandat(id);

-- FOREIGN KEY to group
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_group foreign key (fk_group) 
	references elites_suisses.t_group(pk_group);

-- FOREIGN KEY to group type
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_group_type foreign key (fk_type_group) 
	references elites_suisses.t_group_type(pk_group_type);

-- FOREIGN KEY to social role: fk_fonction_1
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_fonction_1 foreign key (fk_fonction_1) 
	references elites_suisses.t_social_role (pk_social_role);

-- FOREIGN KEY to social role: fk_fonction_2
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_fonction_2 foreign key (fk_fonction_2) 
	references elites_suisses.t_social_role (pk_social_role);


-- FOREIGN KEY to fk_group_organe_clean_1
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_group_organe_clean_1 foreign key (fk_group_organe_clean_1) 
	references elites_suisses.t_group(pk_group);


-- FOREIGN KEY to fk_group_organe_clean_2
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_group_organe_clean_2 foreign key (fk_group_organe_clean_2) 
	references elites_suisses.t_group(pk_group);


-- FOREIGN KEY to fk_group_parti_clean_1
alter table elites_suisses.t_mandates_cleaning_up add constraint fk_group_parti_clean_1 foreign key (fk_group_parti_clean_1) 
	references elites_suisses.t_group(pk_group);



/*
 * Add the already associated groups (through the entities table)
 */

select distinct tmcu.entite, tg.name_standard
from elites_suisses.t_mandates_cleaning_up tmcu 
 left join elites_suisses.t_group tg on tg.fk_source_entity = tmcu.id_entity 
offset 500
limit 30;

-- updated 104913
--update elites_suisses.t_mandates_cleaning_up tmcu set fk_group = pk_group
from elites_suisses.t_group tg
where tg.fk_source_entity = tmcu.id_entity ;

select count(*)
from elites_suisses.t_mandates_cleaning_up ;




