
SELECT *
FROM elites_suisses.mandat
LIMIT 100;

SELECT count(*) number
FROM elites_suisses.mandat
LIMIT 100;



-- mandats sans entité
select m.*
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null;

select count(*) as n
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null;


-- entités manquantes
select m.entite_id, m.entite, count(*) as n, m."idEntite"
from elites_suisses.mandat m 
left join elites_suisses.entites e on e.id = m.entite_id 
where e.id is null
group by m.entite_id, m."idEntite", m.entite
order by n desc;



--- distribution of functions
SELECT fonction, organe, "typeEntite", COUNT(*) as number
FROM elites_suisses.mandat
GROUP BY fonction, organe, "typeEntite"
ORDER BY number DESC;

select *
from elites_suisses.mandat m
where m.fonction = 'Membre'
and m.organe = 'Exécutif'
and m."typeEntite" = 'Autorités cant.'
limit 50;


--- distribution of entity
SELECT organe, COUNT(*) as number
FROM elites_suisses.mandat_versions
GROUP BY organe
ORDER BY number DESC;



--- distribution of functions
SELECT typeentite, COUNT(*) as number
FROM elites_suisses.mandat_versions
GROUP BY typeentite
ORDER BY number DESC;



select m."partiAffiliationOfficeSecteur", COUNT(*) as number
FROM elites_suisses.mandat m
GROUP BY m."partiAffiliationOfficeSecteur"
ORDER BY number DESC;











--- distribution of entity
SELECT organe, COUNT(*) as number
FROM elites_suisses.mandat_versions
GROUP BY organe
ORDER BY number DESC;


--- distribution of entity
SELECT partiaffiliationofficesecteur, COUNT(*) as number
FROM elites_suisses.mandat_versions
GROUP BY partiaffiliationofficesecteur
ORDER BY number DESC;


--- distribution of entity
SELECT sphere, COUNT(*) as number
FROM elites_suisses.mandat_versions
GROUP BY sphere
ORDER BY number DESC;