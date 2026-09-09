# Inspection of the Original Table: ***`autresNomsEntites`***

This table contains language labels and naming variants of <font color="red">many / all / most?</font> identified entities in the ***`entites`*** table. It is linked to said table via `idEntite` as foreign key, which is also used as identifier to compose the URL for the entity page on the Élites suisses website (where these naming variants are also listed).

&nbsp;

## Related Documents

* SQL script for data inspection: <font color="red">[none so far]</font>
* Documentation on the [***`entites`***](organisations_entites.md) table to which this table is linked via a foreign key
* Documentation on the new [***`t_group_appellation`***](organisations_groups_appellations.md) table derived from this table
* See also [overview page](organisations.md) on organisations

&nbsp;

## Description of the Data

The table consists of 6374 rows, with each row representing a variant or alias of an entity's name. As with the ***`entites`*** table (described [here](organisations_entites.md)), the entities represented in this table are predominantly organisations.

The table is conceived as a simple vocabulary of entity names. It contains both name variants (i.e. aliases) and language-specific variants or labels for the same entity, as can be seen in the examples below.

**Some examples:**

| `id` | `idEntite` | `autreNom` |
|-----:|------------|------------|
| 169 | entite155 | Hypo Winterthur |
| 1951 | entite155 | Hypothekarbank in Winterthur |
| 4879 | entite155 | Banque hypothécaire de Winterthour |
| 5148 | entite155 | Hypothekar Bank in Winterthur |
| ... | ... | ... |
| 339 | entite336 | ZH |
| 860 | entite336 | Zurich |
| 861 | entite336 | Zürich |
| 1897 | entite336 | Conseil d'État zurichois |
| 4828 | entite336 | Grand Conseil Zurich |
| 4855 | entite336 | Kantonsrat Zürich |
| ... | ... | ... |
| 4626 | entite3263 | Fabrique Solvil des Montres Paul Ditisheim, Société Anonyme |
| 4627 | entite3263 | Fabrique des Montres Solvil et Titus S.A. |
| 4979 | entite3263 | Solvil et Titus |
| ... | ... | ... |
| 3156 | entite2692 | UniBa |
| 4019 | entite2692 | Université de Bâle |
| 4020 | entite2692 | Universität Basel |
| 4021 | entite2692 | UniBas |
| 4133 | entite2692 | University of Basel |

For organisations in the "classical" sense, the content and structure of the table are quite straightforward and generally unproblematic.

As the example of Zurich shows, different types of entities are sometimes conflated and associated with the same entity (cf. `idEntite`). In this case, "ZH" appears to refer to the canton of Zurich, while "Zurich" and "Zürich" are language-specific variants of – presumably – the municipality of Zurich. The same entity is also associated with the cantonal executive ("Conseil d'État") and legislative bodies ("Grand Conseil" or "Kantonsrat").

Some data cleaning is therefore required. It is expected, however, that most organisation types follow the straightforward principle of one `idEntite` per factual entity.

&nbsp;

## The ***`autresNomsEntites`*** Table

| Column Name | Data Type | Description | Mapping |
|-------------|-----------|-------------|---------|
| id | integer | Internal id of naming variant. This is the primary key of the table. |   |
| autreNom | character varying | Name variant (alias) or language-specific variant of an identified entity.  |   |
| idEntite | character varying | Identifier that points to the entity in the ***`entites`*** table (foreign key). |   |
| zkp | character varying | Unknown identifier in the format "NomEntite#" (e.g. NomEntite3301), whereby the attached number is not associated with any other identifier in the database |   |
| modif | timestamp without time zone | Modification date (last modified) in format DD.MM.YYYY hh:mm |   |
| entite_id | integer | The number used in the unknown `zkp` identifier. <br><font color="red">Was this already present in the original database?</font> |  |

&nbsp;

## Decisions

The original table is to be reproduced in a revised form to provide cleaner data and better handling of language-specific and time-dependent name variants, as well as a clearer description of the identified aliases of each entity. It is called [***`t_group_appellation`***](organisations_groups_appellations.md).

This new table is to be linked with the new [***`t_group`***](organisations_groups.md) table that replaces the original [***`entites`***](organisations_entites.md) table.

&nbsp;

---

Go back to [Inspection of the Original Table: ***`entites`***](organisations_entites.md)<br>
Go back to [Organisations](organisations.md)