
CREATE TABLE elites_suisses.t_geo_place_kind (
	pk_geo_place_kind int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	name_standard text NULL,
	na_st_language varchar(3) NULL,
	definition text NULL,
	fk_place_kind int4 NULL,
	notes text NULL,
    wikidata_uri varchar(255) NULL,
    CONSTRAINT t_geo_place_kind_pkey PRIMARY KEY (pk_geo_place_kind)
    );

/*
 * Geographical Place from Nico's database
 * 
 * Import done in DBeaver directly from sqlite to postgresql table
 */

CREATE TABLE elites_suisses.t_geo_place (
	pk_geo_place int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	provi_id integer,
    name_standard text NULL,
	na_st_language varchar(3) NULL,
	definition text NULL,
	fk_geo_place_kind int4 NULL,
	notes text NULL,
    long float NULL,
    lat float NULL,
	wikidata_uri varchar(255) NULL,
    geocoordinates text NULL,
    import_notes text NULL,
	CONSTRAINT pk_geo_place_pkey PRIMARY KEY (pk_geo_place),
	CONSTRAINT fk_geo_place_kind_fk FOREIGN KEY (fk_geo_place_kind) REFERENCES elites_suisses.t_geo_place_kind(pk_geo_place_kind)
);


--update elites_suisses.t_geo_place tgp set geocoordinates = concat('POINT(',long,' ',lat,')')
where long is not null ;

-- added kind for settlements
--update elites_suisses.t_geo_place tgp set fk_geo_place_kind = 1;

select 'Territoire du canton ' || trim(tgp.import_notes) as canton, count(*) num 
from elites_suisses.t_geo_place tgp 
where tgp.import_notes !~* 'trang'
and tgp.import_notes !~ 'auj'
group by tgp.import_notes
having count(*) > 1
order by import_notes ;

update elites_suisses.t_geo_place tgp set import_notes = 'LU'
where tgp.import_notes = 'Lucerne';

select 'Territoire du canton ' || trim(tgp.import_notes) as canton, 'fr' lang, 2 kind, trim(tgp.import_notes) as canton
from elites_suisses.t_geo_place tgp 
where tgp.import_notes !~* 'trang'
and tgp.import_notes !~ 'auj'
group by tgp.import_notes
having count(*) > 1
order by import_notes ;

--insert into elites_suisses.t_geo_place (name_standard, na_st_language, fk_geo_place_kind, import_notes )
select 'Territoire du canton ' || trim(tgp.import_notes) as canton, 'fr' lang, 2 kind, trim(tgp.import_notes) as canton
from elites_suisses.t_geo_place tgp 
where tgp.import_notes !~* 'trang'
and tgp.import_notes !~ 'auj'
group by tgp.import_notes
having count(*) > 1
order by import_notes ;

--alter table elites_suisses.t_geo_place drop column provi_id;


--drop table elites_suisses.t_geo_relation;
CREATE TABLE elites_suisses.t_geo_relation (
	pk_geo_relation int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	relation_type text NULL,
	date_begin text null,
	date_end text null,
	description text NULL,
	notes text NULL,
	fk_geo_place_source int4 NULL,
	fk_geo_place_target int4 NULL,
	import_notes text NULL,
	CONSTRAINT geo_relation_pkey PRIMARY KEY (pk_geo_relation),
	CONSTRAINT fk_geo_place_source_fk FOREIGN KEY (fk_geo_place_source) REFERENCES elites_suisses.t_geo_place(pk_geo_place),
	CONSTRAINT fk_geo_place_target_fk FOREIGN KEY (fk_geo_place_target) REFERENCES elites_suisses.t_geo_place(pk_geo_place)
);


/*
 * This table treats birth places, death places, time spend abroad, etc.
 * 
 * Import done in DBeaver directly from sqlite to postgresql table
 * 
 */

--drop table elites_suisses.t_person_place;
CREATE TABLE elites_suisses.t_person_place (
	pk_person_place int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	relation_type text NULL,
	date_begin text null,
	date_end text null,
	description text NULL,
	notes text NULL,
	fk_person int4 NULL,
	fk_geo_place int4 NULL,
	import_notes text NULL,
	CONSTRAINT person_place_pkey PRIMARY KEY (pk_person_place),
	CONSTRAINT fk_person_fk FOREIGN KEY (fk_person) REFERENCES elites_suisses.identite(id),
	CONSTRAINT fk_geo_place_fk FOREIGN KEY (fk_geo_place) REFERENCES elites_suisses.t_geo_place(pk_geo_place)
);

-- update elites_suisses.t_person_place set relation_type = 'birth_place';

-- verify if correct : generally yes
select i.id, i.name_forename, i."cantonNaissance", i."lieuNaissance", tgp.name_standard, tgp.geocoordinates  
from elites_suisses.t_person_place tpp
 join elites_suisses.identite i on i.id = tpp.fk_person
 join elites_suisses.t_geo_place tgp on tgp.pk_geo_place = tpp.fk_geo_place ;

-- group and count
select tgp.name_standard, tgp.geocoordinates, count(*) as number
from elites_suisses.t_person_place tpp
 join elites_suisses.identite i on i.id = tpp.fk_person
 join elites_suisses.t_geo_place tgp on tgp.pk_geo_place = tpp.fk_geo_place 
group by  tgp.name_standard, tgp.geocoordinates;


/*
 * Issues with wikidata URIs
 */

select tgp.wikidata_uri, tgp.pk_geo_place, replace(tgp.wikidata_uri, 'https://www.wikidata.org/wiki/', 'http://www.wikidata.org/entity/')
from elites_suisses.t_geo_place tgp 
where tgp.wikidata_uri is not null;
and length(tgp.wikidata_uri)=0;

--update elites_suisses.t_geo_place tgp set wikidata_uri = NULL
where tgp.wikidata_uri is not null
and length(tgp.wikidata_uri)=0;

--update elites_suisses.t_geo_place tgp set wikidata_uri = replace(tgp.wikidata_uri, 'https://www.wikidata.org/wiki/', 'http://www.wikidata.org/entity/')
where tgp.wikidata_uri is not null;