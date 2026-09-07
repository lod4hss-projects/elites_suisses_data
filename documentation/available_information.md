# Semantic Analysis and Mapping of the Database Tables

We recreated an ERD representing the original tables along with the new ones created as part of the LESSH project. It is [available here](../documentation/graphics/ERD_with_new_tables.png) and documented [in this file](../documentation/graphics/ERD_with_new_tables.md).

&nbsp;

## Original Tables

The following tables were delivered by the Élites suisses project to be transformed as part of the LESSH project:

| Source Table | Concept | Content | Mapping | Documentation |
|--------------|---------|---------|------------------|---------------|
| ***`identite`*** | Persons | Rows represent persons. | primarily instances of the CIDOC CRM E21 Person class | [Data inspection and structure](information_analysis/identite.md) |
| ***`identifier`*** | Links | Rows represent relations to other identifiers or to webpages about the same persons. |  | Data inspection and structure on [sameAs relations](information_analysis/same_as_relations.md) and [identifiers](information_analysis/identifier.md) |
| ***`filiations`*** | Parents | Rows represent relations to parents. |   | [Data inspection and structure](information_analysis/filiations.md) |
| ***`mariage`*** | Marriage | Rows represent marriages. |   | [Data inspection and structure](information_analysis/marriage.md) |
| ***`education`*** | Education | Rows represent educational phases (studies and degrees). |   | [Data inspection and structure](information_analysis/education.md) |
| ***`entites`*** | Organisations | Rows represent organisations of different kinds. | Instances of the CIDOC CRM E74 Group class | [Data inspection and structure](information_analysis/organisations.md) |
| ***`autresNomsEntites`*** | Organisations - Labels | Additional table to the organisations table, containing labels for the same organisations |  | See link above |
| ***`mandat`*** | Mandates | Rows represent a bundle of different informations about social roles, memberships and prizes. | Instances of the [C13 Social Role Embodiment](https://ontome.net/class/697) class, but also information about Memberships, Prizes, etc. is present in the data | This table demands a thorough inspection and discussion. This is **[the access page](information_analysis/mandates_general_inspection.md) to the whole documentation of this process** where we provide links to the sub-pages. |

&nbsp;

## New tables

In addition to the original tables, new tables allow for creating additional entities and associating the original text values in the source tables to these entities.

The following tables were newly created for transforming the database:

* ***`t_education_cleaning_up`*** (Education - cleaned, replaces the former ***`education`*** table)
* ***`t_gender`*** (Gender)
* ***`t_geo_place`*** (Geographical Place)
* ***`t_geo_place_kind`*** (...)
* ***`t_geo_relation`*** (Relation of Person and Place)
* ***`t_group`*** (Organisation/Group, replaces the former ***`entites`*** table)
* ***`t_group_appellation`*** (Organisation/Group Naming Variant, replaces the former ***`autresNomsEntites`*** table)
* ***`t_group_follower`*** (Following Organisation/Group)
* ***`t_group_type`*** (Organisation/Group Type)
* ***`t_mandates_cleaning_up`*** (Mandates - cleaned, replaces the former ***`mandat`*** table)
* ***`t_person_place`*** (...)
* ***`t_social_relationship_type`*** (Social Relationship Type)
* ***`t_social_role`*** (Social Role)
* ***`t_study_discipline`*** (Study Discipline)
* ***`t_study_title`*** (Study Title/Degree)

<font color="red">* maybe add links // t_education_cleaning_up needs to be created</font>

See also the [extended ERD](../documentation/graphics/ERD_with_new_tables.png) for a conceptual representation as well as the [comment to it](../documentation/graphics/ERD_with_new_tables.md).

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