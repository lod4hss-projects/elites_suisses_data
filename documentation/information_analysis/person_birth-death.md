# Information about the birth and death of individuals

## Information analysis

The birth and death of a person is documented in different fields in the `identite` table:
- `naissance`: the birth date, in string
- `mort`: la date de mort
- `lieuNaissance`: the birth place (town), in string
- `cantonNaissance`: the Swiss Canton of the birth place, in string

Each field has its own rules, structures and types of inconsistencies, and are analysed below.

### Birth and Death Dates

Dates are documented and strings and do not follow a specific standard. Here are some examples:

| id | date |
|----|----|
| 79087 | 06.12.1945 |
| 93932 | 1971 |
| 64114 | 1867? |
| 50200 | 1905 ou 1930 ? |
| 99167 | ?? |
| 111395 | 02/02/1964 |
| 106099 | vers 1960 |
| 98452 | ca. 1870 |

Here is the count of occurences of each birth and death in the table `identite`.

|column name|number of occurences|
|-----------|-----------------|
|birth|45512|
|death|22725|

see here the [SQL scripts](documentation/database_inspection/sh_identite_inspection.sql).

#### Data cleaning

The first step is to clean those date fields. It was decided to only extract the birth year, even if this will reduce a bit the precision of the dates.

The SQL script is documented [here](documentation/database_inspection/persons_data_wrangling.sql)

### Birth Place

The birth place is documented in two different fields: `lieuNaissance` et `cantonNaissance`. Both are related, `lieuNaissance` being within `cantonNaissance`.

Here are the number of time an individual in the `identite` table have a birth and/or canton documented:

|column name|number of occurences|
|-----------|-----------------|
|birth_place|14714|
|birth_canton|14320|

However, there are 317 accounts where the `cantonNaissance` is documented but not the `lieuNaissance`. Inversly, there are 711 cases where a `lieuNaissance` is documented without a `cantonNaissance`.

see here the [SQL scripts](documentation/database_inspection/sh_identite_inspection.sql).

Number unique, with trim and underscore

|lieuNaissance|effectif|
|------|--------|
|genève|930|
|zurich|849|
|bâle|790|
|lausanne|732|
|berne|492|
|neuchâtel|204|
|zürich|185|
|lugano|182|
|lucerne|181|
|la chaux-de-fonds|151|


## Birth Canton

|cantonNaissance|effectif|
|------|--------|
||44409|
|ETRANGER|2861|
|ZH|1743|
|VD|1522|
|BE|1429|
|GE|1177|
|BS|812|
|TI|647|
|NE|538|
|SG|534|
|AG|455|
|LU|314|
|FR|279|
|SO|276|
|TG|266|
|GR|261|
|VS|256|
|SH|170|
|BL|113|
|GL|105|
|AR|101|
|ZG|99|
|SZ|99|
|AI|57|
|UR|55|
|NW|50|
|OW|34|
|JU|34|
|BE (AUJOURD'HUI JU)|11|
|ÉTRANGER|7|
|BE (AUJOURD'HUI BL)|4|
|LUCERNE|2|
|BERNE|2|
|SO?|1|
|URI|1|
|JU (BE HISTORIQUE)|1|
|SUISSE|1|
|TG OU SG|1|
|BS?|1|
|SZ?|1|

### Treatment

When "Etranger", do not document.

## Mapping

`lieuNaissance` et `cantonNaissance`

Both field only contains strings. String values of the field `lieuNaissance` should be instanciated into instances of the classe [`sdh:C13 Geographical Place`](https://ontome.net/class/363).

This instance would then be related to another instance of `sdh:C13 Geographical Place` of the canton, if needed.