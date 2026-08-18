
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


-- count the functions
select fonction, count(*) as num
from elites_suisses.mandat m 
where m.fk_sdh_group_organe = 79
group by fonction 
order by num desc;


select *
from elites_suisses.mandat m 
where m.fk_crm_group_organe = 79
--and m.fonction = 'Membre'
and m.fonction = 'Président'
limit 10;


--update elites_suisses.mandat m set fk_social_role_fonction = 1
where m.fk_crm_group_organe = 79
and m.fonction = 'Membre';

--update elites_suisses.mandat m set fk_social_role_fonction = 4
where m.fk_crm_group_organe = 79
and m.fonction = 'Président';






/*
 * Conseil aux Etats
 */

select *
from elites_suisses.entites 
where nom ~* 'Cons.*des.*tat';


select *
from elites_suisses.v_groups_from_mandates
where m_nom ~* 'Cons.*des.*tat'
and length(m_nom) < 30;

select *
from elites_suisses.v_groups_from_mandates
where e_id = 72;


select * 
from elites_suisses.mandat m 
where entities_id = 72
limit 100;

--entite orthographe
select m.entite, count(*) as num
from elites_suisses.mandat m 
where entities_id = 72
group by m.entite
order by num desc;

-- fonction
select fonction, count(*) as num
from elites_suisses.mandat m 
where entities_id = 72
group by fonction
order by num desc;


-- ajout des codes
--update elites_suisses.mandat m set fk_social_role_fonction = 7, fk_crm_group_organe = 81
where entities_id = 72
and m.fonction ~* 'Membre';



select * 
from elites_suisses.mandat m 
where entities_id = 72
limit 100;


/*
 * Conseil fédéral
 */

select *
from elites_suisses.entites 
where nom ~* 'Cons.*Fédéral';


select *
from elites_suisses.v_groups_from_mandates
where m_nom ~* 'conseil.*déral'
and length(m_nom) < 30;

select *
from elites_suisses.v_groups_from_mandates
where e_id = 73;


select * 
from elites_suisses.mandat m 
where entities_id = 73
limit 100;


select m.entite, count(*) as num
from elites_suisses.mandat m 
where entities_id = 73
group by m.entite
order by num desc;


select fonction, count(*) as num
from elites_suisses.mandat m 
where entities_id = 73
group by fonction
order by num desc;


select m.fk_social_role_fonction, m.fk_crm_group_organe, * 
from elites_suisses.mandat m 
where entities_id = 73
and m.fonction ~* 'Membre';


--update elites_suisses.mandat m set fk_social_role_fonction = 5, fk_crm_group_organe = 80 
where entities_id = 73
and m.fonction ~* 'Membre';


/*
 * https://hls-dhs-dss.ch/fr/articles/007317/2009-07-02/
 * 99333	Muralt, von	Hans Konrad	31.10.1779	10.12.1869
 * Landamman de la Suisse en 1840
 * 
 * entities_id = 73 est donc une erreur dans son cas
 * 
 */
select m.fk_social_role_fonction, m.fk_crm_group_organe, * 
from elites_suisses.mandat m 
where entities_id = 73
and m.fonction ~* 'Landaman';



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


