
## Mandates and general issues

The rows in this table represent bundles of information, primarily instances of the [C13 Social Role Embodiment](https://ontome.net/class/697) class, but the data also contains information about **memberships**, **prizes**,**teaching activity**, and so on. As is common with older, research-driven databases, additional information has been added to the same '*mandates*' table, involving some implicit conceptual remodelling.

This was in particular achieved by adding a column representing the concept of 'activity spheres'. This shows the distribution of mandates per sphere.

|sphere|num|
|------|---|
|Académique|29094|
||1153|
|Militaire|459|
|Sportive|1|
|Economique|23884|
|Presse|15|
|Politique|32126|
|Administrative|15661|
|Sociabilité|10078|


We decided to split the analysis and refactoring of the database in line with the 'spheres' and created correspondingly a view per sphere.

Cf. [this document](../database_inspection/mandates_sphere_entity_type.sql) with the SQL code.



&nbsp;

### Different kinds of mandates / memberships

* [Federal and cantonal Swiss authorities](mandates_federal_cantonal_Swiss_authorities.md)







&nbsp;




## Original table: *mandat* - structure


| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| id | integer |   |   |   |
| idMandat | character varying |   |   |   |
| idIdentite | integer |   |   |   |
| fonction | character varying |   |   |   |
| entite | character varying |   |   |   |
| typeEntite | character varying |   |   |   |
| organe | character varying |   |   |   |
| partiAffiliationOfficeSecteur | character varying |   |   |   |
| sphere | character varying |   |   |   |
| annexePrincipale | character varying |   |   |   |
| dateEntree | character varying |   |   |   |
| dateSortie | character varying |   |   |   |
| dureeAffichee | character varying |   |   |   |
| anneeEntreeUtilisee | character varying |   |   |   |
| anneeSortieUtilisee | character varying |   |   |   |
| idEntite | character varying |   |   |   |
| sinergiaEchantillon | character varying |   |   |   |
| sinergiaCanton | character varying |   |   |   |
| creation | character varying |   |   |   |
| saisie | character varying |   |   |   |
| auteurModif | character varying |   |   |   |
| sourcesMandat | text |   |   |   |
| versionDate | date |   |   |   |
| entite_id | integer |   |   |   |


### Types of mandates across spheres

The data in the 'mandat' table can be divided by different 'spheres' of a person's activiy, that is in politics, economoy, research etc. The original data base structures the available information on these activities (= mandates) across various fields:

* **typeEntite**: the field of activity considered as a 'mandate' (for example: a mandat in teaching, research, administration, or in a company or association)
* **entite**: the name of the group (institution, organisation, association, enterprise, etc.), in which a 'mandate' was carried out.
* **organe**: the organisational (sub-)unit of an 'entite' in the sense above (for example: a department or faculty of a higher education institution, a board of an association, etc.)
* **fonction**: the function or role a person has within the 'entite' or the 'organe' of an 'entite' (for example: director, member, assistant, judge, ...)
* **partiAffiliationOfficeSecteur**: a field used for further specifying an 'entite' or 'organe' (for example: the subject or discipline a 'mandate' was located within a university)

Across the various 'spheres', these five typical fields were used to tackle down a person's activity. Depending on the 'typeEntite', however, the notions of the other fields seem to be varying. Therefore, also the type of content in these fields varies from 'typeEntite' to 'typeEntite'. In addition, the 'typeEntite' field does not contain a controlled vocabulary (not to mention the other fields).

The following lists try to structure the available information for 'typeEntite' across the spheres. The lists contain the original field content, the number of mandates, a suggested normalised vocabulary, and a standard english language vocabulary. See also [inspection script](../database_inspection/sk_mandates_scheme-for-typeEntite.sql).

*These lists can be taken as an outset for cleaning the 'typeEntite' and later data cleaning and verified across the various spheres. The above script contains some queries to look into the data in the mandates table. It is useful sometimes to include the 'organe', 'fontion' and 'partiAffiliationOfficeSecteur' in querying the data to verify the concepts below again before finally modifying the data.*

***The lists were made after a first review of the data for each combination, so they should already give a good indication on the various types of mandates in the table.***

#### Sphere: Académique

| typeEntite | num | typeEntite_normalised | typeEntite_standard | comment |
|-------------|----:|-----------------------|---------------------|---------|
|  | 67 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Administratif | 3 | Administration | Administration |  |
| Administration | 3996 | Administration | Administration |  |
| Administration? | 1 | Administration | Administration | Directeur de la section de virologie de l'institut de médecine microbiologique de l'université de Zurich (1959–1963), https://hls-dhs-dss.ch/fr/articles/044438/2004-06-08/ |
| Administrative | 2 | Administration | Administration |  |
| Association | 1203 | Association | Association |  |
| enseignement | 1 | Enseignement | Teaching |  |
| Enseignement | 18745 | Enseignement | Teaching |  |
| Enseignement/Recherche | 1 | Enseignement | Teaching | Function 'Assistant d'enseignement et de recherche' is attributed for two other persons under *Enseignement*. |
| honoris causa | 1 | Prix/Distinction | Award/Distinction | This mandate has similar information than others from the type "Prix/Distinction" |
| Honoris Causa | 1 | Prix/Distinction | Award/Distinction | This mandate has similar information than others from the type "Prix/Distinction" |
| Juridique | 1 | Juridique | Justice |  |
| prix/distinction | 1 | Prix/Distinction | Award/Distinction |  |
| Prix/Distinction | 1836 | Prix/Distinction | Award/Distinction |  |
| Recherche | 3234 | Recherche | Research |  |
| Titre | 1 | Prix/Distinction | Award/Distinction | This mandate has similar information than others from the type "Prix/Distinction" |

Resulting vocabulary (i.e., typeEntite_standard):

* Administration
* Association
* Award/Distinction
* Justice
* Research
* Teaching
* *to be cleaned manually*


#### Sphere: Académique

| typeEntite | num | typeEntite_normalised | typeEntite_standard | comment |
|-------------|----:|-----------------------|---------------------|---------|
|  | 52 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Administration | 127 | Administration | Administration |  |
| Administration allemande | 1 | Administration | Administration | country of activity: Germany |
| Administration américaine | 2 | Administration | Administration | country of activity: United States |
| Administration autrichienne | 1 | Administration | Administration | country of activity: Austria |
| Administration belge et luxembourge | 1 | Administration | Administration | country of activity: Belgium and Luxembourg |
| Administration états-unienne | 1 | Administration | Administration | country of activity: United States |
| Administration française | 5 | Administration | Administration | country of activity: France |
| Assemblée Féd | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Association | 1 | Association | Association |  |
| Autorité judiciaire | 1 | Juridique | Justice |  |
| Autorités cant. | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Autorités judiciaire | 2 | Juridique | Justice |  |
| autorités judiciaires | 1 | Juridique | Justice |  |
| Autorités judiciaires | 255 | Juridique | Justice |  |
| Banque centrale | 6 | Banque centrale | Central Bank | These are all foreign central banks. |
| Banque centrale américaine | 1 | Banque centrale | Central Bank | Foreign central bank. |
| Banque centrale française | 1 | Banque centrale | Central Bank | Foreign central bank. |
| Banque du Canada | 1 | Banque centrale | Central Bank | Foreign central bank. |
| Banque fédérale d'Allemagne | 1 | Banque centrale | Central Bank | Foreign central bank. |
| Banque nationale allemande | 1 | Banque centrale | Central Bank | Foreign central bank. |
| Bezirksgericht | 2 | Juridique | Justice |  |
| BNS | 63 | Banque | Central Bank |  |
| Comm. extra-parl | 13925 | Comm. extra-parl | Extra-Parliamentary Commission |  |
| Comm. Extra-parl | 300 | Comm. extra-parl | Extra-Parliamentary Commission |  |
| Comm. Extra-parl (carrière) | 2 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| commission extra-pal | 1 | Comm. extra-parl | Extra-Parliamentary Commission |  |
| Conseil d'administration | 1 | Administration | Administration | Conseil d'administration est le rôle attribué. |
| Département cantonal | 10 | Département cantonal | Cantonal Department |  |
| Département fédéral | 163 | Département fédéral | Federal Department |  |
| Eglise | 3 | Eglise | Church |  |
| Eidgenössische Zollverwaltung | 2 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Enseignement | 90 | Enseignement | Teaching |  |
| Hôpital | 1 | Hôpital | Hospital |  |
| Juridique | 1 | Juridique | Justice |  |
| Ministère | 1 | *à decider/éditer manuel* | *to be cleaned manually* | Presumably an American ministry. |
| Ministère allemand | 3 | Ministère | Ministry |  |
| Ministère français | 2 | Ministère | Ministry |  |
| Office | 3 | Office fédéral | Federal Office | "Office fédéral de la santé publique" and "Commission de la concurrence". |
| Office cantonal | 11 | Office cantonal | Cantonal Office |  |
| Office Cantonal | 1 | Office cantonal | Cantonal Office |  |
| Office communal | 1 | Office communal | Municipal Office |  |
| Office fédéral | 533 | Office fédéral | Federal Office |  |
| ONG | 1 | *à decider/éditer manuel* | *to be cleaned manually* | Netherlands Organisation for International Development Cooperation (Novib) → maybe categorize as International Organisation? |
| Organisation internationale | 66 | Organisation internationale | International Organisation |  |
| Organisation Internationale | 1 | Organisation internationale | International Organisation |  |
| Tribunal cant. | 1 | Juridique | Justice | There are other cantonal or communal judicial authorities in the more general type "Autorités judiciaires"; therefore they could be mapped there. |
| Tribunal cantonal | 2 | Juridique | Justice | There are other cantonal or communal judicial authorities in the more general type "Autorités judiciaires"; therefore they could be mapped there. |
| Tribunal Cantonal. | 2 | Juridique | Justice | There are other cantonal or communal judicial authorities in the more general type "Autorités judiciaires"; therefore they could be mapped there. |
| Tribunal communal | 1 | Juridique | Justice | There are other cantonal or communal judicial authorities in the more general type "Autorités judiciaires"; therefore they could be mapped there. |
| Tribunal Féd. | 1 | Juridique | Justice | There are other "Tribunal fédéral" in the more general type "Autorités judiciaires"; therefore they could be mapped there. |
| Tribunal Féd.? | 1 | Juridique | Justice | There are other "Tribunal fédéral" in the more general type "Autorités judiciaires"; therefore they could be mapped there. |
| Union européenne | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Union Européenne | 2 | *à decider/éditer manuel* | *to be cleaned manually* |  |

Resulting vocabulary (i.e., typeEntite_standard):

* Administration
* Association
* Cantonal Department
* Cantonal Office
* Central Bank
* Church
* Extra-Parliamentary Commission
* Federal Department
* Federal Office
* Hospital
* International Organisation
* Justice
* Ministry
* Municipal Office
* Teaching
* *to be cleaned manually*

#### Sphere: Economique

| typeEntite | num | typeEntite_normalised | typeEntite_standard | comment |
|-------------|----:|-----------------------|---------------------|---------|
|  | 123 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| association | 8 | Association | Association |  |
| Association | 7287 | Association | Association |  |
| Association (carrière) | 4 | Association | Association |  |
| Associaton | 2 | Association | Association |  |
| Autorités Cant. | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Autorités fed. | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Banque | 1 | Entreprise | Enterprise | All other banks were classified as enterprises. |
| Dir/CEO | 1 | Entreprise | Enterprise | All other factories were classified as enterprises. |
| Entreprise | 16445 | Entreprise | Enterprise |  |
| Entrepriseq | 1 | Entreprise | Enterprise |  |
| Presse | 7 | Presse | Press |  |
| Prix/Distinction | 2 | Prix/Distinction | Award/Distinction |  |
| Recherche | 1 | *à decider/éditer manuel* | *to be cleaned manually* | Maybe also *Entreprise*, as it is a research facility within a private business (are there other cases?). |

Resulting vocabulary (i.e., typeEntite_standard):

* Association
* Award/Distinction
* Enterprise
* Press
* *to be cleaned manually*

#### Sphere: Militaire

| typeEntite | num | typeEntite_normalised | typeEntite_standard | comment |
|-------------|----:|-----------------------|---------------------|---------|
|  | 2 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Armée | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Militaire | 456 | Militaire | Military |  |

Resulting vocabulary (i.e., typeEntite_standard):

* Military
* *to be cleaned manually*

#### Sphere: Politique

| typeEntite | num | typeEntite_normalised | typeEntite_standard | comment |
|-------------|----:|-----------------------|---------------------|---------|
|  | 23 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| assemblée fed. | 4 | Assemblée Féd. | Federal Assembly |  |
| assemblée Fed. | 1 | Assemblée Féd. | Federal Assembly |  |
| Assemblée fed. | 5 | Assemblée Féd. | Federal Assembly |  |
| Assemblée Fed. | 20 | Assemblée Féd. | Federal Assembly |  |
| Assemblée féd. | 2 | Assemblée Féd. | Federal Assembly |  |
| Assemblée Féd. | 6746 | Assemblée Féd. | Federal Assembly |  |
| Assoc | 1 | Association | Association |  |
| Association | 4 | Association | Association |  |
| Autorité cant. | 8 | Autorité cant. | Cantonal Authority |  |
| Autorité cantonale | 1 | Autorité cant. | Cantonal Authority |  |
| Autorité comm. | 3 | Autorité comm. | Municipal Authority |  |
| `Autorité communale` | 1 | Autorité comm. | Municipal Authority | Hidden line break to be removed from this field. |
| autorités cant. | 1 | Autorité cant. | Cantonal Authority |  |
| Autorités cant. | 15349 | Autorité cant. | Cantonal Authority |  |
| Autorités Cant | 1 | Autorité cant. | Cantonal Authority |  |
| autorités comm. | 2 | Autorité comm. | Municipal Authority |  |
| Autorités comm | 1 | Autorité comm. | Municipal Authority |  |
| Autorités comm. | 8665 | Autorité comm. | Municipal Authority |  |
| Autorités Comm. | 1 | Autorité comm. | Municipal Authority |  |
| Autorités communale | 1 | Autorité comm. | Municipal Authority |  |
| Autorités communales | 2 | Autorité comm. | Municipal Authority |  |
| Autorités comPrésidentm. | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Autorités fed. | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Autorités Fed. | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Autorités tchécoslovaques | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Commission extra-parl. | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| `Conseil communal` | 1 | *à decider/éditer manuel* | *to be cleaned manually* | Hidden line break to be removed from this field. |
| Conseil féd. | 1 | Conseil Féd. | Federal Council |  |
| Conseil Féd. | 124 | Conseil Féd. | Federal Council |  |
| Constituante | 19 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Grand Conseil | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Ministère turc | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| parti politique | 10 | Parti politique | Political Party |  |
| Parti  politique | 1 | Parti politique | Political Party | Double space to normalize. |
| Parti politique | 1116 | Parti politique | Political Party |  |
| Parti Politique | 5 | Parti politique | Political Party |  |

Resulting vocabulary (i.e., typeEntite_standard):

* Association
* Cantonal Authority
* Federal Assembly
* Federal Council
* Municipal Authority
* Political Party
* *to be cleaned manually*

#### Sphere: Presse

| typeEntite | num | typeEntite_normalised | typeEntite_standard | comment |
|-------------|----:|-----------------------|---------------------|---------|
| Journalisme | 13 | Journalisme | Journalism |  |
| Journalisme (carrière) | 2 | Journalisme | Journalism |  |

Resulting vocabulary (i.e., typeEntite_standard):

* Journalism

#### Sphere: Sociabilité

| typeEntite | num | typeEntite_normalised | typeEntite_standard | comment |
|-------------|----:|-----------------------|---------------------|---------|
|  | 2 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Association | 6 | Association | Association |  |
| Culturelle | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |
| Lieux de sociabilité | 8715 | Sociabilité | Sociability Space |  |
| Philanthropie | 1353 | Philanthropie | Philanthropic Organisation |  |
| Religieux | 1 | *à decider/éditer manuel* | *to be cleaned manually* |  |

Resulting vocabulary (i.e., typeEntite_standard):

* Association
* Philanthropic Organisation
* Sociability Space
* *to be cleaned manually*


#### Sphere: Sportive

only one case.