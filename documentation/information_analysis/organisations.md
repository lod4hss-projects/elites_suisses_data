# Organisations (***`entites`***, replaced by ***`t_group`***)

We find several types of organisations in the Élites suisses database. They are treated partly as *identified entities* (i.e., rows) in the ***`entites`*** table, and partly as *strings* in the ***`education`*** and ***`mandat`*** tables, notably in the columns `Institution` of the former and the columns `entite`, `organe` and `partiAffiliationOfficeSecteur` of the latter.

In the transformation process to LOD, which implies a logic *from strings to things*, all organisations and sub-units of organisations are to be identified, so that they can be associated to relevant facts using their URIs.

* [This page](organisations_entites_table_inspect.md) documents the *entites* and *autresNomsEntites* tables.
* [This page](organisations_groups.md) documents the new *t_group* and *t_group_type* tables

&nbsp;

---

Go back to [Semantic Analysis and Mapping of the Database Tables](../available_information.md)<br>
Go back to [Comments on extended ERD](../ERD_with_new_tables.md)
