
SELECT *
FROM elites_suisses.mandat
LIMIT 100;


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