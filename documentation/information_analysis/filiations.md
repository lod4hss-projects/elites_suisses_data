# Information about the `filiation` table

## Data Exploration

Here is the list of columns and their data type, as well as comments

| Column Name | Data Type |   Comments |
|-------------|-----------|------|
| sysid | integer | Internal system id, not to reuse |
| idFiliation | integer | ID of the Filiation, only reused in the creation of the view |
| idFils | integer | ID of the child |
| idParent | integer | ID of the parent |
| sexeParent | character | Not needed, this si deduced from the person |
| creation | character varying | Internal tracking of edition of data. Not to transform |
| saisie | character varying | Internal tracking of edition of data. Not to transform |
| auteurModif | character varying | Internal tracking of edition of data. Not to transform |
| zkp_filiation | character varying | Another ID of the Filiation, not to reuse |
| versionDate | date | Internal tracking of edition of data. Not to transform |

The table Filiation is rather straightforward, as it contains mostly foreign key to other persons.

## Data Transformation

Some data cleaning is needed to correct some of the inconsistencies (for instance where the id of the child is the same as the parent)

As the documentation of parents in the SDHSS ontology ecosystem is done through the birth event, a new table called `v_person_birth` is created, which contains:
- an identifier which is the concatenation of the two filiations (mother and father)
- a new identifier for the birth
- the birth year, based on the new column `birth_year` of the `identite` table (see [here](../information_analysis/person_birth-death.md))
- the foreign key of the child
- the foreign keys of the mother and father

The SQL queries are documented [here](../database_inspection/filiations.sql)

See page [t_person_birth](../information_analysis/v_person_birth.md) for documentation about transformation and mapping.