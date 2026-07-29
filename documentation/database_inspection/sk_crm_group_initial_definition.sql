/* How crm_group table was initially created for higher education institutions
 * 
 * All distinct higher education institutions ("Institution") were selected from the education table,
 * where "Formation niveau" is ('Supérieure', 'Doctorat') and where id_entity is not NULL,
 * i.e. where there exists a corresponding entity in the entites table.
 * These were assigned the pk_group_type = 6 in the group_type table.
 */
 
-- Check for distinct "Institution" from education table, where id_entity is / is not NULL.
SELECT DISTINCT id_entity, "Institution" FROM elites_suisses.education
WHERE id_entity IS NULL
ORDER BY id_entity ASC ; -- 683 rows
SELECT DISTINCT id_entity, "Institution" FROM elites_suisses.education
WHERE id_entity IS NOT NULL
ORDER BY id_entity ASC ; -- 719 rows
--Total rows: 1402

-- Total num. of persons, where id_entity is / is not NULL.
SELECT * FROM elites_suisses.education
WHERE id_entity IS NULL
ORDER BY "Institution" DESC ; -- 15552
SELECT * FROM elites_suisses.education
WHERE id_entity IS NOT NULL
ORDER BY "Institution" ASC ; -- 18769
-- Example for id_entity is NULL:
SELECT * FROM elites_suisses.education
WHERE "Institution" = 'Akademie der Arbeit' ;

-- Order all by id_entity
SELECT * FROM elites_suisses.education
ORDER BY id_entity ASC ;
-- Order all by "Institution"
SELECT * FROM elites_suisses.education
ORDER BY "Institution" ASC ;

-- List distinct entities with "Formation niveau" Supérieure or Doctorat:
SELECT DISTINCT id_entity, "Institution"
FROM elites_suisses.education
WHERE id_entity IS NOT NULL
AND "Formation niveau" IN ('Supérieure', 'Doctorat')
ORDER BY "Institution" ASC ;
-- Result: 505 rows

-- List distinct entities as above but "Institution" name transformed in lower case:
SELECT DISTINCT id_entity, LOWER("Institution") AS "Institution_kleingeschrieben"
FROM elites_suisses.education
WHERE id_entity IS NOT NULL
AND "Formation niveau" IN ('Supérieure', 'Doctorat')
ORDER BY id_entity ASC ;
-- Result: 485 rows

-- Manual transformations of "Institution" name for 20 cases:
SELECT DISTINCT id_entity,
	CASE 
		WHEN "Institution" = 'UniZH' THEN 'UniZh'
    	WHEN "Institution" = 'Unibe' THEN 'UniBe'
		WHEN "Institution" = 'UNIBE' THEN 'UniBe'
		WHEN "Institution" = 'UNIFR' THEN 'UniFr'
		WHEN "Institution" = 'Unige' THEN 'UniGe'
		WHEN "Institution" = 'UniGE' THEN 'UniGe'
		WHEN "Institution" = 'UNIGE' THEN 'UniGe'
		WHEN "Institution" = 'Unil' THEN 'UniL'
		WHEN "Institution" = 'UNIL' THEN 'UniL'
		WHEN "Institution" = 'UniNE' THEN 'UniNe'
		WHEN "Institution" = 'UNINE' THEN 'UniNe'
		WHEN "Institution" = 'UniSvit' THEN 'UniSvIt'
		WHEN "Institution" = 'Columbia university' THEN 'Columbia University'
		WHEN "Institution" = 'Université catholique de Louvain' THEN 'Université Catholique de Louvain'
		WHEN "Institution" = 'Ecole polytechnique' THEN 'Ecole Polytechnique'
		WHEN "Institution" = 'Ecole centrale des arts et manufactures de Paris' THEN 'Ecole centrale des Arts et Manufactures de Paris'
		WHEN "Institution" = 'École libre des sciences politiques' THEN 'École Libre des Sciences Politiques'
        WHEN "Institution" = 'Académie des beaux-arts de Munich' THEN 'Académie des Beaux-Arts de Munich'
		WHEN "Institution" = 'Académie des Beaux-arts de Munich' THEN 'Académie des Beaux-Arts de Munich'
		WHEN "Institution" = 'Académie des beaux-arts de Düsseldorf' THEN 'Académie des Beaux-Arts de Düsseldorf'
		ELSE "Institution" 
    END AS "Institution_bereinigt"
FROM elites_suisses.education
WHERE id_entity IS NOT NULL
AND "Formation niveau" IN ('Supérieure', 'Doctorat') 
ORDER BY "Institution_bereinigt" ;
-- Result: 485 rows

-- Show number of degrees that were granted by all higher education institutions:
SELECT DISTINCT id_entity,
	CASE 
		WHEN "Institution" = 'UniZH' THEN 'UniZh'
    	WHEN "Institution" = 'Unibe' THEN 'UniBe'
		WHEN "Institution" = 'UNIBE' THEN 'UniBe'
		WHEN "Institution" = 'UNIFR' THEN 'UniFr'
		WHEN "Institution" = 'Unige' THEN 'UniGe'
		WHEN "Institution" = 'UniGE' THEN 'UniGe'
		WHEN "Institution" = 'UNIGE' THEN 'UniGe'
		WHEN "Institution" = 'Unil' THEN 'UniL'
		WHEN "Institution" = 'UNIL' THEN 'UniL'
		WHEN "Institution" = 'UniNE' THEN 'UniNe'
		WHEN "Institution" = 'UNINE' THEN 'UniNe'
		WHEN "Institution" = 'UniSvit' THEN 'UniSvIt'
		WHEN "Institution" = 'Columbia university' THEN 'Columbia University'
		WHEN "Institution" = 'Université catholique de Louvain' THEN 'Université Catholique de Louvain'
		WHEN "Institution" = 'Ecole polytechnique' THEN 'Ecole Polytechnique'
		WHEN "Institution" = 'Ecole centrale des arts et manufactures de Paris' THEN 'Ecole centrale des Arts et Manufactures de Paris'
		WHEN "Institution" = 'École libre des sciences politiques' THEN 'École Libre des Sciences Politiques'
        WHEN "Institution" = 'Académie des beaux-arts de Munich' THEN 'Académie des Beaux-Arts de Munich'
		WHEN "Institution" = 'Académie des Beaux-arts de Munich' THEN 'Académie des Beaux-Arts de Munich'
		WHEN "Institution" = 'Académie des beaux-arts de Düsseldorf' THEN 'Académie des Beaux-Arts de Düsseldorf'
		ELSE "Institution" 
    END AS "Institution_bereinigt",
	"TITRE_Codé",
	COUNT(*) AS "num"
FROM elites_suisses.education
WHERE id_entity IS NOT NULL
AND "Formation niveau" IN ('Supérieure', 'Doctorat') 
GROUP BY 
	id_entity,
	"Institution_bereinigt",
    "TITRE_Codé"
ORDER BY "TITRE_Codé" ASC ;