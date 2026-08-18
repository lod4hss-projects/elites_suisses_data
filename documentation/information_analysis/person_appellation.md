# Information of the appellation of persons

## Information analysis

The appellation of a person is documented in two fields in the `identite` table: `nom` and `prenom`. Both fields are only strings and they don't always follow the same rules. Here are some examples:

| id | nom | prenom |
|----|----|----|
| 50614 | Krauer | Alex (Alexander) |
| 50643 | Aubert | Henri (Henry Louis) |
| 50650 | Bauer | Ernest (ou Ernst) |
| 50653 | Bodmer-Zoelly | Hans Conrad |
| 50757 | Nauer | Wilhelm 2 |
| 61181 | Serex | Ph. |
| 75694 | Blonay, de | Octavie |
| 101858 | de la Fléchère | Emma Rosalie Julie |
| 100334 | Müller | E. 2 |

The number beside the last name suggest that it was at some time incorporated to distinguish individuals only by their name.

Number of empty cells (ith a value `NULL` or with the trimed value "":

|  | nom | prenom |
|----|----|----|
| number of empty cells | 0 | 222 |

see here the [SQL scripts](../database_inspection/sh_person_appellation.sql).

## Mapping

There are two ways of documenting the name of an individual:
- Join the first and last names in a new Name field
- Keep the distinction between the first and the last name

The first option is easier to manage, as only one field is used to document the full name of an individual. A rule like "`nom`, `prenom`" can be use to distinguish first to last names.

Then, two mapping option can be chosen:
- With a simple property from the person to the string of the name
- With the [`sdh:C11 Appellation in a Language`](https://ontome.net/class/365) class, that allows to document the Type of appellation as well as the Language.

The second option of distinguishing the first and last name can only be documented with the [`sdh:C11 Appellation in a Language`](https://ontome.net/class/365) class, where "First name" and "Last name" would be instances of the class [`sdh:C12 Appellation in la Language Type](https://ontome.net/class/630).

## Decision

It was decided, for the moment, to concatenate the first and last name in a new `name_forename` field, follwoing the rule "`nom`, `prenom`".

The transformation script is documented [here](../database_inspection/sh_person_appellation.sql).

Then, the mapping is done with the simpler [`sdh-shortcut:P9 has standard label`](https://ontome.net/property/3201) from the person to the string of the appellation.

![Person appellation model](../graphics/person_appellation.png)

It was also decided not the clean the way name have been documented.