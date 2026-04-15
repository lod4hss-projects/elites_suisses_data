
-- tous
select count(*) as num
from elites_suisses.mandat m ;

-- alignés
select count(*) as num
from elites_suisses.mandat m 
where m.fk_crm_group_organe is not null;


/*
 * entités et organes / organes dans les entités
 * crm:74 Group
*/

select *
from elites_suisses.crm_group ;






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
length(entite) = 2 and
m."typeEntite" ~* 'can';


-- Issue with Zurich
update elites_suisses.mandat m set fk_crm_group_organe = 26
where id = 93455;

-- Issue with BS
update elites_suisses.mandat m set fk_crm_group_organe = 6
where id = 85124;



select m.id, m.entite, m.organe, m."partiAffiliationOfficeSecteur", cg."name", cg.pk_crm_group, m.fk_crm_group_organe 
from elites_suisses.mandat m 
  left join elites_suisses.crm_group cg on cg."name" = concat(e'Conseil d\'État du canton ', entite)
where m.organe ~* 'cutif' and
length(m.entite) = 2 and
m."typeEntite" ~* 'can';


--update elites_suisses.mandat m set fk_crm_group_organe = cg.pk_crm_group
from elites_suisses.crm_group cg 
where m.organe ~* 'cutif' 
and cg."name" = concat(e'Conseil d\'État du canton ', entite)
and length(m.entite) = 2 and
m."typeEntite" ~* 'can';

select m.fk_crm_group_organe, cg."name", count(*) as num
from elites_suisses.mandat m , elites_suisses.crm_group cg 
where cg.pk_crm_group = m.fk_crm_group_organe 
group by  m.fk_crm_group_organe, cg."name"
order by m.fk_crm_group_organe;




/*
 * canton parlaments
 */


select *
from elites_suisses.v_groups_from_mandates
where 
m_organe ~* 'gislat' and
length(e_nom) > 2 and
m_type_entite ~* 'can';


select *
from elites_suisses.mandat m 
where organe ~* 'gislat' and
length(entite) = 2 and
m."typeEntite" ~* 'can';



select *
from elites_suisses.mandat
where 
organe ~* 'gislat' and
length(entite) > 2
and "typeEntite" ~* 'can'
and entite !~* 'Constit';



-- Issue with Lausanne
update elites_suisses.mandat m set fk_crm_group_organe = 75
where id = 106260;

-- Issue with AG?
-- selon le DHS, Fritz Schmutziger est ' 1935-46 Zuger FDP-Kantonsrat.' https://hls-dhs-dss.ch/de/articles/041176/2012-11-21/
update elites_suisses.mandat m set fk_crm_group_organe = 77
where id = 29432;



select m.id, m.entite, m.organe, m."partiAffiliationOfficeSecteur", cg."name", cg.pk_crm_group, m.fk_crm_group_organe 
from elites_suisses.mandat m 
  left join elites_suisses.crm_group cg on cg."name" = concat(e'Parlement cantonal du Canton de ', entite)
where m.organe ~* 'gislat' and
length(m.entite) = 2 and
m."typeEntite" ~* 'can';


--update elites_suisses.mandat m set fk_crm_group_organe = cg.pk_crm_group
from elites_suisses.crm_group cg 
where m.organe ~* 'gislat' 
and cg."name" = concat(e'Parlement cantonal du Canton de ', entite)
and length(m.entite) = 2 
and m."typeEntite" ~* 'can';

select m.fk_crm_group_organe, cg."name", count(*) as num
from elites_suisses.mandat m , elites_suisses.crm_group cg 
where cg.pk_crm_group = m.fk_crm_group_organe 
group by  m.fk_crm_group_organe, cg."name"
order by m.fk_crm_group_organe;




/*
 * Conseil national
 */

select count(*) as num
from elites_suisses.v_groups_from_mandates;

select *
from elites_suisses.v_groups_from_mandates
where m_nom ~* 'conseil.*ational'
and length(m_nom) < 30;

select *
from elites_suisses.v_groups_from_mandates
where e_id = 74;


select * 
from elites_suisses.mandat m 
where entities_id = 74
limit 10;

-- ajouté les conseillers nationaux
--update elites_suisses.mandat m set fk_crm_group_organe = 79
where entities_id = 74;





/*
 * Conseil fédéral
 */


select *
from elites_suisses.v_groups_from_mandates
where m_nom ~* 'conseil.*ational'
and length(m_nom) < 30;

select *
from elites_suisses.v_groups_from_mandates
where e_id = 74;


select * 
from elites_suisses.mandat m 
where entities_id = 74
limit 100;


select fonction, count(*) as num
from elites_suisses.mandat m 
where entities_id = 74
group by fonction
order by num desc;

/*
 * Association aux partis
 */


-- Labels des partis !!! 
select m."partiAffiliationOfficeSecteur", count(*) as num
from elites_suisses.mandat m 
where entities_id = 74
group by m."partiAffiliationOfficeSecteur"
order by num desc;


-- Association aux partis en tant que entités
select m."partiAffiliationOfficeSecteur", count(*) as num, e.id, e.nom, e."typeEntite" 
from elites_suisses.mandat m 
	left join elites_suisses.entites e on e.nom = m."partiAffiliationOfficeSecteur"  
where entities_id = 74
group by m."partiAffiliationOfficeSecteur", e.id, e.nom, e."typeEntite"  
order by num desc;

-- Partis en tant que entités
select m."partiAffiliationOfficeSecteur", count(*) as num, e.id, e.nom, e."typeEntite" 
from elites_suisses.mandat m 
	left join elites_suisses.entites e on e.nom = m."partiAffiliationOfficeSecteur"  
where e."typeEntite" = 'Parti politique'
group by m."partiAffiliationOfficeSecteur", e.id, e.nom, e."typeEntite"  
order by num desc;


-- Partis en tant que entités
select m."partiAffiliationOfficeSecteur", count(*) as num, e.id, e.nom, e."typeEntite" 
from elites_suisses.mandat m 
	left join elites_suisses.entites e on e.nom = m."partiAffiliationOfficeSecteur"  
--where e."typeEntite" = 'Parti politique'
group by m."partiAffiliationOfficeSecteur", e.id, e.nom, e."typeEntite"  
order by num desc;

select *
from elites_suisses.entites e 
where e."typeEntite" = 'Parti politique'
order by e.nom ;





select m.fk_crm_group_organe, cg."name", count(*) as num
from elites_suisses.mandat m , elites_suisses.crm_group cg 
where cg.pk_crm_group = m.fk_crm_group_organe 
group by  m.fk_crm_group_organe, cg."name"
order by num desc;
order by m.fk_crm_group_organe;


