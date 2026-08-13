# Information about the sources mentioned in the identite table

## Data Exploration

Here are the number of empty cells, number of celles containing a value and the number of distinct values in both the column `sourcesBio` and `sourcesFormation`.

|column_name|nbr_empty_values|nbr_values|nbr_distinct_values|
|-----------|----------------|----------|-------------------|
|sources_bio|24313|34416|14723|
|sources_formation|51088|7641|3446|

Here are the 20 most frequent values in `sourcesBio`

|sourcesBio|number_occurences|
|----------|-----------------|
|DHS|2150|
|www.gen-gen.ch|2006|
|Mitgliederdatenbank Kantonsrat (1803-)|1534|
|admin.ch|1318|
|http://www.stroux.org/patriz_f/vnQV_r.pdf|1087|
|https://www.kantonsrat.zh.ch/mitglieder/mitglieder-ab-1803.aspx|931|
|Steinhauser (2019)|702|
|Staatskalender, Adressbuch, Kantonsblatt (Staatsarchiv Basel)|471|
|Martindale-Hubbell Law Directory|462|
|Grand Conseil Genève, Historique des députés: http://ge.ch/grandconseil/gc/histo-deputes/|388|
|Base Profs Unil|379|
| |300|
|gr.be.ch|285|
|www.montmollin.ch|269|
|SWA Basel|269|
|Base Profs UNIGE|266|
|Nationalité selon moneyhouse.ch|226|
|Robert et Panese 2000|198|
|Nationalité selon www.moneyhouse.ch|155|
|https://www.sngenealogie.ch/wp/sources/biographies-neuchateloises/|148|

And here are the 20 most frequent values in `sourcesFormation`

|sourcesFormations|number_occurences|
|-----------------|-----------------|
|DHS|1716|
|Base Profs Unil|737|
|Base Profs UniGe|214|
|Mono Bern|142|
|dhs|105|
|DHS Annuaire AF 1957|64|
|Annuaire des Professeurs de l'EPFL 1997 |55|
|Gruner 1966|49|
|Annuaire AF 1980|48|
|Wikipedia|47|
|DHS Gruner 1966|37|
|Annuaire des Professeurs de l'EPFL 1997|35|
|Base Profs UniFr|33|
|Base Profs Unil DHS|32|
|Annuaire AF 1980 DHS|31|
|DHS Annuaire AF 1980|29|
|Worldcat|29|
|Gruner 1966 DHS|28|
|http://www.bger.ch|28|
|Annuaire AF 1957 DHS|27|

Attention, there are line breaks in the values of the sources.

The SQL queries can be found [here](../database_inspection/sh_person_sources.sql)

## Data tranformation

A new `sdh_sources` table should be created, based on both the `sourcesBio` and `sourcesFormations`. Each entry in those two tables seemed to be devided by a page break (to be confirmed), so this could serve as the basis to distinguish individual entries.

However, further cleaning should be done do identitdy not only the string for the source, but the work or expression and the specific passage in those work/expression (such as the page of a book).