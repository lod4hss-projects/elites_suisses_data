# New table: ***`t_group_type`***

The ***`t_group_type`*** table contains a controlled vocabulary for the types of groups or organisations represented in the Élites suisses database. It is a newly created table that has no direct equivalent in the original database.

In the original database, entity types are stored as text strings in the `typeEntite` columns of both the ***`entites`*** and ***`mandat`*** tables. <font color="red">The values used in these two tables are not fully consistent.</font> Moreover, not all records in ***`mandat`*** are linked to an entity in ***`entites`***, meaning that the type information in both tables needs to be taken into account when reconstructing and standardising the organisation types.

Therefore, the new ***`t_group_type`*** table replaces these heterogeneous text values with a standardised vocabulary that can be referenced from ***`t_group`***.

&nbsp;

## Related Documents

* SQL script(s) for ... <font color="red">add info</font>
* Documentation on the [***`t_group`***](organisations_groups.md) table, which references the controlled vocabulary provided by this table via a foreign key
* Documentation on the [distribution of spheres and entity types](organisations_entites.md#distribution-of-spheres-and-entity-types) in the original ***`entites`*** table
* Documentation on the [distribution of spheres and entity types](mandates_general_inspection.md) in the original ***`mandat`*** table

&nbsp;

## Structure of the Table

| Column Name | Data Type | Description | Mapping |
|-------------|-----------|-------------|---------|
| pk_group_type | integer | Primary key of this table |  |
| name | character varying | Name of the entity type |  |
| description | character varying | Short description of the entity type |  |
| notes | character varying | Optional comments (for internal use) |  |
| wikidata_uri | character varying |  |  |
| import_notes | character varying | Notes on data import |  |

## Data Entry

The controlled vocabulary is constructed primarily through manual data cleaning and classification, including reconciliation with Wikidata where appropriate.

The main starting point is the combination of `typeEntite` and `sphere` in the original ***`entites`*** and ***`mandat`*** tables. These fields are considered jointly because of additional context. Where necessary, additional information from other columns and related records is used to determine the appropriate group type (see also the [discussion of explicit and implicit entities](organisations.md#explicit-and-implicit-entities) as well as the original distribution of spheres and entity types in the original [***`entites`***](organisations_entites.md#distribution-of-spheres-and-entity-types) and [***`mandat`***](mandates_general_inspection.md) tables).

The resulting categories are entered as standardised types in ***`t_group_type`*** and subsequently assigned to the corresponding entities in ***`t_group`***.

&nbsp;

---

Go back to [New Table: ***`t_group`***](organisations_groups.md)<br>
Go back to [Inspection of the Original Table: ***`entites`***](organisations_entites.md)<br>
Go back to [Organisations](organisations.md)<br>
Go back to [Comments on extended ERD](../graphics/ERD_with_new_tables.md)