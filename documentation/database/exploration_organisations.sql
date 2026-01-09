

-- nombre de personnes
-- 3990 en octobre 2025

select count(*) as effectif
from elites_suisses.entite_versions ev   ;


select t1.*
from  elites_suisses.entite_versions t1
order by id 
LIMIT 50;



-- pas de doubons, apparemment
select t1.id, count(*) as effectif
from elites_suisses.entite_versions t1
group by t1.id
HAVING count(*) > 1
order by effectif desc
limit 50;






-- doublons versions mandats
select t1.idmandat, count(*) as effectif
from elites_suisses.mandat_versions t1 
group by t1.idmandat 
order by effectif desc
limit 50;


-- doublons mandats
select t1.idmandat, t1.versiondate, count(*) as effectif
from elites_suisses.mandat_versions t1 
group by t1.idmandat, t1.versiondate  
order by effectif desc
limit 50;



select *
from elites_suisses.mandat_versions t1 
where t1.idmandat in ('mandat35224',
'mandat89108',
'mandat89106',
'mandat86535',
'mandat30686');



select t2.nom, t1.entite, t2.identite, count(*) as effectif
from elites_suisses.mandat_versions t1 
	join elites_suisses.entite_versions t2 on t2.identite = t1.identite 
group by t2.identite, t1.entite, t2.nom
order by effectif desc;
