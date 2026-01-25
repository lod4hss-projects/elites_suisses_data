
SELECT *
FROM elites_suisses.identifier i 
where i."URL" ~ 'I82638';

SELECT *
FROM elites_suisses.identifier
WHERE "URL" LIKE '%http%http%';

-- deleted not possible to correct by hand
-- "zkf_ID_linked": 100552,50400,54883,60115,69384,98451
delete 
FROM elites_suisses.identifier
WHERE "URL" LIKE '%http%http%';



SELECT *
FROM elites_suisses.identifier i 
where i."URL" ~ 'Ruth_Lüthi';


SELECT *
FROM elites_suisses.identifier i 
where i."URL" ~ '\n';

update elites_suisses.identifier i set "URL" =  regexp_replace("URL", '\n', '')
where i."URL" ~ '\n';


select *
from elites_suisses.identifier
where "zkf_ID_linked" in (98451, 51952 ) ;

select *
from elites_suisses.identifier
where "zkf_ID_linked" in (98451, 51952 ) 
and"URL" ~ '\n';

delete from elites_suisses.identifier
where "zkf_ID_linked" in (98451, 51952 ) 
and "URL" ~ '\n';

