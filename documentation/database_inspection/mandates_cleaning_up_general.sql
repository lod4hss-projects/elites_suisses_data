



/*
 * Type entité
 * 
 * In fact the type depends on the organisation itself
 * 
 */

select lower(trim("typeEntite")) as type_ent, count(*) as num
from elites_suisses.v_sphere_economique
--where "typeEntite" = 'Prix/Distinction'
-- where "typeEntite" = 'Enseignement'
group by lower(trim("typeEntite"))
having count(*) > 1
order by type_ent;


select lower(trim("typeEntite")) as type_ent, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.sphere = 'Administrative' -- Académique
group by lower(trim("typeEntite"))
having count(*) > 1
order by type_ent;




select e."typeEntite", count(*) as num
from elites_suisses.entites e 
--where e.sphere = 'Académique'
where e.sphere = 'Administrative'
group by e."typeEntite" ;

select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where tmcu.sphere = 'Economique'
and tmcu."typeEntite" ~* 'associa'
limit 100;



select lower(trim("typeEntite")) as type_ent, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.sphere = 'Economique'
group by lower(trim("typeEntite"))
having count(*) > 0
order by num desc;
order by type_ent;


select lower(trim("typeEntite")) as type_ent, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true
-- all entities are considered
--and tmcu.sphere = 'Economique'
and tmcu."typeEntite" ~* 'asso'
group by lower(trim("typeEntite"))
having count(*) > 0
order by type_ent;


--update elites_suisses.t_mandates_cleaning_up set type_ent_cleaned = 'association'
where "typeEntite" ~* 'asso';



select tmcu.type_ent_cleaned, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true
-- all entities are considered
--and tmcu.sphere = 'Economique'
--and tmcu."typeEntite" ~* 'asso'
group by tmcu.type_ent_cleaned
having count(*) > 0
order by tmcu.type_ent_cleaned ;


/*
 * Fonctions
 */

select tmcu.fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* '^comit.{1,2}$'
--where tmcu.organe ~* 'comit.*dir.{1,3}$'
where true 
and tmcu.sphere = 'Académique'
--and tmcu.fonction_clean_1 is null or length(tmcu.fonction_clean_1 ) = 0
--and tmcu.fonction ~* 'membre'
--and tmcu.fonction ~* '^membre.{0,3}$'
group by fonction 
order by num desc;

-- updated 65880
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'membre'
where tmcu.fonction_clean_1 is null or length(tmcu.fonction_clean_1 ) = 0
--and tmcu.fonction ~* 'membre'
and tmcu.fonction ~* '^membre.{0,3}$';

select tmcu.fonction_clean_1, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
group by tmcu.fonction_clean_1 
order by num desc;

select count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu;

select count(*) as num
from elites_suisses.mandat m ;

