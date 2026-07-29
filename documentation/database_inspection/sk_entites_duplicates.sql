
/* Check for distinct entries in the entites table (= entities with same name) */

-- List all entries:
SELECT *
FROM elites_suisses.entites ;
-- = 3554
-- List distinct entries:
SELECT DISTINCT nom
FROM elites_suisses.entites ;
-- = 3540
-- Result: 14 duplicates

-- Look for dublicates:
SELECT nom, COUNT(*) num
FROM elites_suisses.entites
GROUP BY nom
ORDER BY num DESC, nom ASC ;
-- Result: one quintublicate (5x same nom) plus ten dublicates (2x same nom)

-- List all 25 cases:
SELECT *
FROM elites_suisses.entites
WHERE nom = 'Pharmacies coopératives populaires (Société des)'
OR nom = 'Asile évangélique de Nice'
OR nom = 'Comité central international des Unions chrétiennes de jeunes gens'
OR nom = 'Cortaillod'
OR nom = 'Olten'
OR nom = 'Parti politique'
OR nom = 'Schlieren'
OR nom = 'Société d''activité chrétienne de jeunesse'
OR nom = 'Société de prévoyance pour l''hiver (Diaconies)'
OR nom = 'Union chrétienne cadette de jeunes gens'
OR nom = 'Union chrétienne de jeunes filles'
ORDER BY nom ASC ;
-- Result: entities with id 2096, 2097, 2098, 2099 seem to be duplicates of id 2094.
-- Result: only id 2094 has mandates assigned to it (i.e., exists in the mandates table).
-- The others have neither mandats nor education assigned, see:
SELECT *
FROM elites_suisses.mandat
WHERE id_entity IN (2094,2096,2097,2098,2099) ;
SELECT *
FROM elites_suisses.education
WHERE id_entity IN (2094,2096,2097,2098,2099) ;
--.