

-- nombre de personnes
-- 182458 en septembre 2025

select count(*) as effectif
from elites_suisses.identite_versions iv  ;


select iv.*
from elites_suisses.identite_versions iv
order by id 
LIMIT 50;




select iv.id, count(*) as effectif
from identite_versions iv
group by iv.id
HAVING effectif > 1
order by iv.id 
limit 50;

-- persons with more then one mention
with tw1 as (select iv.id , count(*) as effectif
from identite_versions iv
group by iv.id
HAVING count(*) > 1)
select count(*) as effectif
from tw1;



-- version la plus grande par personne
select iv.id, max(iv.versionDate) as date_version
from identite_versions iv
group by iv.id
limit 10;

-- une ligne par personne en ayant retenu la version la plus récente
with tw1 as (
select iv.id, max(iv.versionDate) as date_version,  max(iv.sysid) as sysid
from identite_versions iv
group by iv.id
)
select distinct iv.*
from identite_versions iv, tw1
where iv.id = tw1.id
and iv.versionDate = tw1.date_version
and iv.sysid = tw1.sysid 
order by id
LIMIT 10;


--create view for former query
CREATE view elites_suisses.v_persons as
with tw1 as (
select iv.id, max(iv.versionDate) as date_version,  max(iv.sysid) as sysid
from identite_versions iv
group by iv.id
)
select distinct iv.*
from identite_versions iv, tw1
where iv.id = tw1.id
and iv.versionDate = tw1.date_version
and iv.sysid = tw1.sysid 
order by id;





-- nombre personnes : 48221
with tw1 as (
select iv.id, max(iv.versionDate) as date_version,  max(iv.sysid) as sysid
from identite_versions iv
group by iv.id
), tw2 as (
select distinct iv.*
from identite_versions iv, tw1
where iv.id = tw1.id
and iv.versionDate = tw1.date_version
and iv.sysid = tw1.sysid 
)
select count(*) as effectif
from tw2;




