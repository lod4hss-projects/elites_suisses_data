
/*
 * Social roles 
*/

--drop table  elites_suisses.t_social_role ;
CREATE TABLE elites_suisses.t_social_role (
	pk_social_role int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	name varchar(255) NULL,
	description text NULL,
	notes text NULL,
	wikidata_uri varchar(255) NULL,
	fk_group int4 NULL,
	import_notes text NULL,
	CONSTRAINT social_role_pkey PRIMARY KEY (pk_social_role),
	CONSTRAINT fk_crm_group_fk FOREIGN KEY (fk_group) REFERENCES elites_suisses.t_group(pk_group)
);



GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE elites_suisses.social_role TO "hgb_editor";
ALTER TABLE elites_suisses.social_role OWNER TO "hgb_editor";



ALTER TABLE elites_suisses.mandat ADD COLUMN fk_social_role_fonction INTEGER;

-- FOREIGN KEY 
alter table elites_suisses.mandat add constraint fk_social_role_fonction_fk foreign key (fk_social_role_fonction) 
	references elites_suisses.social_role(pk_social_role);



select *
from elites_suisses.t_social_role sr ;