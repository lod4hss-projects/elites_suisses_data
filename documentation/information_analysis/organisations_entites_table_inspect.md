# Original Elites suisses database tables

This page documents the content of the original tables and the cleaning work that was done on them.

* Regarding *additional names* of entities see [this documentation](organisations_additional_names.md).
* Regarding the new *t_group table* [see this page](organisations_groups.md)

&nbsp;

## *entites* table

On [this page](../database_inspection/groups_entities_exploration.sql) are described the SQL scripts used for basic data cleaning and consistency check of the *entités* table.

&nbsp;

| Column Name            | Data Type         | Comments                                                | Mapping | Mapping Comments                                                                                                                                                                                            |
| ---------------------- | ----------------- | ------------------------------------------------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| sysid                  | integer           | MySQL export related id                                 |         |                                                                                                                                                                                                             |
| id                     | integer           | internal id (FileMaker) ?                               |         | We've used this identifier in the foreign key management of all the existing data as it is also used by the project for the entity identification in the*education* table (but not in the mandates table) |
| idEntite               | character varying | Semi-semantic identifier  to mandates but not education |         |                                                                                                                                                                                                             |
| sphere                 | character varying |                                                         |         |                                                                                                                                                                                                             |
| typeEntite             | character varying |                                                         |         |                                                                                                                                                                                                             |
| nom                    | character varying |                                                         |         |                                                                                                                                                                                                             |
| siege                  | character varying |                                                         |         |                                                                                                                                                                                                             |
| siegeCanton            | character varying |                                                         |         |                                                                                                                                                                                                             |
| pays                   | character varying |                                                         |         |                                                                                                                                                                                                             |
| dateCreation           | character varying |                                                         |         |                                                                                                                                                                                                             |
| dateDisparition        | character varying |                                                         |         |                                                                                                                                                                                                             |
| choixLogo              | character varying |                                                         |         |                                                                                                                                                                                                             |
| DHS                    | character varying |                                                         |         |                                                                                                                                                                                                             |
| DHS_versionAuteur      | character varying |                                                         |         |                                                                                                                                                                                                             |
| affiliationSecteurType | character varying |                                                         |         |                                                                                                                                                                                                             |
| echelle                | character varying |                                                         |         |                                                                                                                                                                                                             |
| creationLieu           | character varying |                                                         |         |                                                                                                                                                                                                             |
| creationCanton         | character varying |                                                         |         |                                                                                                                                                                                                             |
| nbrMandats             | integer           |                                                         |         |                                                                                                                                                                                                             |
| nbrMandatsZH           | integer           |                                                         |         |                                                                                                                                                                                                             |
| nbrMandatsGE           | integer           |                                                         |         |                                                                                                                                                                                                             |
| nbrMandatsBS           | integer           |                                                         |         |                                                                                                                                                                                                             |
| versionDate            | date              |                                                         |         |                                                                                                                                                                                                             |

&nbsp;

### Distribution of spheres and entity types

Regarding entity types cf. [this page](../database_inspection/groups_entities_types.sql) (SQL code).

&nbsp;

```sql
select e.sphere, e."typeEntite", count(*) as n
from elites_suisses.entites e 
group by e.sphere, e."typeEntite" 
order by e.sphere, e."typeEntite" ;
```

| sphere                 | typeEntite                                     | n   |
| ---------------------- | ---------------------------------------------- | --- |
|                        |                                                | 1   |
|                        | Prix/Distinction                               | 8   |
| Académique            | Administration                                 | 1   |
| Académique            | Association                                    | 8   |
| Académique            | Enseignement                                   | 842 |
| Académique            | Prix/Distinction                               | 3   |
| Académique            | Recherche                                      | 5   |
| Administrative         |                                                | 1   |
| Administrative         | Autorités judiciaires                         | 1   |
| Administrative         | BNS                                            | 1   |
| Administrative         | Comm. extra-parl                               | 653 |
| Administrative         | Département fédéral                         | 8   |
| Administrative         | Office fédéral                               | 112 |
| Economique             | Association                                    | 81  |
| Economique             | Entreprise                                     | 503 |
| Militaire              | Militaire                                      | 1   |
| Philanthropie          | Annexes                                        | 47  |
| Philanthropie          | III. Instruction                               | 52  |
| Philanthropie          | II. Vieillesse, maladie, accidents, hygiène   | 102 |
| Philanthropie          | I. Philanthropie et bienfaisance               | 41  |
| Philanthropie          | IV. Education et moralisation                  | 142 |
| Philanthropie          | VI. Economie domestique                        | 24  |
| Philanthropie          | VII. Prévoyance, Assurance et Secours mutuels | 146 |
| Philanthropie          | V. Travail                                     | 32  |
| Politique              | Assemblée Féd.                               | 2   |
| Politique              | Autorités cant.                               | 26  |
| Politique              | Autorités comm.                               | 431 |
| Politique              | Commission parlementaire                       | 24  |
| Politique              | Conseil Féd.                                  | 1   |
| Politique              | Constituante                                   | 13  |
| Politique              | Parti politique                                | 99  |
| Politique-Sociabilité | Autorités comm.                               | 1   |
| Sociabilité           |                                                | 1   |
| Sociabilité           | Lieux de sociabilité                          | 141 |

&nbsp;
