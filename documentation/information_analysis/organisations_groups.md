# New table: ***`t_group`***

The ***`t_group`*** table provides the central representation of organisations and other group-level entities. It is the enhanced version of the original ***`entites`*** table. It contains the entities (predominantly organisations and institutions) identified in the Élites suisses database. In addition to the entities explicitly recorded in the original ***`entites`*** table, it is intended to include entities that are only implicitly represented in related tables, particularly the ***`education`*** and ***`mandat`*** tables.

A central objective of the new table is to provide a more consistent representation of organisations and institutions of all kinds and to make relationships between them explicit. These relationships include *organisational hierarchies* (e.g. a university's department or faculty that forms part of a larger organisation) as well as *historical relationships between entities* (e.g. an institution that succeeds or replaces another institution).

&nbsp;

## Related Documents

* SQL scripts for the creation of the table and initial data import: [groups_new_tables.sql](../database_inspection/groups_new_tables.sql) and <font color="red">to complete</font>
* Documentation on the [***`t_group_appellation`***](organisations_groups_appellations.md), [***`t_group_type`***](organisations_groups_types.md) and [***`t_group_follower`***](organisations_groups_follower.md) tables which are linked to this table via foreign keys
* Documentation on the original [***`entites`***](organisations_entites.md) table on which this table is based
* [ERD](../graphics/ERD_with_new_tables.png) representing the original and newly introduced tables, with additional [ERD description](../graphics/ERD_with_new_tables.md).

&nbsp;

## Structure of the Table

| Column Name | Data Type | Description | Mapping |
|-------------|-----------|-------------|---------|
| pk_group | integer | Primary key | We use this key to reference to entities across the database |
| name_standard | character varying | A standard name in the organisation's original language used for representation in the graph <br><font color="red">We could also include all these names in the appellation table and introduce there a new binary-coded column called "is_standard_name"</font> |   |
| na_st_language | character varying | 2-letter language code (i.e., standard language of the referenced entity) |   |
| name_french | character varying | Cleaned name from the original data |   |
| name_original | character varying | Original string stored in the Élites suisses database |   |
| definition | character varying | Optional definition of an entity |   |
| fk_group_type | integer | Foreign key to the ***`t_group_type`*** table |   |
| notes | character varying | Optional note field on researching information on organisations |   |
| wikidata_uri | character varying | Wikidata URI |   |
| fk_source_entity | integer | Foreign key to the ***`entites`*** table, which contains the original data |   |
| fk_part_of | integer | Internal foreign key used to document organisational sub-units using the *partOf* property |   |
| import_notes | character varying | Notes on data import (either from the original table or newly created) |   |
| date_begin | character varying | Begin of existence of an organisation. We took the original values as a starting point for further data cleaning |   |
| date_end | character varying | End of existence of an organisation. We took the original values as a starting point for further data cleaning |   |
| manual_edits | character varying | Documentation of manual edits to the imported data |   |

&nbsp;

## Relations Between Groups

Groups represented in ***`t_group`*** may be related to one another in different ways. Two cases need to be distinguished.

**Organisational hierarchy (partOf)**: An organisational subunit may belong to a larger organisation. This constitutes a many-to-one (n:1) relationship, because several subunits may belong to the same parent organisation. For example, an HR department, an IT department, and a finance department may all be part of the same organisation. Because each subunit points to a single parent organisation, this relationship can be represented directly in ***`t_group`*** and is documented in the column `fk_part_of` entering the primary key of the parent organisation within the same table.

**Historical and other non-hierarchical relationships**: Some relationships cannot be represented adequately by a single parent reference. This applies in particular to historical transformations in which institutions are split, merged, replaced, or reorganised. Such relationships may be many-to-many (n:n) and are therefore recorded in the separate ***`t_group_follower`*** table. See the [corresponding documentation](organisations_groups_follower.md) for details.

**Alternative and language-specific names**: A group or organisation may have multiple name variants at a given point in time or across different periods. For example, a company may change its name without undergoing an organisational transformation and therefore remain the same entity. Moreover, depending on the languages and sources used, multiple appellations may coexist at the same point in time. The ***`t_group_appellation`*** table accounts for these variations by allowing multiple appellations to be linked to the same entity in ***`t_group`*** via a foreign key (one-to-many relationship). This makes it possible to represent name variants without creating separate entities in ***`t_group`***. This table was already present in in the original database (see the [corresponding documentation](organisations_autresNomsEntites.md)).

&nbsp;

## Initial Data Import

### Import from ***`entites`***

All entities from the original ***`entites`*** table were imported into ***`t_group`***.

The import note "20260724_imp1" identifies the corresponding import operation and makes it possible to locate the SQL code used to create these records.

For imported records, the corresponding record in the original entites table is referenced through the `fk_source_entity` column.

Not all columns of the original table were transferred directly. In particular, `typeEntite` and `sphere` were not imported as columns into ***`t_group`***. Their original values remain accessible through SQL joins and can be used during data cleaning, classification, and validation.

### Additional implicit entities

Several organisations are not explicitly represented in the original ***`entites`*** table but occur implicitly in related tables. SQL queries in [groups_additional_entities.sql](../database_inspection/groups_additional_entities.sql), for example, show that several political bodies, such as cantonal parliaments and governments, appear only in the `organe` column of the ***`mandat`*** table.

The new data model makes it possible to identify these previously implicit organisations as entities in their own right and to add them to ***`t_group`***.

&nbsp;

## Data Cleaning and Enrichment

The migration to ***`t_group`*** is not limited to reproducing the existing data. It also provides an opportunity to reconcile entities, resolve inconsistencies, document relationships between groups, and improve the representation of names and historical changes.

The main tasks include:

* reconciliation with external authority data, particularly Wikidata, using OpenRefine,
* identification and resolution of inconsistent or ambiguous entities,
* validation of the historical periods during which institutions existed against the dates of associated education or mandate records,
* identification of organisational hierarchies and *partOf* relationships,
* identification of historical transformations, including institutional succession, splits and mergers, and their documentation in ***`t_group_follower`***
* consolidation and enrichment of appellations in ***`t_group_appellation`***.

### Temporal inconsistencies in the linking of persons and organisations

Some entities of the university type existed only during specific historical periods. For example, the *Technische Hochschule Berlin* was established under that name in 1879 and was succeeded by the *Technische Universität Berlin* after the Second World War. Both institutions are generally represented as distinct entities in external authority data, including Wikidata.

The Élites suisses database does not always maintain this distinction consistently. In some cases, only one historical variant of an institution has persons assigned to it. For example, the *Technische Hochschule Berlin* entity contains no persons, while *Technische Universität Berlin* includes persons whose studies predate the existence of the institution under that name. The corresponding Wikidata entities are [Q17403358](https://www.wikidata.org/wiki/Q17403358) and [Q51985](https://www.wikidata.org/wiki/Q51985).

Similar cases occur elsewhere. When comparing *Universität Erlangen-Nürnberg* and *Universität Erlangen*, for example, all persons appear to have been assigned to the former, more recent institution.

These cases require a distinction between two questions: **which historical institution existed at a given point in time**, and **which entity was actually assigned to a person in the original database**. The cleaned data should preserve the provenance of the original assignment while allowing historically more accurate entities and relationships to be represented.

### Matching related and historically transformed institutions

Examples:

| Group (source) * | Group (target) * | Event | Description |
|----------------|----------------|-------|-------------|
| Ciba, Gesellschaft für Chemische Industrie Basel | Ciba-Geigy | merging |  |
| Geigy | Ciba-Geigy | merging |  |
| Université de Paris (Sorbonne) | Université Paris I (Panthéon-Sorbonne) | splitting | Separation after 1970 to form 13 independent universities |
| Université de Paris (Sorbonne) | Université Paris II (Assas-Panthéon) | splitting | Separation after 1970 to form 13 independent universities |
| Université de Paris (Sorbonne) | Université Paris III (Nouvelle Sorbonne) | splitting | Separation after 1970 to form 13 independent universities |
| ... | ... | ... | ... |
| Université de Paris (Sorbonne) | Université Paris XIII (Saint-Denis - Villetaneuse) | splitting | Separation after 1970 to form 13 independent universities |

*\* Note: Instead of strings, the matching is made using foreign keys of the respective `pk_group`. See documentation on the [***`t_group_follower`***](organisations_groups_follower.md) table.*

### Organisational subunits

A further question concerns organisational units such as colleges, institutes, departments, faculties, and schools. Examples include Harvard College, Harvard Law School, Harvard Business School, the Toulouse School of Economics or the several Max Planck institutes.

Where these units constitute identifiable organisations in their own right, they may be represented as separate records in ***`t_group`*** and linked to their parent organisation through a partOf relationship in the column `fk_part_of`. This makes it possible to preserve the level of organisational specificity found in the source data without conflating a subunit with its parent institution.

Example:

| pk_group | name_standard | fk_part_of |
|----------|---------------|------------|
| 101 | Harvard University |  |
| 262 | Harvard Law School | 101 |
| 274 | Harvard Business School | 101 |
| 450 | Harvard College | 101 |
| 3366 | Harvard Medical School | 101 |
| 3485 | Harvard Kennedy School of Government | 101 |

The precise criteria for deciding when a subunit should receive its own ***`t_group`*** record still need to be defined consistently.

### Appellations

Alternative, historical, and language-specific names of groups are stored in the ***`t_group_appellation`*** table. In addition to the name itself, the table can record the language and period of use of an appellation, allowing historical name changes to be distinguished from simple aliases or translations.

Example:

| pk_group_appellation | fk_group * | appellation |
|----------------------|----------|-------------|
| 230 | Harvard University | Harvard University |
| 231 | Harvard University | Université Harvard |
| 785 | Harvard Law School | Harvard Law School |
| 786 | Harvard Law School | Faculté de droit de Harvard |
| 819 | Harvard Business School | Harvard Graduate School of Business Administration |
| 820 | Harvard Business School | Harvard Business School |
| 1263 | Harvard College | Harvard College |
| 5838 | Harvard Medical School | Harvard Medical School |
| 6118 | Harvard Kennedy School of Government | Harvard Kennedy School of Government |
| 6119 | Harvard Kennedy School of Government | Harvard Kennedy School |

*\* Note: For illustrative reasons, the referenced text vaules of `name_standard` are shown instead of the integer values in `pk_group`, which is used as the foreign key.*

For details on the data model and the import from the original ***`autresNomsEntites`*** table, see the documentation on [***`t_group_appellation`***](organisations_groups_appellations.md) and the corresponding SQL scripts.

&nbsp;

---

Go back to [Organisations](organisations.md)<br>
Go back to [Inspection of the Original Table: ***`entites`***](organisations_entites.md)<br>
Go back to [Comments on extended ERD](../graphics/ERD_with_new_tables.md)

