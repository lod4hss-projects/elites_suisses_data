# Comments on ERD

This ERD reproduces the tables and main columns in the original database and adds with specific colors the new columns, classes and relations that we add for the sake of identifying implicit entities

In the database, the new tables that represent the classes in the ERD are prefixed with 't_', e.g. *t_group*, to distinguish them from the originalt tables

&nbsp;

## Color codes

* black: as in the original database
* green: new added classes / columns / relations
* red: foreign keys
* blue: views

## Tables

### Group (t_group)

This table replaces the original *entities* table for the management of organisations, etc. It allows to manage not yet explicitely identified entities in the original database.

See [this file](../information_analysis/organisations_groups.md) for more details about the creation of the Group class.

Relevant sql scripts files are:

* [Create new tables for groups (crm_group, group_type, etc.)](database_inspection/groups_new_tables.sql)
* [Feed the new tables](database_inspection/groups_entities_enrichment.sql)

### Group Type (t_group)

This table provides a refined controlled vocabulary for group types
Each group has unique basic type.

### t_gender

This table provides a controlled vocabulary for genders

### t_social_relationship_type

This table provides a controlled vocabulary for social relationships' types

### Social Role (t_social_role)

This table provides a controlled vocabulary for any kind of social roles, in all domains.

It provides an optional relation to the group in which the social role was created: *defined in relation to*

SQL code that created this table is [in this document](../database_inspection/social_roles.sql).


### t_study_title

This table provides a controlled vocabulary for study titles, it is used in the domain of education.

The SQL code to produce this table [in is this file](../database_inspection/education_exploration.sql).

### t_study_discipline

This table provides a controlled vocabulary for study and teaching disciplines, it is used in the domain of education and teaching

The SQL code to produce this table [in is this file](../database_inspection/education_exploration.sql).


### t_entity_sub_entity_education

This table is used to clean up organisations related to mandates in the domain of education.

Further information on this process [to be found here](../information_analysis/t_entity_sub_entity_education.md).

The SQL code to produce this table [in is this file](../database_inspection/mandates_v_sphere_academique.sql).



### t_mandates_cleaning_up

This table is used to clean up the *mandat* table. It is separated from the original table (although it hase the same rows) in order to facilitate the cleaning up. It has a 1 to 1 relation to the original table.

Further information about the production of this table [to be found here](../database_inspection/mandates_cleaning_up_tables.sql).
