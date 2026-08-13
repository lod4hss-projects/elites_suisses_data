


select e."typeEntite", e.sphere , count(*) as num
FROM elites_suisses.entites e 
group by e."typeEntite", e.sphere 
order by e.sphere ;


select *
FROM elites_suisses.entites e 
where e."typeEntite" = 'Prix/Distinction';




/*
 * inspect entities types
 * inspect sphere
 * 
 * this inspection will happen in relation to the use of these entities
 * in the education and mandates tables
 * 
 */


-- inspect entities types
select e."typeEntite", count(*) as n
from elites_suisses.entites e 
group by  e."typeEntite" 
order by "typeEntite" ;
order by n desc;

-- only three missing types
select *
from elites_suisses.entites e 
where e."typeEntite" is null or e."typeEntite"=''
;

-- inspect sphere
-- some misstakes -> they were corrected : see below
select sphere, count(*) as n
from elites_suisses.entites e 
group by e.sphere
order by e.sphere;
order by n desc;



-- misstakes corrected
update elites_suisses.entites e set sphere = 'Economique'
where e.sphere = 'Economie';

update elites_suisses.entites e set sphere = 'Economique'
where e.sphere = 'Eonomique';


-- specific case, possibly une bourgeoisie
select * 
from elites_suisses.entites e 
where e.sphere ~ 'que-So';

-- personnes associées: membres, sphère politique
select *
from elites_suisses.mandat m 
where m."idEntite" = 'entite370';

-- 'entite370' was modified to 'sociabilité' sphere, as it has no political function in the contemporary society
update elites_suisses.entites e set sphere = 'Sociabilité'
where e.sphere ~ 'que-So';





select * 
from elites_suisses.entites e 
where e.nom ~* 'bourgeo';







-- sphere and type of organisation
-- important for inspection
select e.sphere, e."typeEntite", count(*) as n, string_agg(distinct nom, '; ')
from elites_suisses.entites e 
group by e.sphere, e."typeEntite" 
order by e.sphere, e."typeEntite" ;
order by e.sphere, n desc;





/*
 * Compare entity types in table entities and mandates
 * 
 * A lot of inconsistencies in the mandates table
 */

-- inspect entities types
select e."typeEntite" type_e_entite, m."typeEntite" type_e_mandat, count(*) as n
from elites_suisses.entites e 
    join elites_suisses.mandat m on m."idEntite" = e."idEntite" 
group by  e."typeEntite", m."typeEntite"
order by  e."typeEntite", m."typeEntite";
--order by n desc;
order by n desc;


