# New table: ***`t_group_appellation`***

This is the recreated and refined version of the original ***`autresNomsEntites`*** table. It shares the same DNA, but allows for a better handling of language-specific and time-depending name variants. Also, aliases can now be described (if needed), and they can be assigned with a start date or end date.

<font color="red">The database stored information on variations of names of given entities in a separate table. This information was used to create the new table `t_group_appellation` for documenting name variations, also variants in different languages. As documented in (((LINK ZU T_GROUP DOKU))), the group-entities in the transformed database were given a standard name (usually in the name/appellation of the original languages, where roman letters applied, otherwise in english). In this table here, all name (appellation) variants departing from the standard name are stored.</font>

&nbsp;

## Related Documents

* SQL scripts for the creation of the table and initial data import: [groups_new_tables.sql](../database_inspection/groups_new_tables.sql) and [groups_appellations.sql](../database_inspection/groups_appellations.sql)
* Documentation on the [***`t_group`***](organisations_groups.md) table to which this table is linked via a foreign key
* Documentation on the original [***`autresNomsEntites`***](organisations_autresNomsEntites.md) table on which this table is based

&nbsp;

## Structure of the Table

| Column Name | Data Type | Description | Mapping  |
|-------------|-----------|-------------|----------|
| pk_group_appellation | integer | Primary key |   |
| fk_group | integer | Foreign key to entity in `t_group` |   |
| appellation | character varying | Appellation variant of entity |   |
| appellation_language | character varying | Two-character language code of the appellation, if applicable |   |
| date_begin | character varying | Year from (4 digits)<br><font color="red">currently not used, maybe add data from the t_group table</font> |   |
| date_end | character varying | Year until (4 digits)<br><font color="red">currently not used, maybe add data from the t_group table</font> |   |
| description | character varying | description of the appellation variant (optional) |   |
| notes | character varying | notes on manual changes to the data |   |
| import_notes | character varying | notes on initial data import |   |


&nbsp;


## Initial Data Import

6 entities have been dismissed from the original table due to containing no values.

&nbsp;

## Data Cleaning and Enrichment

--> Cleaning of ZH, zh, ... as naming variants of entities, where new entities have been created

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

&nbsp;

---

Go back to [New Table: ***`t_group`***](organisations_groups.md)<br>
Go back to [Inspection of the Original Table: ***`autresNomsEntites`***](organisations_autresNomsEntites.md)<br>
Go back to [Inspection of the Original Table: ***`entites`***](organisations_entites.md)<br>
Go back to [Organisations](organisations.md)