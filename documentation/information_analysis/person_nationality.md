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

## Data Transformation

### Data Cleaning and reconcliation in OpenRefine

The cleaning of the nationality required:
- The cleaning of the string value, to avoid duplicates
- The creation of instances for each nationality, so that they can be documented further and receive a unique identifier
- Reconcile the places with equivalent instances in Wikidata

This how the data has been processed: 

1. First the data was cleaned/regularized with openrefine in the identite table, duplicating the fields (to keep the original value) then cleaning and removing duplicates (such as "Zurich" and "Zürich"), and turned into the file "birth-places-citizenship-military-grades-new-cleaned.csv".
2. Then CSV is then transformed into multiple table, in a new person.db SQL database, using the main.py script. 
3. The rank, birth place, and citizenship tables are then extracted using the export sql-script to a series of csvs with the same names.
4. The table csvs are then imported into OpenRefine to do the final wikidata reconciliation, and later re inserted into the database using the import sql-script.