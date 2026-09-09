# Organisations

## Explicit and Implicit Entities in the Original Tables

We find several types of organisations in the Élites suisses database. They are treated partly as *identified entities* in the original ***`entites`*** table (as rows with associated names notably in the columns `nom` and `affiliationSecteurType`), and partly as *strings* in the original ***`education`*** and ***`mandat`*** tables (notably in the columns `Institution` of the former and the columns `entite`, `organe` and `partiAffiliationOfficeSecteur` of the latter).

* Documentation of the original [***`entites`***](organisations_entites.md) table
* Documentation of the original [***`education`***](education.md) and [***`mandat`***](mandates_general_inspection.md) tables

&nbsp;

## Name Variants and Language-Specific Variants

The original ***`autresNomsEntites`*** table stores *name variants and language-specific variants* of organisations.

* Documentation of the original [***`autresNomsEntites`***](organisations_autresNomsEntites.md) table

&nbsp;

## New and Refined Tables

In the transformation process to LOD, which implies a logic *from strings to things*, all organisations and sub-units of organisations are to be identified, so that they can be associated to relevant facts using their URIs. For this purpose, we created the new table ***`t_group`***. It replaces the original ***`entites`*** table and adds the additional organisations found in the original ***`education`*** and ***`mandat`*** tables – and even in the ***`entites`*** table – that were not identified as entitites before.

The table ***`autresNomsEntites`*** has been recreated and named ***`t_group_appellation`***.

Two additional tables have been newly created to document the *organisation type* (***`t_group_type`***) as well as *links between organisations* (***`t_group_follower`***), which both were not explicitly documented in the original database.

* Documentation of the new [***`t_group`***](organisations_groups.md) table
* Documentation of the additional tables [***`t_group_appellation`***](organisations_groups_appellations.md), [***`t_group_type`***](organisations_groups_types.md) and [***`t_group_follower`***](organisations_groups_follower_partof.md)

&nbsp;

---

Go back to [Semantic Analysis and Mapping of the Database Tables](../available_information.md)<br>
Go back to [Comments on extended ERD](../ERD_with_new_tables.md)
