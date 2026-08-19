# Information about the nationality of individuals

## Data Exploration

The column `nationalite` in the `identite` table documents, with string values, the nationality of individuals.

There are
- 33650 empty cells
- 646 distinct values

Here is the first 20 values:

|nationalite|number_occurences|
|-----------|-----------------|
|Suisse|20421|
|Allemande|1213|
|Française|486|
|Américaine|244|
|Italienne|214|
|Autrichienne|148|
|Anglaise|135|
|Allemande?|113|
|Belge|97|
|suisse|88|
|Suisse?|85|
|Allemande, puis Suisse|75|
|Hollandaise|71|
|?|58|
|Française?|51|
|Suédoise|48|
|Espagnole|46|
|Canadienne|44|
|Allemande, puis suisse|29|
|Chinoise|25|

A lot of cleaning is necessary, as:
- There are cases of multiple nationalities, sometimes not only with ',' or 'et' but alors ', puis'.
- There are a lot of uncertainties with the caracter '?'
- There are some times the feminin and masculin form of the nationality

The SQL queries can be found [here](../database_inspection/person_nationality.sql)

## Data Transformation

There is a lot od data cleaning that needs to be done, by creating a `t_nationality` table (it could be based on the `citizenship` table in the `person.db`).

Then an intermediate table should be created between the `identite` table and the `t_nationality` tables, as some individuals have multiple nationalities.