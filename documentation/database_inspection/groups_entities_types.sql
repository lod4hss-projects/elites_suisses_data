


select e."typeEntite", e.sphere , count(*) as num
FROM elites_suisses.entites e 
group by e."typeEntite", e.sphere 
order by e.sphere ;


select *
FROM elites_suisses.entites e 
where e."typeEntite" = 'Prix/Distinction';

