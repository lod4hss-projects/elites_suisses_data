
/*
 * Membership
 */

-- choice of group
select 
	case 
		when fk_group_organe_clean_1 is not null
		then fk_group_organe_clean_1
		else fk_group
	end fk_group,
	id
from elites_suisses.t_mandates_cleaning_up tmcu
where tmcu.fonction_clean_1 = 'membre';

--drop view elites_suisses.v_membership;
create view elites_suisses.v_membership AS
with tw1 as (
select
	case 
		when fk_group_organe_clean_1 is not null
		then fk_group_organe_clean_1
		else fk_group
	end fk_group,
	id
from elites_suisses.t_mandates_cleaning_up tmcu
where tmcu.fonction_clean_1 = 'membre')
select 
-- should be added source: idMandat
m.id::integer, 
tw1.fk_group::integer, m."idIdentite"::integer as fk_person, 
m."anneeEntreeUtilisee"::integer begin_year, m."anneeSortieUtilisee"::integer end_year
from tw1, elites_suisses.mandat m 
where m.id=tw1.id 
and tw1.fk_group is not null
order by m."idIdentite";

select *
from elites_suisses.v_membership;

select *
from elites_suisses.v_membership
where "idIdentite" < 100000;



/*
*  Social rôle embodiment
*/



select * 
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.fonction_clean_1 > '';
and tmcu.fk_fonction_1 is not null;


select tmcu.fonction_clean_1, tmcu.fk_fonction_1  , count(*) as eff
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.fonction_clean_1 > ''
and tmcu.fonction_clean_1 != 'membre'
group by tmcu.fonction_clean_1 , tmcu.fk_fonction_1  
order by eff desc;




