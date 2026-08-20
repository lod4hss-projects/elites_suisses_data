
/*
 * Clean up years
 */



select m."anneeEntreeUtilisee", count(*) as num
from elites_suisses.mandat m 
--where m."anneeEntreeUtilisee" !~ '\d{4}'
group by "anneeEntreeUtilisee" 
order by "anneeEntreeUtilisee" ;

select m."anneeEntreeUtilisee", replace(m."anneeEntreeUtilisee", '-', '')
from elites_suisses.mandat m 
where true
--and m."anneeEntreeUtilisee" = ''
and m."anneeEntreeUtilisee" ~ '-'
order by "anneeEntreeUtilisee" ;

-- get rid of empty and inconsistent values
--update elites_suisses.mandat m set "anneeEntreeUtilisee" = null
where m."anneeEntreeUtilisee" !~ '\d{4}';

-- get rid of -
--update elites_suisses.mandat m set "anneeEntreeUtilisee" = replace(m."anneeEntreeUtilisee", '-', '')
where m."anneeEntreeUtilisee" ~ '-';



select m."anneeSortieUtilisee", count(*) as num
from elites_suisses.mandat m 
where m."anneeSortieUtilisee" !~ '\d{1}'
group by "anneeSortieUtilisee" 
order by "anneeSortieUtilisee" ;

-- get rid of empty and inconsistent values; integers to be corrected are not corrected
--update elites_suisses.mandat m set "anneeSortieUtilisee" = null
where m."anneeSortieUtilisee" !~ '\d{1}';


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
 * Fonctions en général
 */


-- number of mandates
select count(*) as num
from elites_suisses.mandat m ;


-- number of cleaning mandates
select count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu;


select tmcu.fonction_clean_1, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
group by tmcu.fonction_clean_1 
order by num desc;

-- inspect not yet coded
select tmcu.fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* '^comit.{1,2}$'
--where tmcu.organe ~* 'comit.*dir.{1,3}$'
where true 
--and tmcu.sphere = 'Economique'
and tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* 'Dir/CEO'
--and tmcu.fonction ~* '^membre.{0,3}$'
group by fonction 
order by num desc;


/*
 * Membre
 */

-- only 'member', not member and another function
-- updated 65880
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'membre'
where tmcu.fonction_clean_1 is null or length(tmcu.fonction_clean_1 ) = 0
--and tmcu.fonction ~* 'membre'
and tmcu.fonction ~* '^membre.{0,3}$';





/*
 * Président
 */

select tmcu.fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* '^comit.{1,2}$'
--where tmcu.organe ~* 'comit.*dir.{1,3}$'
where true 
--and tmcu.sphere = 'Académique'
and tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
--and tmcu.fonction ~* 'pr.side'
and tmcu.fonction ~* '^pr.side.{0,5}$'
group by fonction 
order by num desc;

-- updated 6755
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'président'
where tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* '^pr.side.{0,5}$';


/*
 * Vice-Président
 */

select tmcu.fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* '^comit.{1,2}$'
--where tmcu.organe ~* 'comit.*dir.{1,3}$'
where true 
--and tmcu.sphere = 'Académique'
and tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
--and tmcu.fonction ~* 'vice-pr.side'
and tmcu.fonction ~* '^vice-pr.side.{0,5}$'
group by fonction 
order by num desc;

-- updated 2730
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'vice-président'
where tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* '^vice-pr.side.{0,5}$';




/*
 * Doyen, vice-doyen
 */

select tmcu.fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* '^comit.{1,2}$'
--where tmcu.organe ~* 'comit.*dir.{1,3}$'
where true 
--and tmcu.sphere = 'Académique'
and tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
--and tmcu.fonction ~* 'doyen'
and tmcu.fonction ~* '^vic.{1,2}doyen.{0,3}$'
--and tmcu.fonction !~* 'c3'
group by fonction 
order by num desc;

--doyen: updated 2187
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'doyen'
where tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* '^vic.{1,2}doyen.{0,3}$';

--vice doyen: updated 79
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'vice-doyen'
where tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* '^vic.{1,2}doyen.{0,3}$';


/*
 * Professeur, prof. ordinaire, prof. extraordinaire
 */

select tmcu.fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
--where tmcu.organe ~* '^comit.{1,2}$'
--where tmcu.organe ~* 'comit.*dir.{1,3}$'
where true 
--and tmcu.sphere = 'Académique'
and tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
--and tmcu.fonction ~* 'professeur'
and tmcu.fonction ~* '^profess.{2,7}assist.{2,6}$'
--and tmcu.fonction !~* 'c3'
group by fonction 
order by num desc;

-- professeur: updated 699
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'professeur'
where tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* '^profess.{2,6}$'
and tmcu.fonction !~* 'c3';

-- ordinaire: updated 6673
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'professeur ordinaire'
where tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* '^profess.{2,7}ordinai.{0,7}$';

-- extraordinaire: updated 3126
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'professeur extraordinaire'
where tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* '^profess.{2,7}extraor.{0,7}$';

-- extraordinaire: updated 858
--update elites_suisses.t_mandates_cleaning_up tmcu  set fonction_clean_1 = 'professeur assistant'
where tmcu.fonction_clean_1 is null or tmcu.fonction_clean_1 = ''
and tmcu.fonction ~* '^profess.{2,7}assist.{2,6}$';


/*
 * Inspect
 */

-- number of mandates
select count(*) as num
from elites_suisses.mandat m ;


-- number of cleaning mandates
select count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu;


select tmcu.fonction_clean_1, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
group by tmcu.fonction_clean_1 
order by num desc;











