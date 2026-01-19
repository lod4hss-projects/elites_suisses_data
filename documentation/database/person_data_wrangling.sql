

-- add column concatenanting name and forename
alter table elites_suisses.identite add column name_forename text;

select concat(nom, ', ', i.prenom  )
from elites_suisses.identite i 
limit 10;

update elites_suisses.identite i set name_forename = concat(nom, ', ', i.prenom  );



-- extract birth year

alter table elites_suisses.identite add column birth_year integer;

select
case when (regexp_match(naissance, '\d{4}')) is not null
then (regexp_match(naissance, '\d{4}'))[1]::integer
else 0
end as birth_year
from elites_suisses.identite i
limit 100;



update elites_suisses.identite set birth_year = case when (regexp_match(naissance, '\d{4}')) is not null
then (regexp_match(naissance, '\d{4}'))[1]::integer
else 0
end;


select birth_year, count(*) number
from elites_suisses.identite i 
group by birth_year
--order by birth_year 
order by count(*) desc
limit 100;

select count(*) number
from elites_suisses.identite i 
where birth_year != 0;




