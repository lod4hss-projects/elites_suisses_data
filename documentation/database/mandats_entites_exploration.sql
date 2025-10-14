
SELECT *
FROM elites_suisses.mandat_versions
LIMIT 10;


--- distribution of functions
SELECT fonction, COUNT(*) as number
FROM elites_suisses.mandat_versions
GROUP BY fonction
ORDER BY number DESC;



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