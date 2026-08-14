# Information about the `filiation` table

## Data Exploration

Here is the list of columns and their data type, as well as comments

| Column Name | Data Type |   Comments |
|-------------|-----------|------|
| sysid | integer | Internal system id, not to reuse |
| idFiliation | integer | ID of the Filiation, only reused in the creation of the view |
| idFils | integer | ID of the child |
| idParent | integer | ID of the parent |
| sexeParent | character | Not needed, this si deduced from the person |
| creation | character varying | Internal tracking of edition of data. Not to transform |
| saisie | character varying | Internal tracking of edition of data. Not to transform |
| auteurModif | character varying | Internal tracking of edition of data. Not to transform |
| zkp_filiation | character varying | Another ID of the Filiation, not to reuse |
| versionDate | date | Internal tracking of edition of data. Not to transform |

The table Filiation is rather straightforward, as it contains mostly foreign key to other persons.

## Data Transformation

Some data cleaning is needed to correct some of the inconsistencies (for instance where the id of the child is the same as the parent)

As the documentation of parents in the SDHSS ontology ecosystem is done through the birth event, a new view called `v_person_birth` is created, which contains:
- an identifier which is the concatenation of the two filiations (mother and father)
- a new identifier for the birth
- the birth year
- the foreign key of the child
- the foreign keys of the mother and father

First 20 lignes of the view:

|string_agg|id_birth|child|birth_year|mother|father|
|----------|--------|-----|----------|------|------|
|1696_615|bir_50001|50001|1856|64075|65916|
|1697|bir_50002|50002|1847||65917|
|2900|bir_50003|50003|1831||67195|
|2901|bir_50004|50004|1845||67196|
|9029|bir_50005|50005|1848||92791|
|2903_2902|bir_50007|50007|1849|67198|67197|
|2905_2904|bir_50012|50012|1889|67200|67199|
|2907_2906|bir_50014|50014|1881|67202|67201|
|2908_2909|bir_50016|50016|1891|67208|67203|
|517|bir_50017|50017|1897||61076|
|2911_2910|bir_50019|50019|1902|67207|67206|
|2912_2913|bir_50020|50020|1899|67210|67209|
|7782_1272|bir_50022|50022|1927|65439|61650|
|531_3853|bir_50023|50023|1915|68330|64026|
|2647_2648|bir_50024|50024|1924|66872|66871|
|2266|bir_50027|50027|1918||66478|
|6470|bir_50031|50031|1940||75706|
|3631|bir_50032|50032|1946||68088|
|4590_8690|bir_50037|50037|1938|74961|69166|
|4257|bir_50044|50044|1955||57607|

The SQL queries are documented [here](../database_inspection/filiations.sql)

## Data Mapping

The documentation of parents is done via the class [`crm:E67 Birth`](http://www.cidoc-crm.org/cidoc-crm/E67_Birth).

The ontological mapping from the table and the SDHSS ontology ecosystem is as follows:
- the births are instances of the class [`crm:E67 Birth`](http://www.cidoc-crm.org/cidoc-crm/E67_Birth)
- The column `child` is the ID of the person linked to the instance of birth through the property [`crm:P98 brought into life`](http://www.cidoc-crm.org/cidoc-crm/P98_brought_into_life)
- The column `mother` is the ID of the person linked to the instance of birth through the property [`crm:P96 by mother`](http://www.cidoc-crm.org/cidoc-crm/P96_by_mother)
- The column `father` is the ID of the person linked to the instance of birth through the property [`crm:P97 from father`](http://www.cidoc-crm.org/cidoc-crm/P97_from_father)

For the documentation of the birth dates, see [here](../information_analysis/person_birth-death.md)

Here is the ontological diagram:

![Filiation](../graphics/filiation.png)


