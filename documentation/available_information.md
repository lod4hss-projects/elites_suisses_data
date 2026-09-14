# Semantic Analysis and Mapping of the Database Tables

We created an ERD representing the original tables along with the new ones created for the transformation of the Élites suisses database as part of the LESSH project. The diagram is [available here](../documentation/graphics/ERD_with_new_tables.png) and [described here in more detail](../documentation/graphics/ERD_with_new_tables.md).

&nbsp;

## Original Tables

The following tables were delivered by the Élites suisses project to be transformed:

| Source Table | Concept | Content | Mapping | Documentation |
|--------------|---------|---------|------------------|---------------|
| ***`identite`*** | Persons | Rows represent persons. | primarily instances of the CIDOC CRM E21 Person class | [Data inspection and structure](information_analysis/identite.md) |
| ***`identifier`*** | Links | Rows represent relations to other identifiers or to webpages about the same persons. |  | Data inspection and structure on [sameAs relations](information_analysis/same_as_relations.md) and [identifiers](information_analysis/identifier.md) |
| ***`filiations`*** | Parents | Rows represent relations to parents. |   | [Data inspection and structure](information_analysis/filiations.md) |
| ***`mariage`*** | Marriage | Rows represent marriages. |   | [Data inspection and structure](information_analysis/marriage.md) |
| ***`education`*** | Education | Rows represent educational phases (studies and degrees). |   | [Data inspection and structure](information_analysis/education.md) |
| ***`entites`*** | Organisations | Rows represent organisations of different kinds. | Instances of the CIDOC CRM E74 Group class | [Overview page to the documentation of entities (i.e., organisations)](information_analysis/organisations.md) |
| ***`autresNomsEntites`*** | Organisations (name variants) | Additional table to the organisations table, containing labels for the same organisations |  | [Overview page to the documentation of entities (i.e., organisations)](information_analysis/organisations.md) |
| ***`mandat`*** | Mandates | Rows represent a bundle of different informations about social roles, memberships and prizes. | Instances of the [C13 Social Role Embodiment](https://ontome.net/class/697) class, but also information about Memberships, Prizes, etc. is present in the data | [Overview page to the documentation of mandates](information_analysis/mandates_general_inspection.md) |

&nbsp;

## New tables

In addition to the original tables, new tables allow for creating additional entities and associating the original text values in the source tables to these entities. The names of these tables are prefixed with "***`t_`***" to distinguish them from the original tables.

The following tables were newly created for transforming the database:

* ***`t_education_cleaning_up`*** (Education - table for cleaning up the ***`education`*** table) <font color="red">--> the *t_education_cleaning_up* table needs to be created</font>
* ***`t_gender`*** (Gender)
* ***`t_geo_place`*** (Geographical Place)
* ***`t_geo_place_kind`*** (...)
* ***`t_geo_relation`*** (Relation of Person and Place)
* ***`t_group`*** (Organisation/Group – replaces the ***`entites`*** table)
* ***`t_group_appellation`*** (Organisation/Group Naming Variant – replaces the ***`autresNomsEntites`*** table)
* ***`t_group_follower`*** (Following Organisation/Group)
* ***`t_group_type`*** (Organisation/Group Type)
* ***`t_mandates_cleaning_up`*** (Mandates - table for cleaning up the ***`mandat`*** table)
* ***`t_person_place`*** (...)
* ***`t_social_relationship_type`*** (Social Relationship Type)
* ***`t_social_role`*** (Social Role)
* ***`t_study_discipline`*** (Study Discipline)
* ***`t_study_title`*** (Study Title/Degree)

The relations between these tables are documented in the extended ERD (see [diagram](../documentation/graphics/ERD_with_new_tables.png) and [description](../documentation/graphics/ERD_with_new_tables.md)).

 &nbsp;

## New views

The following views were used for data inspection and consistency check:

* *`v_cam_group_with_types`*
* *`v_education`*
* *`v_groups_from_mandates`*
* *`v_mariage`*
* *`v_membership`*
* *`v_person_birth`*
* *`v_same_as`*
* *`v_sphere_academique`*
* *`v_sphere_administrative`*
* *`v_sphere_economique`*
* *`v_sphere_militaire`*
* *`v_sphere_politique`*
* *`v_sphere_presse`*
* *`v_sphere_sociabilite`*

&nbsp;

---

Go back to [Documentation](index.md)