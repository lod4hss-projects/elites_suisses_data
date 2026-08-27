
## Table 'education' exploration

* [Base exploration](../database_inspection/education_exploration.sql)



### Dates as assigned to singular events or periods (field: `Date`)

| Content of `Date` field | Length |  Number of cases | Comments | Decision |
|--------|--------|--------|----------|----------|
| [null] | [null] | 1078 | [null] —> * no information * | leave as is |
| '' | 0 | 14948 | emtpy field —> * no information * | set to [null] |
| '?' | 1 | 26 | * no information * | set to [null] |
| '0' | 1 | 3 | * no information * | set to [null] |
| '1' | 1 | 1 | * no information * | set to [null] |
| 4-digit year | 4 | 16735 | year | map to **study year** if information on study discipline is provided and/or map to year of **obtaining a study title** if information on study title is provided |
| 4-digit year + '-' + 4-digit year | 5 | 83 | start year / end year (e.g. 1987- / -1987) | map to **study year** if information on study discipline is provided and/or map to year of **obtaining a study title** if information on study title is provided (**end year only**) |
| date range with two 4-digit years | 9 | 1327 | period from year AAAA ... to year BBBB (e.g. 1985-1987) | map to **study year** if information on study discipline is provided and/or map to year of **obtaining a study title** if information on study title is provided (**end year only**) |
| 4-digit year and question mark | varying | 38 | unclear but usable information (see note below table) (e.g. '1978?' could be treated as '1987' or '1987-?' as start year 1987) | to be cleaned manually; then map as above |
| all other content | varying | 82 | varying and sometimes unclear but usable information | to be cleaned manually; then map as above or set to [null] |
|   |   | **34321** |   |   |

If a study title (`TITRE_Codé`) is assigned, we assign also a study title, If not, only a study period.

What is the concept of a year/period (`Date`) in the database: study period, year of graduation/obtaining a study title? If there is information on the year assigned, we assign it to both, meaning that assuming that a study title cannot be obtained without having sort of 'studied' at this same year, we would assign the title at the same year as the study year.
* If a date range is provided, we assign the study title to the end year (e.g. 1987 in values such as '-1987' or '1985-1987'). There should not be any information on a study title corresponding to a start date (e.g. '1987-' should have no study titles)
* fields containing uncertain information but has a fully usable year assigned (e.g. '1987?' or '1987 ?'), we use that year; otherwise we drop the information and set the date to [null]. => maybe we could introduce a marker for these cases, meaning that there would be some information in the database which cannot be transformed into an entity)



## Table 'education' columns and mapping

| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| zkp_edu | character varying | primary key |   |   |
| ID_IDENTITE | integer |   |   |   |
| Formation niveau | character varying |   |   |   |
| Titre_stxt | character varying |   |   |   |
| TITRE_Codé | character varying |   |   |   |
| Catégorie | character varying |   |   |   |
| Ordre | integer |   | propriétés de Allen? |   |
| Institution | character varying |   |   |   |
| Lieu | character varying |   |   |   |
| Canton | character varying |   |   |   |
| Pays | character varying |   |   |   |
| Date | character varying |   |   |   |
| THÈSE_Titre | character varying |   |   |   |
| THÈSE_NomDirecteur | character varying |   |   |   |
| THÈSE_Directeur_IdIdentité | integer |   |   |   |
| zlg_Creation | timestamp without time zone |   |   |   |
| zlg_CreationNom | character varying |   |   |   |
| zlg_Modif | timestamp without time zone |   |   |   |
| zlg_ModifNom | character varying |   |   |   |
| principal_annexe | character varying |   |   |   |
| séjour_étranger | character varying |   |   |   |
| versionDate | date |   |   |   |

&nbsp;
