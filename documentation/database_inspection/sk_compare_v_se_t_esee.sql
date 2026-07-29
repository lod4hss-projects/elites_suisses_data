
/*
 * Check why view v_sphere_academique for "typeEntite" = 'Enseignement'
 * has different number of entries than t_entity_sub_entity_education.
 * 
 * Note: Both tables (the v_sphere_academique view and the t_entity_sub_entity_education
 * table) are from the mandates table.
 * 
 * The reason may be because the data from crm_group, which was brought into
 * t_entity_sub_entity_education for the purpose of matching the groups from
 * the mandats table with the groups from the entites table, was joined using
 * idEntite (and not id_entity).
 *
 * However the two were matched/joined, the difference in number of entries
 * reveals some erroneous attributions to entities in the mandats table.
 * This script documents these cases.
 * 
 * Important premise: t_entity_sub_entity_education contains only distinct
 * cases from the v_sphere_academique table for the fields entite and organe,
 * and where "typeEntite" = 'Einseignement'.
 */

-- Full table view:
SELECT * FROM elites_suisses.t_entity_sub_entity_education ;
SELECT * FROM elites_suisses.v_sphere_academique ; 

-- First compare number of rows in t_entity_sub_entity_education with v_sphere_academique
SELECT * FROM elites_suisses.t_entity_sub_entity_education 
ORDER BY id ; -- 1800 cases
SELECT entite, organe --, id_entity
FROM elites_suisses.v_sphere_academique
WHERE "typeEntite" = 'Enseignement'
GROUP BY entite, organe --, id_entity
ORDER BY entite, organe ; --, id_entity ; -- 1791 cases
-- Result: 9 cases more in t_entity_sub_entity_education


/* Example case: these two mandats share the same entite name, but have not the same
 * id_entity
 */

SELECT * from elites_suisses.mandat
where id in (45056, 61794) ;
-- both have entite = 'Handelshochschule Leipzig'
-- but id_entity = 2379 ('Universität Leipzig') for the first,
-- and 3506 ('Handelshochschule Leipzig') for the second, respectively.

-- These 9 cases for the above selection are documented in the markdown:
-- documentation/information_analysis/t_entity_sub_entity_education.md

-- Falsly assigned entite names in the mandats table could be further cleaned according to this procedure.

