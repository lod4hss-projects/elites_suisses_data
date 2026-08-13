## Table 'crm_group' definition

The crm_group table contains all the identifying information of existing and newly created groups in the database.

It is a newly created table with each entry represents a distinct group that appears across various tables in the database (e.g. political organisation unit, higher education institution, organisational unit of such an institution, ...). The different types of groups are documented in the table [group_type](documentation/information_analysis/group_type.md).

### Initial definition of the table

The initial set of entries has been derived from the basic entities in the Swiss political system, such as the cantons as political units, comprising each of the cantons' executive and legislative authorities, as well as the constituent executive and legislative bodies of the Swiss Confederation. Additionally, higher education institutions from the [education](documentation/information_analysis/education.md) table were joined as a first set for defining the tables' structure and for reconciliation with the wikidata base.

For 20 cases, the original name of the entity was standardised in order to reduce duplicates in the database. See also the [inspection script](../documentation/database_inspection/sk_crm_group_definition.sql) for a more detailed view of the parameters.


| name (not standardised) | name_original (standardised) |
|----------------|--------------------|
| UniZH | UniZh |
| Unibe | UniBe |
| UNIBE | UniBe |
| UNIFR | UniFr |
| Unige | UniGe |
| UniGE | UniGe |
| UNIGE | UniGe |
| Unil | UniL |
| UNIL | UniL |
| UniNE | UniNe |
| UNINE | UniNe |
| UniSvit | UniSvIt |
| Columbia university | Columbia University |
| Université catholique de Louvain | Université Catholique de Louvain |
| Ecole polytechnique | Ecole Polytechnique |
| Ecole centrale des arts et manufactures de Paris | Ecole centrale des Arts et Manufactures de Paris |
| École libre des sciences politiques | École Libre des Sciences Politiques |
| Académie des beaux-arts de Munich | Académie des Beaux-Arts de Munich |
| Académie des Beaux-arts de Munich | Académie des Beaux-Arts de Munich |
| Académie des beaux-arts de Düsseldorf | Académie des Beaux-Arts de Düsseldorf |
| (all other values) | Keep original value` |

### First inspection of the data

A first view of this data, containing 566 instances of the [group types 1–6](documentation/information_analysis/group_type.md), showed that various groups of the type 6 (higher education institution) are interrelated:

* Historically: some institutions are older variants of a newer variant, of which both exist as individual entities in the database
* Organisationally: some institutions represent sub-groups or organisational sub-units of a larger (i.e., parent) group or organisation.

### Reconciliation with wikidata

Higher education institutions, and later: enterprises, associations and so on, are matched, where available, to the wikidata base.

OpenRefine was used in this process to reconcile the names to match with a wikidata-QID (see [additional documentation on this process](documentation/information_analysis/crm_group_first-batch-analysis-and-reconciliation.md)).

### Final working structure of the 'crm_group'

After this inspection, the table has been restructured, preserving the changes made in the previous steps, to accomodate for the need to document inter-entity-relations of the historical and organisational type (see above).

The final working structure of the 'crm_group' table is the following:

| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| pk_crm_group |   |   |   |   |
| name_standard |   |   |   |   |
| name_st_language |   |   |   |   |
| name_french |   |   |   |   |
| name_original |   |   |   |   |
| definition |   |   |   |   |
| fk_group_type |   |   |   |   |
| notes |   |   |   |   |
| wikidata_uri |   |   |   |   |
| fk_source_entity |   |   |   |   |
| fk_part_of |   | Contains the pk of the entity in this table that this entity is a part of  |   |   |
| fk_origin_of |   | Contains the fk of the entity of which this entity originates/was formed from  |   |   |
| import_notes |   |   |   |   |
| date_begin |   |   |   |   |
| date_end |   |   |   |   |

### Duplicates

There seem do be duplicates in the 'entites' table, which have not assigned any mandates. Maybe they are used elsewhere?

* Entities with id 2096, 2097, 2098, 2099 seem to be duplicates of id 2094. Only id 2094 has mandates assigned to it (i.e., exists as a foreign key in the mandates table). The others have neither mandats nor education assigned, see:
    * SELECT *
FROM elites_suisses.mandat
WHERE id_entity IN (2094,2096,2097,2098,2099) ;
    * SELECT *
FROM elites_suisses.education
WHERE id_entity IN (2094,2096,2097,2098,2099) ;

See script [sk_entites_duplicates](../database_inspection/sk_entites_duplicates.sql).