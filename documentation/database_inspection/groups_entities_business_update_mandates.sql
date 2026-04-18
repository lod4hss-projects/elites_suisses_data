
-- tous
select count(*) as num
from elites_suisses.mandat m 
where m_type_entite = 'Entreprise';

-- alignés
select count(*) as num
from elites_suisses.mandat m 
where m.fk_crm_group_organe is not null;


select m.fk_crm_group_organe, cg."name", count(*) as num
from elites_suisses.mandat m , elites_suisses.crm_group cg 
where cg.pk_crm_group = m.fk_crm_group_organe 
group by  m.fk_crm_group_organe, cg."name"
order by m.fk_crm_group_organe;


/*
 * entités et organes / organes dans les entités
 * crm:74 Group
*/

select *
from elites_suisses.crm_group ;


select *
from elites_suisses.v_groups_from_mandates
LIMIT 20;

select m_type_entite, sum(number) as sum_mandates
from elites_suisses.v_groups_from_mandates
group by m_type_entite
order by sum_mandates desc;

select m_type_entite, sum(number) as sum_mandates
from elites_suisses.v_groups_from_mandates
group by m_type_entite
order by m_type_entite;


select m_type_entite, m_organe , sum(number) as sum_mandates
from elites_suisses.v_groups_from_mandates
group by m_type_entite,m_organe 
order by m_type_entite, m_organe;
order by sum_mandates desc;


/*
 * Entreprises
 * 
 * Différence entre CdA et direction générale ?
 */

-- entreprises
select m_type_entite, m_organe , sum(number) as sum_mandates
from elites_suisses.v_groups_from_mandates
where m_type_entite = 'Entreprise'
group by m_type_entite,m_organe 
--order by m_type_entite, m_organe;
order by sum_mandates desc;








/*
 * CdA
 */

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where m_organe ~* 'cda';


select *
from elites_suisses.mandat m 
where m.organe ~* 'cda'
limit 100;

-- functions in a CdA
select fonction, count(*) as num, string_agg(distinct m.organe, ' / ' ) as types
from elites_suisses.mandat m 
where m.organe ~* 'cda'
group by fonction
order by num desc;