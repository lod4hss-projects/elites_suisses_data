select * 
from elites_suisses.identifier i
limit 10;


select i."Identifier_code", count(*) as num
from elites_suisses.identifier i
group by "Identifier_code" 
order by "Identifier_code" ;



/*
 * Wikidata
 */

select * 
from elites_suisses.identifier i
where i."Identifier_code" ~* 'wikida'
limit 10;


select i."zkf_ID_linked", concat('http://www.wikidata.org/entity/', i."Identifier") 
from elites_suisses.identifier i
where i."Identifier_code" ~* 'wikida'
limit 10;


-- if needed add additional situations
-- drop view elites_suisses.same_as ;
create or replace view elites_suisses.same_as as (
select i."zkf_ID_linked", concat('http://www.wikidata.org/entity/', i."Identifier") same_as
from elites_suisses.identifier i
where i."Identifier_code" ~* 'wikida'
)


select *
from elites_suisses.same_as
where "zkf_ID_linked" = 71142
limit 10;


select *
from elites_suisses.identite i 
where i.id = 71142;


/*
 * Further identifiers
 */





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

