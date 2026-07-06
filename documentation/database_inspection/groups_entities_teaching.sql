
/*
 * We use the view aggregating 
 */

-- canton parliaments
select *
from elites_suisses.v_groups_from_mandates
where m_organe ~* 'légis' 
and m_type_entite ~* 'can'
order by e_nom;






/*
 * entités et organes / organes dans les entités
 * crm:74 Group
*/

select *
from elites_suisses.crm_group ;



select m.entite, m."idEntite", m."typeEntite", count(*) num, m.fk_crm_group_organe, string_agg(distinct m.organe, '|') organs
from elites_suisses.mandat m 
group by m.entite, m."idEntite", m."typeEntite", m.fk_crm_group_organe 
having count(*)  > 1
order by m.entite;


