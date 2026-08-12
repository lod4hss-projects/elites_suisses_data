/*
 * Data Exploration
 */

-- Query in the identite table to count the frequency of each value
select UPPER(i.sexe) gender, count(*) as frequency
from elites_suisses.identite i 
group by UPPER(i.sexe)
order by frequency;


/*
 * Data Transformation
 */

--drop table  elites_suisses.social_role ;
CREATE TABLE elites_suisses.gender (
    pk_gender INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(255),
    description TEXT,
    code varchar,
    notes text,
    wikidata_uri varchar(255),
    import_notes text
);

select *
from elites_suisses.gender;


-- Add foreign key to gender table

alter table elites_suisses.identite add column fk_gender integer;

-- FOREIGN KEY 
alter table elites_suisses.identite add constraint fk_gender_fk foreign key (fk_gender) 
	references elites_suisses.gender(pk_gender);



select
	case 
		when UPPER(sexe)='F'
		then 1
	when UPPER(sexe)='H'
		then 2
	end as gender
from elites_suisses.identite i
limit 100;


update elites_suisses.identite set fk_gender = case 
		when UPPER(sexe)='F'
		then 1
	when UPPER(sexe)='H'
		then 2
end;


-- count fk gender
select fk_gender, count(*) as n
from  elites_suisses.identite i 
group by fk_gender;
