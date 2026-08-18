

select *
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Politique'
order by fonction;



select fonction, count(*) as num
from elites_suisses.t_mandates_cleaning_up tmcu 
where true 
and tmcu.sphere = 'Politique'
group by fonction
having count(*) > 0
order by fonction;





