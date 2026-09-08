# Inspection of the ***`entites`*** table

This page documents the content of the original tables and the cleaning work that was done on them.

* Regarding *additional names* of entities see [this documentation](organisations_additional_names.md).
* Regarding the new *t_group table* [see this page](organisations_groups.md)

&nbsp;

## *entites* table

On [this page](../database_inspection/groups_entities_exploration.sql) are described the SQL scripts used for basic data cleaning and consistency check of the *entités* table.

&nbsp;

| Column Name | Data Type | Description | Mapping | Mapping Comments |
|---|---|---|---|---|
| `sysid` | integer | MySQL export related id |  |  |
| `id` | integer | internal id (FileMaker?) |  | We use this identifier in the foreign key management of all the existing data referencing to organisations as it is also used by the project for the entity identification in the ***`education`*** table (but not in the ***`mandat`*** table, where `idEntite` is used instead) |
| `idEntite` | character varying | Semi-semantic identifier to mandates but not education. It is also used for referencing entities on the Élites suisses website (e.g. https://elitessuisses.unil.ch/e/entite27) |  |  |
| `sphere` | character varying | This column references the field in which an entity is rooted, e.g. politics, economoy, research etc. (see [distribution of spheres and entity types](#distribution-of-spheres-and-entity-types) below). It is also present in the ***`mandat`*** table. |  | <font color="red"> Is the information in "idEntite" in both the entites and the mandat tables the same? </font> |
| `typeEntite` | character varying | Type of entity. It has a variable meaning depending on the `sphere` (e.g. in the academic sphere, it is mostly about types of organisations, where in the philantropic sphere it narrows down the field of activity of philantropic organisations, see [distribution of spheres and entity types](#distribution-of-spheres-and-entity-types) below). |  |  |
| `nom` | character varying | Name of entity (organisations and institutions) |  | In addition to this column, the column `Institution` in the ***`education`*** table as well as to the columns `entite`, `organe` and `partiAffiliationOfficeSecteur` in the ***`mandat`*** table contain names of entities, which are organisations and institutions. |
| `siege` | character varying | Seat of entity (organisations and institutions) |  | See [documentation on geographical places](t_geo_place.md)<br><font color="red">"Siège" probably means the (current) seat of an organisation, which may or may not be the same as the place the organisation was founded (see `creationLieu` and `creationCanton`)</font> |
| `siegeCanton` | character varying | Canton of entity (organisations and institutions) |  | See [documentation on geographical places](t_geo_place.md)<br><font color="red">See also comment above</font> |
| `pays` | character varying | Country of entity (organisations and institutions) |  | See [documentation on geographical places](t_geo_place.md) |
| `dateCreation` | character varying | Foundation year or date of an entity (organisation and institution) |  |  |
| `dateDisparition` | character varying | Dissolution year or date of an entity (organisation and institution) |  |  |
| `choixLogo` | character varying | Identifier probably to select different logo versions stored in the backend |  |  |
| `DHS` | character varying | URL to the DHS/HLS <br><font color="red">Is there an indirect link to the identifier table, i.e. an overlap of URLs to DHS/HLS in this table and in the identifier table? Or apply the linked resources in the identifier only to persons?</font> |  |  |
| `DHS_versionAuteur` | character varying | <font color="red">Is empty => check!</font> |  |  |
| `affiliationSecteurType` | character varying | Depending on sphere and typeEntite denoting the economic sector or entity type |  | <font color="red">Needs to be analysed in cooccurrence with sphere, typeEntite and nom</font> |
| `echelle` | character varying | The scope, level or reach of an entity's field of activity, i.e. national ("Fed"/"FED"), cantonal ("Cant"), municipal ("Comm") or international ("Int"/"Inter")) |  |  |
| `creationLieu` | character varying | Foundation place of entity |  | See [documentation on geographical places](t_geo_place.md) |
| `creationCanton` | character varying | Foundation canton of entity |  | See [documentation on geographical places](t_geo_place.md) |
| `nbrMandats` | integer | Aggregated number of associated mandats (whole of database) |  |  |
| `nbrMandatsZH` | integer | Aggregated number of associated mandats in the canton? of Zurich |  |  |
| `nbrMandatsGE` | integer | Aggregated number of associated mandats in the canton? of Geneva |  |  |
| `nbrMandatsBS` | integer | Aggregated number of associated mandats in the canton? of Basel-City |  |  |
| `versionDate` | date | Internal version date in the format DD.MM.YYYY |  |  |

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
