
# Information about persons


Persons are listed in the *identite* table.

Available information about them:


| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| id | integer |   |   |   |
| nom | character varying |   |   |   |
| prenom | character varying |   |   |   |
| naissance | character varying | [Birth Dates](../information_analysis/persons.md#birth-dates)  |   |   |
| mort | character varying |   |   |   |
| nbrMandats | character varying |   |   |   |
| cantonNaissance | character varying |   |   |   |
| confidentiel | character varying |   |   |   |
| confidentiel_naissance | character varying |   |   |   |
| DHS | character varying |   |   |   |
| choixPhoto | character varying |   |   |   |
| formationDoctorat | character varying |   |   |   |
| formationUniversitaire | character varying |   |   |   |
| gradeMilitaireMax | character varying |   |   |   |
| lieuNaissance | character varying |   |   |   |
| nationalite | character varying |   |   |   |
| profession | character varying |   |   |   |
| saisie | character varying |   |   |   |
| sexe | character | [Gender](../information_analysis/persons.md#gender)  |   |   |
| sourcesBio | text |   |   |   |
| sourcesFormations | text |   |   |   |
| creation | character varying |   |   |   |
| versionDate | date |   |   |   |

&nbsp;


### identifier
| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| zkf_ID_linked | integer |   |   |   |
| Identifier_code | character varying |   |   |   |
| Identifier | character varying |   |   |   |
| 



## Some examples

* [Cavadini-Bauer, Jean](https://elitessuisses.unil.ch/p/50039)


## Birth Dates

Inconsistent data:

* sometimes year: 1939
* sometimes day: 21.08.1842
* sometimes '?' : ? our 1969?
* sometimes'vers': vers 1870


## Death Dates

Similar to birth dates




## Gender

|gender|effectif|
|------|--------|
|H|47318|
|F|11216|
||195|



## Birth Place

3377 occurrences

### Most frequent

|canton|effectif|
|------|--------|
||44015|
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
|sorengo|141|
|winterthour|136|
|fribourg|124|
|saint-gall|112|
|bienne|107|
|paris|101|
|schaffhouse|97|




## Birth Canton

|canton|effectif|
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


## PhD

|canton|effectif|
|------|--------|
||44609|
|oui|10140|
|non|3978|
|indé|2|


## University Degree


|canton|effectif|
|------|--------|
||38613|
|oui|14708|
|non|5304|
|na|100|
|yes|2|
|x|2|


## Military Highest Position

82 distinct occurrences

### Most frequent

|grade|effectif|
|-----|--------|
||49834|
|non|5503|
|colonel|856|
|capitaine|675|
|premier-lieutenant|480|
|major|442|
|lieutenant-colonel|411|
|brigadier|100|
|non?|71|



## Occupation

Professions


* 35231 persons with an occupation 
* 23498 without

&nbsp;

* 16236 occurrences

### Most frequent

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
|landwirt|337|
|prof. epfz|317|
|banquier|311|
|prof. unibe|309|
|kaufmann|307|
|architecte|305|
|commerçant|260|
|prof. epfl|247|
|pasteur|239|
|ingénieur|216|
|prof. unifr|186|
|prof. dr. (ethz)|158|
|juge fédéral|138|
|chef d'entreprise|127|
|rechtsanwalt|122|
|industriel|122|
|direktor|120|
|négociant|117|
|prof. unine|116|
|notaire|114|
|gemeindepräsident|99|



Sometimes two (or more) occupations separated by a ','


### Treatment

* Should we distinguish between different categories: academic titles, political roles, occupations?

* Should we create and align a vocabulary of occupations?