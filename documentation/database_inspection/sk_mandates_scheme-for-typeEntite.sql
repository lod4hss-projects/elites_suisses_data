
-- Check for all "typeEntite" in all spheres:

-- Academique
SELECT "typeEntite", COUNT (*) AS num
FROM elites_suisses.v_sphere_academique
GROUP BY "typeEntite"
ORDER BY "typeEntite" ASC ;

-- Administrative
SELECT "typeEntite", COUNT (*) AS num
FROM elites_suisses.v_sphere_administrative
GROUP BY "typeEntite"
ORDER BY "typeEntite" ASC ;

-- Economique
SELECT "typeEntite", COUNT (*) AS num
FROM elites_suisses.v_sphere_economique
GROUP BY "typeEntite"
ORDER BY "typeEntite" ASC ;

-- Militaire
SELECT "typeEntite", COUNT (*) AS num
FROM elites_suisses.v_sphere_militaire
GROUP BY "typeEntite"
ORDER BY "typeEntite" ASC ;

-- Politique
SELECT "typeEntite", COUNT (*) AS num
FROM elites_suisses.v_sphere_politique
GROUP BY "typeEntite"
ORDER BY "typeEntite" ASC ;

-- Presse
SELECT "typeEntite", COUNT (*) AS num
FROM elites_suisses.v_sphere_presse
GROUP BY "typeEntite"
ORDER BY "typeEntite" ASC ;

-- Sociabilite
SELECT "typeEntite", COUNT (*) AS num
FROM elites_suisses.v_sphere_sociabilite
GROUP BY "typeEntite"
ORDER BY "typeEntite" ASC ;




/* Académique */


-- "typeEntite" in v_sphere_academique:
SELECT "typeEntite", COUNT (*) as num, entite, organe, id_entity
FROM elites_suisses.v_sphere_academique
GROUP BY entite, "typeEntite", organe, id_entity
ORDER BY entite, "typeEntite", organe, id_entity ;

-- "typeEntite" in v_sphere_academique:
SELECT "typeEntite", COUNT (*) as num, entite, organe, id_entity, "partiAffiliationOfficeSecteur", string_agg(m.id::varchar, ',')
FROM elites_suisses.v_sphere_academique m
GROUP BY entite, "typeEntite", organe, id_entity, "partiAffiliationOfficeSecteur"
ORDER BY entite, "typeEntite", organe, id_entity, "partiAffiliationOfficeSecteur" ;

SELECT *
FROM elites_suisses.v_sphere_academique
WHERE "typeEntite" = 'Association'
ORDER BY fonction ASC ;


/* Politique */

SELECT *
FROM elites_suisses.v_sphere_politique
ORDER BY entite ASC ;

SELECT *
FROM elites_suisses.v_sphere_politique
WHERE fonction = 'Zollkreisdirektor'
ORDER BY fonction ASC ;

SELECT *
FROM elites_suisses.v_sphere_politique
WHERE entite = 'Union Européenne'
ORDER BY entite ASC ;



/* Administrative */

SELECT *
FROM elites_suisses.v_sphere_administrative
WHERE "typeEntite" = 'Banque centrale'
ORDER BY fonction ASC ;

SELECT *
FROM elites_suisses.v_sphere_administrative
WHERE fonction = 'Zollkreisdirektor'
ORDER BY fonction ASC ;

SELECT *
FROM elites_suisses.v_sphere_administrative
WHERE entite = 'Union Européenne'
ORDER BY entite ASC ;





/* Economique */


SELECT *
FROM elites_suisses.v_sphere_economique
WHERE "typeEntite" = 'Recherche'
ORDER BY fonction ASC ;

SELECT *
FROM elites_suisses.v_sphere_economique
ORDER BY entite ASC ;

SELECT *
FROM elites_suisses.v_sphere_economique
WHERE fonction = 'Zollkreisdirektor'
ORDER BY fonction ASC ;

SELECT *
FROM elites_suisses.v_sphere_economique
WHERE entite = 'Union Européenne'
ORDER BY entite ASC ;


/* Sociabilité */

SELECT *
FROM elites_suisses.v_sphere_sociabilite
WHERE "typeEntite" = 'Philanthropie'
ORDER BY entite ASC ;
