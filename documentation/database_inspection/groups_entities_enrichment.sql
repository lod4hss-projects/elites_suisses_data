
/*
 * We use the view aggregating 
 */

-- canton parliaments
select *
from elites_suisses.v_groups_from_mandates
where organe ~* 'légis' 
and type_entite ~* 'can'
order by nom;

-- canton governments
select *
from elites_suisses.v_groups_from_mandates
where 
organe ~* 'cutif' and 
type_entite ~* 'can';


