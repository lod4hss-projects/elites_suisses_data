

select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Politique'
order by fonction;



select fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Politique'
group by fonction
having count(*) > 0
order by fonction;



/*
 * add federal and cantonal organisations
 */


-- update conseils d'état
select tg.pk_group, tg.name_standard, trim(concat('conseils_état_20260819', ' ', tmcu.updates_notes)),
tmcu.fk_group, tmcu."typeEntite" , tmcu.entite, tmcu.fonction, tmcu.organe 
from elites_suisses.t_mandates_cleaning_up tmcu,
elites_suisses.t_group tg 
where tmcu.fk_group = tg.fk_part_of 
and tg.fk_group_type = 1
and tmcu."typeEntite" ~ 'cant'
and tmcu."organe" ~ 'Ex'
order by tmcu.entite ;


--update elites_suisses.t_mandates_cleaning_up tmcu set fk_group_organe_clean_1 = tg.pk_group, 
updates_notes=trim(concat('conseils_etat_20260819', ' ', tmcu.updates_notes))
from elites_suisses.t_group tg 
where tmcu.fk_group = tg.fk_part_of 
and tg.fk_group_type = 1
and tmcu."typeEntite" ~ 'cant'
and tmcu."organe" ~ 'Ex';

select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where updates_notes ~'conseils_etat_20260819';


/*
 *  parlements cantonaux
 */

-- add parent groups to canton parlaments
select tg.pk_group, tg.name_standard, tg.fk_part_of, tg1.pk_group, tg1.name_standard 
from elites_suisses.t_group tg 
	left join  elites_suisses.t_group tg1
		on right(tg.name_standard,2) = right(tg1.name_standard,2)
where tg.fk_group_type = 3
and tg1.fk_group_type = 2;

--update elites_suisses.t_group tg set fk_part_of = tg1.pk_group
from elites_suisses.t_group tg1
where tg.fk_group_type = 3
and tg1.fk_group_type = 2
and right(tg.name_standard,2) = right(tg1.name_standard,2);


select tmcu.pk_t_mandates_cleaning_up, tg.pk_group, tg.name_standard, trim(concat('parlement_cantonal_20260819', ' ', tmcu.updates_notes)),
tmcu.fk_group, tmcu."typeEntite" , tmcu.entite, tmcu.organe, tmcu.fonction, tmcu.fonction_clean_1 
from elites_suisses.t_mandates_cleaning_up tmcu,
elites_suisses.t_group tg 
where tmcu.fk_group = tg.fk_part_of 
and tg.fk_group_type = 3
and tmcu."typeEntite" ~ 'cant'
and tmcu."organe" ~ 'gisla'
order by tmcu.pk_t_mandates_cleaning_up ;

--update elites_suisses.t_mandates_cleaning_up tmcu set fk_group_organe_clean_1 = tg.pk_group, 
updates_notes=trim(concat('parlement_cantonal_20260819', ' ', tmcu.updates_notes))
from elites_suisses.t_group tg 
where tmcu.fk_group = tg.fk_part_of 
and tg.fk_group_type = 3
and tmcu."typeEntite" ~ 'cant'
and tmcu."organe" ~ 'gisla';

select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where updates_notes ~'parlement_cantonal_20260819';









