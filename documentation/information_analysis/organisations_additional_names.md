


## New table : t_group_appellation

Cf. these [SQL scripts](../database_inspection/groups_appellations.sql) and the 


The database stored information on variations of names of given entities in a separate table. This information was used to create the new table `t_group_appellation` for documenting name variations, also variants in different languages. As documented in (((LINK ZU T_GROUP DOKU))), the group-entities in the transformed database were given a standard name (usually in the name/appellation of the original languages, where roman letters applied, otherwise in english). In this table here, all name (appellation) variants departing from the standard name are stored.

The creation of the table with its fields is documented in (((THIS))) script.

6 entities have been dismissed from the original table due to containing no values.

| Column Name | Data Type | Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| pk_group_appellation | integer | primary key |   |   |
| fk_group | integer | foreign key to entity in `t_group` |   |   |
| appellation | character varying | appellation variant of entity |   |   |
| appellation_language | character varying | two-character language code of the appellation, if applicable |   |   |
| date_begin | character varying | year from (4 digits), (* this field is currently not used *) |   |   |
| date_end | character varying | year until (4 digits), (* this field is currently not used *) |   |   |
| description | character varying | description of the appellation variant (* optional field *) |   |   |
| notes | character varying | notes on manual changes to the data |   |   |
| import_notes | character varying | notes on initial data import |   |   |


***Procecure:***

* In general, language labels have been added manually and partwise for the data (e.g. by filtering for expressions such as "université", "university", "universität" and so on); parts = spheres in the entite table (see script ...) and entity (i.e. group) types ==> clean after t_group table has been complemented
* Lower-case initial letters have been manually changed to upper case
* In eight cases, the `appellation` field contained a line break in the end, which has been removed manually:
    * dfsaf

    | pk_group_appellation | appellation |
    |---|---|
    | 1799 | L. Givaudan & Co |
    | 3711 | "Commission des Commissions (Arbeitsgruppe Kommissionsregister)" |
    | 4068 | Firmenich & Co, successeurs de la société anonyme M. Naef & Cie |
    | 5490 | Fondation Hans Wilsdorf (Rolex SA) Genève |
    | 5508 | Raymond Weil SA |
    | 5505 | Fabrique Solvil des Montres Paul Ditisheim, Société Anonyme |
    | 5515 | Montres Universal, Perret & Berthoud S.A. (Universal Watches, Perret & Berthoud Ltd.) |
    | 5519 | Compagnie des Montres Favre-Leuba S.A. |


***terms:***
added language label
corrected appellation name
corrected appellation name (removed line break)
added language label; corrected appellation name
added language label; corrected appellation name (removed line break)

***To do:***
* Add not existing appellations from the cleaned t_group table to the t_group_appellation table
* define standard appellation label (suggestion: is the one used in the name_standard field in the t_group table)
* the cantons would need to be checked. For example, right now there is only one "Tessin" (de or fr, currently given fr), but there would need two labels because Tessin is both French and German. Same is true for all bi-lingue cantons (VS, FR, BE) sowie GR (de, it, rm)
* discern between entities with traductions/different languages and such which's varying appellations represent different names (i.e. for enterprises and associations); this distinction could also be made using the t_group_type => some group types can have different language labels, some have different appellations regardless of the language
    * => ***check the whole table again for this distinction after cleaning up groups and group types***

## Original table: autresNomsEntites
| Column Name | Data Type | Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| id | integer |   |   |   |
| autreNom | character varying |   |   |   |
| idEntite | character varying |   |   |   |
| zkp | character varying |   |   |   |
| modif | timestamp without time zone |   |   |   |
| entite_id | integer |   |   |   |

&nbsp;
