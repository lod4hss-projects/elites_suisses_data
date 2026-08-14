

/*
 * Issue with organisations that cover different organisations-groups
 * 
 * E.g. : cantons are referred to but in fact the Grand Conseil ou Gouvernement cantonal are intended
 * 
 */

select *
from elites_suisses.entites e 
where e.nom ~ 'TI';


select e."idEntite", e.nom, e."typeEntite", m."typeEntite", m.organe, m.fonction, m."partiAffiliationOfficeSecteur" 
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
where e.nom = 'TI'
limit 100;

/* 
 * in fact there are at least two groups: legislative, executive, sometimes judiciary
 * 
 * the kind of group is availabel in the 'organe' field of the _mandat_ table
 */
select e."idEntite", e.nom, m.organe, count(*) as number
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
where e.nom = 'TI'
group by e."idEntite", e.nom, m.organe;


select e."idEntite", e.nom, lower(m.organe) organe, count(*) as number
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
where e.nom = 'ZH'
group by e."idEntite", e.nom, lower(m.organe);

--
select e."idEntite", e.nom, lower(m.organe) organe, count(*) as number
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
where e.nom = 'BE'
group by e."idEntite", e.nom, lower(m.organe);







