
/*
 * Exploration de l'ensemble
 */


-- Nombre de mandats
select count(*) as num
from elites_suisses.mandat m ;


-- Nombre de mandats avec organisation d'exercice identifiée
select count(*) as num
from elites_suisses.mandat m 
where m.fk_crm_group_organe is not null;

-- Organisations identifiées
select m.fk_crm_group_organe, cg."name", count(*) as num, gt."name" 
from elites_suisses.mandat m , 
		elites_suisses.crm_group cg,
		elites_suisses.group_type gt 
where cg.pk_crm_group = m.fk_crm_group_organe 
and gt.pk_group_type = cg.fk_group_type 
group by  m.fk_crm_group_organe, cg."name", gt."name" 
order by num desc
limit 10;

--- Exemples
SELECT *
from elites_suisses.mandat m 
where m.fk_crm_group_organe is not NULL
and m."typeEntite" ~* 'féd'
LIMIT 50;



-- Nombre de mandats avec role identifié
select count(*) as num
from elites_suisses.mandat m 
where m.fk_social_role_fonction is not null;


-- Roles et organes identifiées
select count(*) as frequency, m.fk_social_role_fonction::integer, sr."name", m.fk_crm_group_organe::integer, cg."name",  gt."name" 
from elites_suisses.mandat m
	join elites_suisses.social_role sr on sr.pk_social_role = m.fk_social_role_fonction 
	left join elites_suisses.crm_group cg on cg.pk_crm_group = m.fk_crm_group_organe 
	left join elites_suisses.group_type gt on gt.pk_group_type = cg.fk_group_type 
group by m.fk_social_role_fonction, sr."name", m.fk_crm_group_organe, cg."name", gt."name" 
order by cg."name", sr."name" desc;







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

-- inspect social role
select m.id, m.entite, m.organe, m."partiAffiliationOfficeSecteur", cg."name", m.fk_crm_group_organe, cg.fk_group_type, sr."name", sr.pk_social_role 
from elites_suisses.mandat m 
  left join elites_suisses.crm_group cg on cg.pk_crm_group = m.fk_crm_group_organe 
  left join elites_suisses.social_role sr on sr.fk_group_type = cg.fk_group_type 
where cg.fk_group_type = 1;

-- update social role
--update elites_suisses.mandat m set fk_social_role_fonction = 3
from elites_suisses.crm_group cg
where cg.pk_crm_group = m.fk_crm_group_organe 
and cg.fk_group_type = 1;

select m.*
from elites_suisses.mandat m, elites_suisses.crm_group cg
where cg.pk_crm_group = m.fk_crm_group_organe 
and cg.fk_group_type = 1;

select m.*
from elites_suisses.mandat m
where  m.fk_social_role_fonction =3
limit 1000;



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



-- inspect social role
select m.id, m.entite, m.organe, m."partiAffiliationOfficeSecteur", cg."name", m.fk_crm_group_organe, cg.fk_group_type, sr."name", m.fk_social_role_fonction, sr.pk_social_role 
from elites_suisses.mandat m 
  left join elites_suisses.crm_group cg on cg.pk_crm_group = m.fk_crm_group_organe 
  left join elites_suisses.social_role sr on sr.fk_group_type = cg.fk_group_type 
where cg.fk_group_type = 3;

-- update social role
--update elites_suisses.mandat m set fk_social_role_fonction = 2
from elites_suisses.crm_group cg
where cg.pk_crm_group = m.fk_crm_group_organe 
and cg.fk_group_type = 3;

select m.*
from elites_suisses.mandat m, elites_suisses.crm_group cg
where cg.pk_crm_group = m.fk_crm_group_organe 
and cg.fk_group_type = 1;


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





select m.fk_crm_group_organe, cg."name", count(*) as num, gt."name" 
from elites_suisses.mandat m , 
		elites_suisses.crm_group cg,
		elites_suisses.group_type gt 
where cg.pk_crm_group = m.fk_crm_group_organe 
and gt.pk_group_type = cg.fk_group_type 
group by  m.fk_crm_group_organe, cg."name", gt."name" 
order by num desc;
order by m.fk_crm_group_organe;


