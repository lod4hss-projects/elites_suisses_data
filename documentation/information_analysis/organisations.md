# Organisations

## Explicit and Implicit Entities in the original ***`entites`***, ***`education`*** and ***`mandat`*** tables

We find several types of organisations in the Élites suisses database. They are treated partly as *identified entities* in the original ***`entites`*** table (notably in the columns `nom` and `affiliationSecteurType`), and partly as *strings* in the original ***`education`*** and ***`mandat`*** tables (notably in the columns `Institution` of the former and the columns `entite`, `organe` and `partiAffiliationOfficeSecteur` of the latter).

In the transformation process to LOD, which implies a logic *from strings to things*, all organisations and sub-units of organisations are to be identified, so that they can be associated to relevant facts using their URIs. For this purpose, we created the new table ***`t_group`***. It replaces the original ***`entites`*** table and adds the additional organisations found in the original ***`education`*** and ***`mandat`*** tables – and even in the ***`entites`*** table – that were not identified as entitites before.

&nbsp;

## Language Labels and Naming Variants

In addition, the original table ***`autresNomsEntites`*** stores different language labels and naming variants of organisations. This table has been recreated as well and has been named ***`t_group_appellation`***.

&nbsp;

## Organisation Types and Links Between Organisations

Two additional tables have been newly created to document the organisation type (***`t_group_type`***) as well as links between different organisations (***`t_group_follower`***), which both were not explicitly documented in the original database.

&nbsp;

## Documentation

We provide documentation pages for the tables mentioned above:

* [This page](organisations_entites.md) documents the the original ***`entites`*** table. 
* [This page](organisations_autresNomsEntites.md) documents the original ***`autresNomsEntites`*** table.
* [This page](organisations_groups.md) documents the new ***`t_group`*** table, along with the additional tables ***`t_group_appellation`***, ***`t_group_type`*** and ***`t_group_follower`***.
* The above mentioned ***`education`*** and the ***`mandat`*** tables are documented seperatly ([here](education.md) and [here](mandates_general_inspection.md)).

&nbsp;

---

Go back to [Semantic Analysis and Mapping of the Database Tables](../available_information.md)<br>
Go back to [Comments on extended ERD](../ERD_with_new_tables.md)
