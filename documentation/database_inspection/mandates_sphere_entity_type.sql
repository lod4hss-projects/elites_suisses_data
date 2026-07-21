

/*
* Explore domains and entity types
*/

select m.sphere, count(*) as num
from elites_suisses.mandat m 
group by m.sphere;


/*
 * Cleaning up sphere  (21 July 2026) 
 * 
 * The change is directly in the original column 
 * but every change is documented in a script
 * 
 * Modified:
 *  
 * Academique -> Académique
 * Admin -> Administrative
 * Eco -> Economique
 * economique -> Economique
 * Poliltique -> Politique
 * politique -> Politique
 * Sociab -> Sociabilité
 * 
 */

select m.sphere, count(*) as num
from elites_suisses.mandat m 
group by m.sphere
order by m.sphere ;

select *
from elites_suisses.mandat m 
where m.sphere  = 'Academique';

update elites_suisses.mandat m set sphere = 'Sociabilité'
where m.sphere  = 'Sociab';


/*
 * Types entités
 */

select m.sphere, m."typeEntite", count(*) as num
from elites_suisses.mandat m 
group by m.sphere, m."typeEntite"
order by m.sphere, m."typeEntite"


select *
from elites_suisses.mandat m 
where m."typeEntite" = 'honoris causa';

select *
from elites_suisses.mandat m 
where m."typeEntite" = 'Prix/Distinction';


/*
 * Create views per sphere / domain
 */

-- academic domain
create view elites_suisses.v_sphere_academique AS
select *
from elites_suisses.mandat m 
where m."sphere" = 'Académique';


select m."typeEntite", count(*) as num
from elites_suisses.v_sphere_academique m 
group by  m."typeEntite"
order by m."typeEntite";


select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_academique m 
group by  m."entite",  m."idEntite"
order by m."entite"


select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_academique m 
group by  m."entite",  m."idEntite"
order by num desc




-- administrative domain
create view elites_suisses.v_sphere_administrative AS
select *
from elites_suisses.mandat m 
where m."sphere" = 'Administrative';

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_administrative m 
group by  m."entite",  m."idEntite"
order by num desc;


select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_administrative m 
group by  m."entite",  m."idEntite"
order by m."entite";





-- economy domain
create view elites_suisses.v_sphere_economique AS
select *
from elites_suisses.mandat m 
where m."sphere" = 'Economique';

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_economique m 
group by  m."entite",  m."idEntite"
order by num desc;

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_economique m 
group by  m."entite",  m."idEntite"
order by m."entite";




-- military domain
create view elites_suisses.v_sphere_militaire AS
select *
from elites_suisses.mandat m 
where m."sphere" = 'Militaire';

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_militaire m 
group by  m."entite",  m."idEntite"
order by num desc;

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_militaire m 
group by  m."entite",  m."idEntite"
order by m."entite";




-- politics domain
create view elites_suisses.v_sphere_politique AS
select *
from elites_suisses.mandat m 
where m."sphere" = 'Politique';

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_politique m 
group by  m."entite",  m."idEntite"
order by num desc;

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_politique m 
group by  m."entite",  m."idEntite"
order by m."entite";


-- Journalisme domain
create view elites_suisses.v_sphere_presse AS
select *
from elites_suisses.mandat m 
where m."sphere" = 'Presse';

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_presse m 
group by  m."entite",  m."idEntite"
order by num desc;

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_presse m 
group by  m."entite",  m."idEntite"
order by m."entite";


-- social interaction domain
create view elites_suisses.v_sphere_sociabilite AS
select *
from elites_suisses.mandat m 
where m."sphere" = 'Sociabilité';

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_sociabilite m 
group by  m."entite",  m."idEntite"
order by num desc;

select m."entite", m."idEntite", count(*) as num
from elites_suisses.v_sphere_sociabilite m 
group by  m."entite",  m."idEntite"
order by m."entite";




-- sports domain (just one, no view)

select m."entite", m."idEntite", count(*) as num
from elites_suisses.mandat m 
where m."sphere" = 'Sportive'
group by  m."entite",  m."idEntite"
order by num desc;

