
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




/*
 * Social roles 
*/

select * 
from elites_suisses.social_role;



/*
 * canton governments
 */

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif' and
length(e_nom) > 2 and
m_type_entite ~* 'can';

select *
from elites_suisses.mandat m 
where organe ~* 'cutif' and
length(entite) > 2 and
m."typeEntite" ~* 'can';

select distinct e_id, concat(e'Conseil d\'État du canton ', e_nom), e_nom
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif' and 
m_type_entite ~* 'can'
and e_nom !~ 'orpa'
and e_nom !~ 'ossa'
and e_nom !~ 'uri'
order by e_nom;


--insert into elites_suisses.crm_group ("name", description, import_notes)
select distinct concat(e'Conseil d\'État du canton ', e_nom) nom, concat(e'Conseil d\'État du canton ', e_nom),  '20260415_imp1'
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif' and 
m_type_entite ~* 'can'
and e_nom !~ 'orpa'
and e_nom !~ 'ossa'
and e_nom !~ 'uri'
order by nom;



--insert into elites_suisses.crm_group ("name", description, fk_source_entity, import_notes)
select distinct concat(e'Canton ', e_nom), concat(e'Canton ', e_nom),
e_id, '20260415_imp2'
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif'
and m_type_entite ~* 'can'
and length(e_nom) = 2;



/*
 * canton parlaments
 */

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'gislati' and
length(e_nom) > 2 and
m_type_entite ~* 'can';

select *
from elites_suisses.mandat m 
where organe ~* 'gislati' and
length(entite) > 2 and
m."typeEntite" ~* 'can';

select distinct e_id, concat(e'Parlement cantonal du Canton de ', e_nom), e_nom
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'gislati' 
and  m_type_entite ~* 'can'
and length(e_nom) = 2
order by e_nom;


--insert into elites_suisses.crm_group ("name", description, fk_source_entity, import_notes, fk_group_type)
select distinct concat(e'Parlement cantonal du Canton de ', e_nom) nom, concat(e'Législatif du canton ', e_nom),
'20260415_imp3', 3
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'gislati' 
and  m_type_entite ~* 'can'
and length(e_nom) = 2
order by nom;


--insert into elites_suisses.crm_group ("name", description, fk_source_entity, import_notes)
select distinct concat(e'Canton ', e_nom), concat(e'Canton ', e_nom),
e_id, '20260415_imp2'
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'cutif'
and m_type_entite ~* 'can'
and length(e_nom) = 2;




/*
 * Add missing entities to groups
 */
select * 
from elites_suisses.entites e
limit 100;

select distinct e.nom, e."typeEntite", e. , cg.name_standard, cg.name_original, cg.fk_source_entity 
from elites_suisses.entites e
   left join elites_suisses.crm_group cg on e.id = cg.fk_source_entity     
order by e.nom ; 
























