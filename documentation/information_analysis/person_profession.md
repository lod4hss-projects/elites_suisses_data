# Information about the profession of persons

## Data Exploration

The column `profession` in the `identite` table contains string values of the main profession(s) of persons. It is a non-structured field to briefly describe an individual, most probably to give context and disambiguate for the exploration of data.

This column contains:
- 35231 persons with an occupation 
- 23498 with an empty value in profession
- 16236 distincts professions

The high number of distinct professions shows that this fiels is not structured.

Here is the list of the 10 most mentioned professions:

|profession|effectif|
|----------|--------|
|prof. dr.|1765|
|avocat|1089|
|prof.|889|
|prof. unil|701|
|conseiller d'etat|617|
|prof. unizh|387|
|médecin|386|
|prof. unige|385|
|agriculteur|360|
|prof. uniba|347|

The SQL queries can be found [here](../database_inspection/person_profession.sql)

Some values contain multiple professions, separated by a ',' or a 'et'.

Moreover, those professions can be deduced from the table `mandats`, even though some information in the `profession` column is unique.

## Decision

As this field is mostly non-structured data, it seems best not to tranform it for the moment