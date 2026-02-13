
-- nombre de lignes
select count(*)
from elites_suisses.filiation_versions fv ;

-- afficher 10 ligne 
select fv."sysid", fv.idfils, fv.idparent, fv.sexeparent, fv.creation, fv.saisie, fv.modification, fv.auteurmodif, fv.zkp_filiation, fv.modif, fv.versiondate
from elites_suisses.filiation_versions fv 
limit 10;

-- version, effectifs: appatently unique relationships
select fv.idfils, fv.idparent, count(*) as eff
from elites_suisses.filiation_versions fv 
group by fv.idfils, fv.idparent 
order by eff desc
limit 10;

