*--

SELECT * From elites_suisses.mandat
WHERE id IN (49064,49621,44484,44522,49376,41455,49596,41731,41390,44523,49597,49375,38283,49264,49377,49275,49316,40423,39690,49317,49276,58824,44520,44521,44777,49714,49831,49059,44778,39306,49038,49637,49694,39241,39711,44657,44873,39219,39185,40022,44779,49847,39548,40239,44760,38658,44557,49140,49791,49130,44483,38660,49869,49801,58787,49081,44776) ;

SELECT "typeEntite", COUNT(*) anzahl
FROM elites_suisses.entites 
GROUP BY "typeEntite" 
ORDER BY anzahl DESC;

SELECT sphere, "typeEntite"
FROM elites_suisses.entites 
GROUP BY sphere, "typeEntite" 
ORDER BY sphere ASC;

select *
FROM elites_suisses.entites e 
where e."typeEntite" = 'Prix/Distinction';

SELECT * FROM elites_suisses.crm_group
WHERE name_standard ~* 'bryant'
ORDER BY name_standard ASC ;

SELECT * FROM elites_suisses.education
WHERE "Institution" ~* 'bryant' ;

SELECT * FROM elites_suisses.entites
WHERE id = 3348 ;

select vsa."partiAffiliationOfficeSecteur", vsa.fonction, count(*) as num
from elites_suisses.v_sphere_academique vsa 
group by vsa."partiAffiliationOfficeSecteur",vsa.fonction 
order by num desc;