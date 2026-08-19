# Semantic Analysis and Mapping of Database Tables

We recreated an ERD representing the original classes/tables and the new ones. It is [available here](../documentation/graphics/ERD_with_new_tables.png) and documented [in this file](../documentation/graphics/ERD_with_new_tables.md).

&nbsp;

## Original Tables

Following tables were delivered by the project

&nbsp;

### Persons (table *identite*)

Rows in this table represent persons.

They correspond to instances of the CIDOC CRM E21 Person class.

Data inspection and structure of the table [to be found here](../documentation/information_analysis/identite.md).

&nbsp;

### Links (table *identifier*)

Rows in this table represent relations to other identifiers or to webpages about the same persons.

Data inspection and structure of the table [to be found here](../documentation/information_analysis/same_as_relations.md) and [here](../documentation/information_analysis/identifier.md).

&nbsp;

### Parents (table *filiations*)

Rows in this table represent relations to parents.

Data inspection and structure of the table [to be found here](../documentation/information_analysis/filiations.md).

&nbsp;

### Marriage (table *mariage*)

Rows in this table represent marriages.

Data inspection and structure of the table [to be found here](../documentation/information_analysis/marriage.md).

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

This table demands a thorough inspection and discussion. This is **[the access page](information_analysis/mandates_general_inspection.md) to the whole documentation of this process** where we provide links to the sub-pages.

Data inspection and structure of the table [to be found here](information_analysis/roles_mandates.md).

&nbsp;

## New tables

These tables allow to create new entities and associate the original text values to these entities.

For a description of the new tables, see the [comment to the ERD conceptual model](graphics/ERD_with_new_tables.md).

 &nbsp;

## New views

These views are used for data in spection and consistency check

[... to be completed]
