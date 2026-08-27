
## Mandates and general issues

The rows in this table represent bundles of information, primarily instances of the [C13 Social Role Embodiment](https://ontome.net/class/697) class, but the data also contains information about **memberships**, **prizes**,**teaching activity**, and so on. As is common with older, research-driven databases, additional information has been added to the same '*mandates*' table, involving some implicit conceptual remodelling.

&nbsp;



### Types of mandates across spheres

The data in the 'mandat' table can be divided by different 'spheres' of a person's activiy, that is in politics, economoy, research etc. The original data base structures the available information on these activities (= mandates) across various fields:

* **typeEntite**: the field of activity considered as a 'mandate' (for example: a mandat in teaching, research, administration, or in a company or association)
* **entite**: the name of the group (institution, organisation, association, enterprise, etc.), in which a 'mandate' was carried out.
* **organe**: the organisational (sub-)unit of an 'entite' in the sense above (for example: a department or faculty of a higher education institution, a board of an association, etc.)
* **fonction**: the function or role a person has within the 'entite' or the 'organe' of an 'entite' (for example: director, member, assistant, judge, ...)
* **partiAffiliationOfficeSecteur**: a field used for further specifying an 'entite' or 'organe' (for example: the subject or discipline a 'mandate' was located within a university)

Across the various 'spheres', these five typical fields were used to tackle down a person's activity. Depending on the 'typeEntite', however, the notions of the other fields seem to be varying. Therefore, also the type of content in these fields varies from 'typeEntite' to 'typeEntite'. In addition, the 'typeEntite' field does not contain a controlled vocabulary (not to mention the other fields).





### Distribution of mandates per sphere.

|sphere|num|
|------|---|
|[Académique](mandates_academique.md)|29094|
|[no sphere](mandates_without_sphere.md)|1153|
|[Militaire](mandates_militaire.md)|459|
|[Sportive](mandates_presse_sportive.md)|1|
|[Economique](mandates_economique.md)|23884|
|[Presse](mandates_presse_sportive.md)|15|
|[Politique](mandates_politique.md)|32126|
|[Administrative](mandates_administrative.md)|15661|
|[Sociabilité](mandates_sociabilite.md)|10078|
|**total**|**112471**|


We decided to split the analysis and refactoring of the database in line with the 'spheres' and created correspondingly a view per sphere.

Cf. [this document](../database_inspection/mandates_sphere_entity_type.sql) with the SQL code.

&nbsp;



In the table above, the links point to pages with the discussion of each kind of sphere and notably lists that try to structure the available information for 'typeEntite' across the spheres. The lists contain the original field content, the number of mandates, a suggested normalised vocabulary, and a standard english language vocabulary. See also [inspection script](../database_inspection/sk_mandates_scheme-for-typeEntite.sql).

*These lists can be taken as an outset for cleaning the 'typeEntite' and later data cleaning and verified across the various spheres. The above script contains some queries to look into the data in the mandates table. It is useful sometimes to include the 'organe', 'fonction' and 'partiAffiliationOfficeSecteur' in querying the data to verify the concepts below again before finally modifying the data.*

The lists should already provide a good indication on the various types of mandates in the table.





&nbsp;

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

