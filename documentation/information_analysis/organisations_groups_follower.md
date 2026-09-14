# New table: ***`t_group_follower`***

This table stores *historical and other non-hierarchical relationships* between groups (i.e., organisations, institutions, enterprises, political parties, and so on) in the ***`t_group`*** table. Relationships of this type may be many-to-many (n:n).

We use two columns – a source and a target column – to represent relationships between identified entities in ***`t_group`***. Both reference the primary key of ***`t_group`*** via foreign keys.

Importantly, relationships between organisational subunits and their parent organisations are not recorded in this table. Instead, they are represented through a separate *partOf* property directly in ***`t_group`*** ([see documentation](organisations_groups.md#organisational-subunits)).

&nbsp;

## Related Documents

* SQL script(s) for ... <font color="red">add info</font>
* Documentation on the [***`t_group`***](organisations_groups.md) table to which this table is linked via a foreign key
* [ERD](../graphics/ERD_with_new_tables.png) representing the original and newly introduced tables, with additional [ERD description](../graphics/ERD_with_new_tables.md).

&nbsp;

## Structure of the Table

| Column Name | Data Type | Description | Mapping |
|-------------|-----------|-------------|---------|
| pk_group_follower | integer | Primary key of this table |  |
| sequence_type | character varying | Type of relationship, i.e. "splitting", "merging" or "following" |  |
| description | character varying | Short description of the relationship |  |
| notes | character varying | Optional comments (for internal use) |  |
| fk_group_source | integer | Foreign key to ***`t_group`*** |  |
| fk_group_target | integer | Foreign key to ***`t_group`*** |  |
| import_notes | character varying | Notes on data import |  |

&nbsp;

## Data Entry of Followers (Historical Move)

We distinguish three different types of a sequential relationship between groups. These are:

1. Splitting: a group or organisation splits up into several new groups or organisations. The original enitity is usually dissolved, but it can also coexist further.
2. Merging: a group or organisation merges with one or more other group(s) or organisation(s). The result is a new entity. By definition, a merger has the effect, that the previous entities cannot further exist.
3. Following: a group or organisation may substantially transform its shape, aim or status, which results in a new group or organisation. In this case, an existing entity is replaced with a new entity.

Example of data entry:

| pk_group_follower | sequence_type | description | fk_group_source | Group (source) * | fk_group_target | Group (target) * |
| --- | --- | --- | --- | --- | --- | --- |
| 2 | merging |  | 460 | Ciba, Gesellschaft für Chemische Industrie Basel | 621 | Ciba-Geigy |
| 3 | merging |  | 670 | Geigy | 621 | Ciba-Geigy |
| 5 | splitting | Separation after 1970 to form 13 independent universities | 59 | Université de Paris (Sorbonne) | 287 | Université Paris I (Panthéon-Sorbonne) |
| 6 | splitting | Separation after 1970 to form 13 independent universities | 95 | Université de Paris (Sorbonne) | 426 | Université Paris II (Assas-Panthéon) |
| 7 | splitting | Separation after 1970 to form 13 independent universities | 95 | Université de Paris (Sorbonne) | 156 | Université Paris III (Nouvelle Sorbonne) |
| ... | ... | ... | ... | ... | ... | ... |
| 17 | splitting | Separation after 1970 to form 13 independent universities | 95 | Université de Paris (Sorbonne) | 289 | Université Paris XIII (Saint-Denis - Villetaneuse) |

*\* These columns represent the standard name of the entity in the ***`t_group`*** table and are shown here for representation only.*

&nbsp;

## Data Entry of Organisational Subunits (partOf)

Relationships between organisational subunits and their parent organisations are recorded directly in ***`t_group`*** ([see documentation](organisations_groups.md#organisational-subunits)).

&nbsp;

---

Go back to [New Table: ***`t_group`***](organisations_groups.md)<br>
Go back to [Organisations](organisations.md)<br>
Go back to [Comments on extended ERD](../graphics/ERD_with_new_tables.md)