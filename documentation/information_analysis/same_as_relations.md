| Column Name     | Data Type         | Comments | Mapping | Mapping Comments |
| ----------------- | ------------------- | ---------- | --------- | ------------------ |
| zkf_ID_linked   | integer           |          |         |                  |
| Identifier_code | character varying |          |         |                  |
| Identifier      | character varying |          |         |                  |


&nbsp;

Cf. [the SQL code](../database_inspection/identifiers_data_wrangling.sql) for cleaning up and preparing the *elites_suisses.same_as* view


&nbsp;

Strictly speaking these are not owl:sameAs relation because the Elites Suisses identifiers are URLs and not URIs.

We therefore have to:

* use the ... property (or identifier construct)
* create a view where the correct URI is provided for some LOD repositories like Wikidata, IdRef, BNF data etc.
