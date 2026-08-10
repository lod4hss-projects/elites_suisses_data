
# Information about the table `identite`

This table, called "identite", primarily documents instances of the class [`crm:E21 Person`](https://ontome.net/class/21) and information related to them, as well as metadata on how information has been entered (author, date, etc.).

The table contains 58729 entries (see here the [SQL scripts](../database_inspection/sh_identite_inspection.sql))

This table contains the fields listed below. Either the fields need to be transformed in the graph, and a documentation page is linked, or a note mention why it is not transformed.

| Column Name | Description | Data transformation |
|-------------|-----------|-----------|
| sysid | Internal identifier, linked to the table "identifier" | Not to transform, as it is redundant with id |
| id | Unique ID of the person | Documented in the URI. [URI documentation](https://github.com/lod4hss-semantics/SDHSS-modelling-best-practices) |
| nom | Last name of the person | [Person Appellations](../information_analysis/person_appellation.md) |
| prenom | First name of the person | [Person Appellations](../information_analysis/person_appellation.md) |
| naissance | Date of birth (with a lot of inconsistencies) | [Person Birth and Death](person_birth-death.md) |
| mort | Date of death (with a lot of inconsistencies) | [Person Birth and Death](person_birth-death.md) |
| nbrMandats | String. This should be calculated | Not documented (calculated if needed) |
| cantonNaissance | The canton in code ("XY"), with "Étranger" when outside of Switzerland | [Person Birth and Death](person_birth-death.md) |
| DHS | The link to the DHL. It seems redundant with the table "identifier" | Not to transformed as it is redundant with the identifier table. See [identifier documentation](../information_analysis/same_as_relations.md) |
| formationDoctorat | "Oui", "Non", "Indé" or nothing. This should be calculated | Not documented (calculated if needed) |
| formationUniversitaire | "Oui", "Non", "NA", "yes", "x" or nothing. This should be calculated | Not documented (calculated if needed) |
| gradMilitaireMax | This documents the hights grade an individual got. It needs to be cleaned eavily | [Person Military Grade](../information_analysis/person_military-max.md) |
| lieuNaissance | The place of birth | [Person Birth and Death](person_birth-death.md) |
| nationalite | The nationality of the person. Some individuals have multiple nationalities (usualy with a "et" between them) | [Person Nationality](../information_analysis/person_nationality.md) |
| profession | This is a textual field summerizing the role of the person, but this field is sometimes inconsistent with the mandates table | [Person Profession](../information_analysis/person_profession.md) |
| sexe | This field documents the gender of persons | [Person Gender](../information_analysis/person_gender.md) |
| sourcesBio | Sources used for documenting infromation about the person | [Person Sources](../information_analysis/person_sources.md) |
| sourcesFormations | Sources used for documenting infromation about the formation of the person | [Person Sources](../information_analysis/person_sources.md) |

The fields that ar not mentioned here:
- confidentiel: Empty field
- confidentiel_naissance: only two instances of "OUI", for person `70583` and `60663`.
- choixPhoto: Number from 1 to 3. This should not be documented in the graph
- saisie: to document in the graph?
- creation: to document in the graph?
- versionDate: to document in the graph?

## Some examples

* [Cavadini-Bauer, Jean](https://elitessuisses.unil.ch/p/50039)