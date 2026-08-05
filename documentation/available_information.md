
# Semantic Analysis and Mapping of Database Tables 



&nbsp;



## Original Tables

These tables were delivered by the project


&nbsp;

### Persons (table *identite*)


Rows in this table represent persons.

They correspond to instances of the CIDOC CRM E21 Person class.

Data inspection and structure of the table [to be found here](information_analysis/persons.md).

&nbsp;


### Links (table *identifier*)

Rows in this table represent relations to other identifiers or to webpages about the same persons.

Data inspection and structure of the table [to be found here](information_analysis/same_as_relations.md).

&nbsp;



### Parents (table *filiations*)

Rows in this table represent relations to parents.

Data inspection and structure of the table [to be found here](information_analysis/filiations.md).

&nbsp;


### Marriage (table *mariage*)

Rows in this table represent marriages.



Data inspection and structure of the table [to be found here](information_analysis/marriage.md).

&nbsp;


### Education (table *education*)

Rows in this table represent educational phases, studies and degrees.

Data inspection and structure of the table [to be found here](information_analysis/education.md).

&nbsp;




### Organisations (tables *entites*, *autresNomsEntites*)

Rows in the *entites* table represent organisations of different kinds.

They correspond to instances of the CIDOC CRM E74 Group class.


Furthermore, an additional table *autresNomsEntites* provides additional labels for the same organisations.


Data inspection and structure of the table [to be found here](information_analysis/organisations.md).

&nbsp;


### Roles, Memberships, Prizes (table *mandat*)

Rows in this table represent a bundle of different informations, mainly instances of the [C13 Social Role Embodiment](https://ontome.net/class/697) class, but also information about Memberships, Prizes, etc. is present in the data

Data inspection and structure of the table [to be found here](information_analysis/roles_mandates.md).

&nbsp;


## New tables

These tables allow to create new aentities and associate the original text values to these entities


### crm_group

This table replaces the original *entities* table for the management of organisations, etc.

Relevant sql scripts files are:

* [Create new tables for groups (crm_group, group_type, etc.)](database_inspection/groups_new_tables.sql)
* [Feed the new tables](database_inspection/groups_entities_enrichment.sql)


### group_type

This table provides a refined controlled vocabulary for group types


### gender

This table provides a controlled vocabulary for genders


### social_relationship_type

This table provides a controlled vocabulary for social relationships' types


### social_role

This table provides a controlled vocabulary for any kind of social roles, in all domains



### t_study_title

This table provides a controlled vocabulary for study titles, it is used in the domain of education


### t_study_discipline

This table provides a controlled vocabulary for study and teaching disciplines, it is used in the domain of education and teaching



### t_entity_sub_entity_education

This table is used to clean up organisations related to mandates in the domain of education.

Further information on this process [to be found here](documentation/information_analysis/t_entity_sub_entity_education.md).


&nbsp;


## New views

These tables are use for data in spection and consistency check