# New table: ***`t_group`***

Info that t_group is the enhanced version of the original entites table that also contains entities found in the related education and mandat tables.

Important aspects are the interrelation of entities in this table. Some are smaller units of a larger organisation, some are historical transformations. Case A, entering of the data directly in the table (due n:1? relation). An organizational subunit that has a partOf property pointing to a larger organization represents an n:1 (many-to-one) relationship. Many subunits can all point to the same single larger organization (e.g., the HR Department, IT Department, and Finance Department are each partOf Company X).From the perspective of the subunit's property, each individual subunit links back to one parent organization.
Case B, entering the data in additional table t_group_follower (see documentation) due to a n:n relation

## Related Documents

* 
* 

## Structure of the Table

## Initial Data Import


## Data Cleaning and Enrichment

u.a. reconciliation using OpenRefine



# Group and related tables

Documentation of the t_group, t_group_type, t_group_appellations, t_group_follower tables

We recreated an ERD representing the original classes/tables and the new ones. It is [available here](../graphics/ERD_with_new_tables.png) and documented [in this file](../graphics/ERD_with_new_tables.md).

&nbsp;

## t_group table

The SQL queries in [this document](../database_inspection/groups_additional_entities.sql) show that serveral political entities, like parlaments and governements of cantons, are *not explicitely defined but just appear in the ***organe* column of the mandates** table*.

In order to identify these second level, not explicitely identified organisations, we created **a new table** to identify organisations: the *t_group* table.

More details on the columns and relations of this table, cf. [ERD](../graphics/ERD_with_new_tables.png) and [ERD documentation](../graphics/ERD_with_new_tables.md).

&nbsp;

### Import of the entites table

All of the *entites* table were imported into the *t_group* table.

The import notes value "20260724_imp1" allow to find in the SQL code the script and identify the imported rows.

The correspondent entity in the entity table is linked in the *fk_source_entity* column.

Not all the columns were imported but only the relevant ones, notably not *typeEntite* and *sphere*. They respective values can be inpected using SQL joins.

## t_group_appellation

This table allows to store additional names for groups, and provide dates of use and language for each of them.

For the data management and import from the original [*autresNomsEntites*](organisations_additional_names.md) see these [SQL scripts](../database_inspection/groups_appellations.sql) 
