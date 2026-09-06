
# Information on Individual's Educational Background and Career (*`education`*)

This page documents the available information on the educational background and educational career of individuals listed in the `education` table of the *Élites suisses* database.

<font color="red">I would suggest creating a new ***`t_education_cleaning_up`*** table based on this table.</font>

## Related Documents

* SQL script for data inspection and transformation: [education_exploration.sql](../database_inspection/education_exploration.sql)
* Documentation on additional tables derived from this table:
    * [***`t_study_title`***](education_study_title.md): provides a controlled vocabulary for study titles and educational degrees
    * [***`t_study_discipline`*****](education_study_discipline.md): provides a controlled vocabulary for study disciplines

## Description of the Data

The complete dataset consists of 23 columns with 34321 rows containing information on individual educational track records. We ignore columns containing purely administrative data. 

In this table, **rows** represent educational phases (i.e., different segments of a person's educational career, including studies abroad, educational degrees and achievements).

Relevant **columns** include the following information (if available):

* educational path or educational level (`Formation niveau`),
* degree obtained (`TITRE_Codé`),
* discipline of study (`Catégorie`),
* institution (`Institution`),
* location, i.e. the place (`Lieu`), canton (`Canton`) and country (`Pays`),
* time period (`Date`),
* title of thesis (`THÈSE_Titre`, e.g., doctoral and habilitation thesis),
* information on academic supervisorship (`THÈSE_NomDirecteur`), provided a supervisor is also registered as a person in the *Élites suisses* database.

A few examples:

<font color="red">Provide a few examples of the data here...</font>

A more detailed description of the content in these columns can be found in the Section [Processing and cleanup](#processing-and-cleanup) below.

&nbsp;

## Table ***`education`***

| Column Name | Data Type |  Description | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| `sysid` | integer |   |   |   |
| `zkp_edu` | character varying | primary key |   |   |
| `ID_IDENTITE` | integer | foreign key to the [***`identite`***](identite.md) table |   |   |
| [`Formation niveau`](#education-level--niveau-formation-niveau) | character varying | education level or niveau (some overlap with the column `séjour_étranger`, see [notes below](#education-level--niveau-formation-niveau)) | ? |   |
| [`Titre_stxt`](#study-title-and-discipline-titre_stxt-titre_codé-catégorie) | character varying | obtained educational title/degree (abbreviated/short form) | link to ***`t_study_title`*** |   |
| [`TITRE_Codé`](#study-title-and-discipline-titre_stxt-titre_codé-catégorie) | character varying | obtained educational title/degree | link to ***`t_study_title`*** |   |
| [`Catégorie`](#study-title-and-discipline-titre_stxt-titre_codé-catégorie) | character varying | discipline of study | link to ***`t_study_discipline`*** |   |
| `Ordre` | integer | propriétés de Allen? <font color="red">=> Probably a number for ordering the different educational segments on the website, e.g. https://elitessuisses.unil.ch/p/55864</text> | ? |   |
| `Institution` | character varying | study institution | link to [***`t_group`***](organisations_groups.md) |   |
| `Lieu` | character varying | study place (of institution) | link to [***`t_geo_place`***](t_geo_place.md) |   |
| `Canton` | character varying | study canton | link to [***`t_geo_place`***](t_geo_place.md) |   |
| `Pays` | character varying | study country | link to [***`t_geo_place`***](t_geo_place.md) |   |
| [`Date`](#time-period-date) | character varying | year (4-digit) or time period (start year ... end year), sometimes only indicative | ? |   |
| `THÈSE_Titre` | character varying | title of thesis (master, doctorate, habilitation) | ? |   |
| `THÈSE_NomDirecteur` | character varying | name of supervisor of a person's title | identite table? |   |
| `THÈSE_Directeur_IdIdentité` | integer | id of supervisor of a person's title | identite table? |   |
| `zlg_Creation` | timestamp without time zone |   |   |   |
| `zlg_CreationNom` | character varying |   |   |   |
| `zlg_Modif` | timestamp without time zone |   |   |   |
| `zlg_ModifNom` | character varying |   |   |   |
| `principal_annexe` | character varying |   |   |   |
| `séjour_étranger` | character varying | foreign study (some overlap with the column `Formation niveau`, see [notes below](#education-level--niveau-formation-niveau)) | ? |   |
| `versionDate` | date |   |   |   |

&nbsp;

## Processing and Cleanup

### Education level / niveau (`Formation niveau`)

Information provided on the level or niveau of a person's education is structured in a controlled vocabulary. However, the concept behind this category is a bit vague. Some fields need to be cleaned up.

| Content of `Formation niveau` | Number of Rows | Information | Cleanup Decision | How |
|-------------------------------|----------------:|-------------|--------------------|-----|
| '' (empty but not [null]) | 58 | no information | set to [null] | via script |
| [line break] | 1 | no information | set to [null] | *manually for OBEDU_34368* |
| "Base" | 3593 | basic education (up to secondary level 2) | "Basic and secondary education" | via script |
| "Supérieure" | 10221 | higher education (college / university level) | "Higher education" | via script |
| "supérieure" | 1 | " | " | *manually for OBEDU_22552* |
| "Doctorat" | 11682 | doctorate (PhD and above) | "Doctorate/PhD" | via script |
| "Complémentaire" | 4795 | various types of short-term and longer-term further education. The distinction to "Supérieure" / higher education is not always clear | "Further education" | via script |
| "Séjour étranger" | 3970 | various types of study visits / education related activities abroad (not further specified) | "Foreign study" | via script |
|  | **34321** |  |  |  |

&nbsp;

**Additional remarks on the content in `Formation niveau`:**

* **"Base" / Basic and secondary education:** Contains study titles such as diplomas and degrees up to today's secondary level 2 (upper-secondary level), including general education (e.g., gymnasium) and vocational education (e.g., apprenticeship) tracks. Some higher non-academic professional diplomas are also included here (e.g. ingenieur HTL).

* **"Supérieure" - "supérieure" / Higher education:** Contains study titles such as higher education diplomas, starting with the university bachelor degree. Teaching licences and national exams are also included here. <font color="red">*There is some overlap to Basic and secondary education that needs to be mitigated during cleanup.*</font>

* **"Doctorat" / Doctorate/PhD:** Contains study titles on the level PhD and above. Habilitations could be seen as a category of its own, but it is subsumed here. A special case is the French "Agrégation" or "Agrégation de l'enseignement supérieur", which is a national competitive examination in France used to recruit full university professors (professeurs des universités) in specific disciplines like law, political science, economics, and management.

* **"Complémentaire" / Further education:** Contains study titles of advanced complementary or further education. Among the most notable being the "brevet d'avocat" and the "brevet de notaire". There is a wide variety of titles in this category.

* **"Séjour etranger" / Foreign study:**

    * In addition to this category as part of the `Formation niveau`, there is a dedicated column called `séjour_étranger`, which has a similar meaning. It is a "binary" category, meaning that the content of this columnn consists either the string "Séjour étranger" (sometimes also in lowercase, which needs to be cleaned) or [null].
    * While there is a 100 % match between the information in `séjour_étranger` and the element "Séjour étranger" in the `Formation niveau` column, the former has some overlap to other elements in the `Formation niveau` column, making the concept of this dedicated column somewhat obscure:

        | `Formation niveau` | `séjour_étranger` | Number of Rows | Cleanup Decision | How |
        |--------------------|-------------------|----------------|------------------|-----|
        | "Séjour étranger" | "Séjour étranger" | 3970 | - | - |
        | "Base" | "Séjour étranger", "séjour étranger" | 37 | <font color="red">decision pending </font> |  |
        | "Supérieure" | "Séjour étranger", "séjour étranger" | 552 | <font color="red">decision pending </font> |  |
        | "Doctorat" | "Séjour étranger" | 113 | <font color="red">decision pending </font> |  |
        | "Complémentaire" | "Séjour étranger" | 485 | <font color="red">decision pending </font> |  |
        |  |  | **5157** |  |

        <font color="red">There are three possible ways to proceed:
        1. Ignore the info in `séjour_étranger` completely and only use the information provided in `Formation niveau`
        2. Overwrite (i.e., recode) `Formation niveau` to "Séjour étranger" for every `séjour_étranger` <> [null].
        3. Leave everything as is and let the user decide which column/information to use.</font>

    * In some cases, a "Séjour étranger", as denoted both in `Formation niveau` and `séjour_étranger`, can also take place within the same country. This can probably be understood as something like a study visit at another institution.

&nbsp;

### Study title and study discipline (`Titre_stxt`, `TITRE_Codé`, `Catégorie`)

The three columns `Titre_stxt`, `TITRE_Codé` and `Catégorie`, together with the `Date` column, are closely interrelated. They represent the educational stages a person has gone through. Sometimes, no information is available.

It is important to distinguish between two fundamental concepts:

1. **To study:** a continuous activity in a person's educational career that takes place for a limited period of time (i.e., over the course of a year or several years) and usually leads to the obtention of a formal educational degree or diploma,
2. **Obtaining a study title:** the event when a person has received a specific educational degree or academic title.

    These two concepts are interrelated but must be viewed as seperate events. However, the content in the columns `Titre_stxt`, `TITRE_Codé` and `Catégorie` – together with the `Date` column – allows only for an approximation of the educational path of a person. Dates might be missing, or an educational title might just denote a person's education track but not the exact diploma he:she received (e.g. apprenticeship).

The content in these columns needs some cleaning up in order to be transformed in a controlled vocabulary. For this, new tables are created with the cleaned up content as entities:

* t_study_title
* t_study_discipline 

&nbsp;

### Time period (`Date`)

The `Date` column contains either singular events (e.g., year of obtaining a study title) or time periods (e.g., study from year x to year y).

The information is not standardised, but mostly of good enough quality to be cleaned in a structured manner, as shown in the following table.

| Content of `Date` | Length |  Number of Rows | Information | Cleanup Decision |
|--------|--------:|--------:|----------|----------|
| [null] | [null] | 1078 | no information | leave as is |
| '' (empty but not [null]) | 0 | 14948 | no information | set to [null] |
| '?' | 1 | 26 | no information | set to [null] |
| '0' | 1 | 3 | no information | set to [null] |
| '1' | 1 | 1 | no information | set to [null] |
| 4-digit year | 4 | 16735 | year | map to **study year** if information on study discipline is provided and/or map to year of **obtaining a study title** if information on study title is provided |
| 4-digit year + '-' + 4-digit year | 5 | 83 | start year / end year (e.g. 1987- / -1987) | map to **study year** if information on study discipline is provided and/or map to year of **obtaining a study title** if information on study title is provided (**end year only**) |
| date range with two 4-digit years | 9 | 1327 | period from year AAAA ... to year BBBB (e.g. 1985-1987) | map to **study year** if information on study discipline is provided and/or map to year of **obtaining a study title** if information on study title is provided (**end year only**) |
| 4-digit year and question mark | varying | 38 | unclear but usable information (see note below table) (e.g. '1978?' could be treated as '1987' or '1987-?' as start year 1987) | to be cleaned manually; then map as above |
| all other content | varying | 82 | varying and sometimes unclear but usable information | to be cleaned manually; then map as above or set to [null] |
|   |   | **34321** |   |   |

&nbsp;

**Additional remarks on the content in `Date`:**

* It is not completely clear, what the concept of a year/period (`Date`) in the *`education`* table actually means: A study period, the year of graduation, the stay at an educational institution, or obtaining a study title?

* Seen pragmatically: If there is information on a particular year or period, we can assign it to both (**to study** and **obtaining a study title**), if the following assumptions are met: 1) Obtaining a study title usually follows a period of study; it cannot be obtained without having sort of 'studied' beforehand. And 2) if there is no information on the study title available in either `TITRE_Codé` OR `Titre_stxt`, we assume that the year/period only applies to the study, although we cannot say for sure. In any case, if assigning a study title, we would use only the end year, if the `Date` is a time period and not a single year.

* That said, if a study title (`TITRE_Codé` OR `Titre_stxt`) exists in the database, we also assign a study title. If not, only a study period is given.

    | `Date` Contains Only 4-digit year | `Date` Contains Start Year | `Date` Contains End Year | Study Period | Obtaining a Study Title |
    |------|------|-----|-----|-------|
    | yes | - | - | yes (start year = end year) | <ul><li>yes, if there is information in "TITRE_Codé" OR "Titre_stxt"</li><li>no, if both "TITRE_Codé" AND "Titre_stxt" are empty</li></ul> |
    | - | yes | - | (yes) <font color="red">=> how to model?</text> | (no) <font color="red">=> what if there is information in "TITRE_Codé" OR "Titre_stxt"?</text> |
    | - | - | yes | (yes) <font color="red">=> how to model?</text> | yes, if there is information in "TITRE_Codé" OR "Titre_stxt" |
    | - | yes| yes | yes | yes, if there is information in "TITRE_Codé" OR "Titre_stxt" |

* If a date range is provided, we assign the study title to the end year (e.g. 1987 in values such as '-1987' or '1985-1987'). There should not be any information on a study title corresponding to a start date (e.g. '1987-' should have no study titles) <font color="red">=> have to check this</font>

* In cases where the `Date` contains uncertain information but contains at least a fully usable year (e.g. '1987?' or '1987 ?'), we could use that year; otherwise we could drop the information and set the date to [null]. <font color="red">=> To discuss: maybe we could introduce a marker or flip variable for these cases, meaning that there would be some information in the database which cannot be transformed into an entity</font>




&nbsp;


Further notes:

Is `THÈSE_NomDirecteur` and `THÈSE_Directeur_IdIdentité` congruent with identite table?
