# Documentation of data cleaning and reconciliation using OpenRefine – *internal version*

This document describes the standard procedure of how the instances of the entity types used in the élistessuisses database (esdb) were cleaned and reconciled with entities from the wikidata knowledge base [or other knowledge sources, for that matter].

The following esdb entity types were processed as follows:

* Conseil fédéral (1)
* Assemblée fédérale (2)
* Autorités cantonales – exécutives et législatives (52)
* Cantons (26)
* Universités (485)
* ...

## Standard process for data cleaning and reconciliation using OpenRefine

OpenRefine version used: 3.10.1 [TRUNK]

Conventions used in this documentation to describe the different actions:

* "cases" = rows
* "fields" = columns
* <field_name> = name of field/column
* => "Menu command" => "Sub-menu command"

Applied on all cases:

1. Check for empty cells in mandatory fields
2. Create a copy of relevant column(s) to be cleaned and reconciled
    * <..._cleaned> = cleaned version
    * <..._reconciled> = reconciled version

Applied on all cases separately for each <fk_group_type>:

3. Reconcile cell against wikidata type [XY] in field <..._reconciled>, with auto-match disabled (see next section for more information on which wikidata entities were used for reconciliation)
4. Manually check and match each cell, flag uncertain cases or cases that were not found in the wikidata base
5. Extract wikidata Q-ID for reconciled cells and record it into <wikidata_gid> via => "Reconcile" => "Add entity identifiers column..."
6. Check for duplicates and empty cells in <wikidata_gid>

Applied on all cases:

7. Create <wikidata_uri_rec> from <wikidata_gid> via => "Edit column" => "Add column based on this column..." using the following GREL expression (the quotation marks have to be included for the syntax to work):
    >> "http://www.wikidata.org/entity/"+value
8. Fill the empty cells in <wikidata_uri> (= target column) from the data recorded in <wikidata_uri_rec> via => "Edit cells" => "Transform..." using the following GREL expression:
    >> if(isBlank(value), row.cells["wikidata_uri_rec"].value, value)
9. Check for empty cells in <wikidata_uri>

## Notes on reconciliation with wikidata

| fk_group_type | wikidata | matching mode |
| :--- | :--- | :--- |
| 1 | Instances of class "Council of State": https://www.wikidata.org/wiki/Q665565 | strict |
| 2 | Instances of class "canton of Switzerland": https://www.wikidata.org/wiki/Q23058 | strict |
| 3 | Instances of class "cantonal legislatures of Switzerland": https://www.wikidata.org/wiki/Q667186 | strict |
| 4 | search for individual entitie(s) | manual |
| 5 | search for individual entitie(s) | manual |
| 6 | Instances of class "Higher Education Institutions": https://www.wikidata.org/wiki/Q38723 | loose |

Notes on matching mode:

* strict: All cases are matched to instances of the same wikidata entity
* loose: Instances of a wikidata entity are used as a starting point for reconciliation (optimal match ratio expected), while some are matched manually
* manual: Entities are matched manually to individual wikidata entities

## Log, notes and to dos

### Log

* 6.7.26: Finish reconciling "groups", document unclear cases
* 4.7.26: Set up markdown for documentation
* 3.7.26: Exchange with Stephen on reconciliation process and documentation requirements
* 1.7.26: Testing out OpenRefine, setting up reconciliation process, start reconciling "groups"
* 30.6.26: "Kick-off" meeting

### crm_group_202606301146.csv

General notes:

* Flagged items need further check (i.e. to discuss with the team)
* Starred items represent former variations of groups that were replaced by newer ones

List of actions needed:

* Check empty cell in <fk_source_entity> for <pk_crm_group> "80"
* Add proper labels / complete data in wikidata:
    * "Standeskommission Appenzell Innerrhoden" https://www.wikidata.org/wiki/Q98496837 (instance of class "Council of State": https://www.wikidata.org/wiki/Q665565)
    * Add a proper label for "Escuela Normal de Madrid" (Ecole normale supérieure de Madrid) https://www.wikidata.org/wiki/Q61054282
    * "Schweizerisches Institut für Unternehmerschulung (SIU)" https://www.wikidata.org/wiki/Q64690675
* Is "Ciba" (<pk_crm_group> "460") a group or even a place to study?
* What is "Fribourg"? - see <pk_crm_group> "525"
* Do we miss <pk_crm_group> "497"?
* Create new wikidata entities:
    * <pk_crm_group> "339"
    * <pk_crm_group> "340"
* Matching institutions:
    * 105 "Université catholique de Louvain" and 410 "Katholieke Universiteit Leuven"
    * 106 "Université de Strasbourg", 291 "Université de Strasbourg III (Robert Schuman)", 418 "Université de Strasbourg I (Louis-Pasteur)" (Strasbourg II is missing) => see comment above
    * 162 "Université de Grenoble", 177 "Université Grenoble II (Pierre Mendès-France) & 294 "Université Grenoble I (Joseph-Fourier)"

Inconsistencies:

* Some entities of the Universités type in the esdb have existed only within a certain time period. For example, the "Technische Hochschule Berlin" has been created in 1879 and has been replaced by the "Technische Universität Berlin" in 1946, which exists until today. Usually, both entities can be found in the esdb. Also, there are usually multiple entities in the wikidata base that correspond to these entities.
* There are exceptions and inconsistencies, however:
    * Sometimes, only one of the university variants was actually assigned persons to in the esdb.
        * For example, the entity [Technische Hochschule Berlin](https://elitessuisses.unil.ch/e/entite3642) is empty, while [Technische Universität Berlin](https://elitessuisses.unil.ch/e/entite2739) contains persons that have studied even when this institution hasn't formally existed yet (i.e. at the time, when the institution was called "Technische Hochschule Berlin"). The corresponding wikidata entities are https://www.wikidata.org/wiki/Q17403358 and https://www.wikidata.org/wiki/Q51985, respectively.
        * This "mistake" (?) in the esdb can be observed with many other institutions as well. For example, comapring "Universität Erlangen-Nürnberg" and "Universität Erlangen", we see that all persons were assigned to the former (in this case the newer), institution.
    * Sometimes, the study period of one or multiple individual(s) that have assigned to this type of institution exceeds the existence of this institution. Example: [Université de Montpellier](https://elitessuisses.unil.ch/e/entite3515)
    * In some rare cases, the esdb is agnostic of variants.
        * For example, there are two wikidata entries for "Université libre de Bruxelles" (one [pre 1970](https://www.wikidata.org/wiki/Q20754971) and one [post 1970](https://www.wikidata.org/wiki/Q574606)) but only one entry in esdb: https://elitessuisses.unil.ch/e/entite2881
    * Not all esdb entities are found in the "groups" list:
        * "Université de Strasbourg II (Marc Bloch)", see https://elitessuisses.unil.ch/e/entite3478
        * "Université d'Aix-Marseille" and" Université d'Aix-Marseille I", see https://elitessuisses.unil.ch/recherche.php?q=marseille
        * "Université Paris VIII (Vincennes)", see https://elitessuisses.unil.ch/e/entite2912
        * "Université Grenoble III (Stendhal)", see https://elitessuisses.unil.ch/e/entite2936
        * "Université Nancy II", see https://elitessuisses.unil.ch/e/entite2933
        * "Université Lyon I (Claude Bernard)", see https://elitessuisses.unil.ch/e/entite3236
        * "Université du Québec à Montréal", see https://elitessuisses.unil.ch/e/entite2783
        * "Université Montpellier 1", "... 2" & "... 3", see https://elitessuisses.unil.ch/recherche.php?q=montpellier
    * Sometimes, there exist a plurality of variants of an institution. Accordingly, not only is matching with wikidata difficult but also the error rate of false assignements of persons to institutions rises (as shown above).
        * An extreme case is the University of Strasbourg, which was separated in 1970 into three subtypes (all for which wikidata entities exist), which were reunited again in 2009 into one single university. Wikidata contains therefore five separate entities of this institution, while the esdb is missing the newest (2009-) type. This applies on the structural level. On the level of instances, we find that in the esdb most of the persons were assigned to the oldest variant of this institution, including also persons that studied when the the institutions were already separated. We find a few in Strasbourg I, none in Strasbourg II and quite a few in Strasbourg III.
        * Another extreme case is the University of Paris. The former "Sorbonne" was split up into 13 different universities from the 1970s, of which some have later been reunited.

Some further questions:

* Is the esdb still maintained or do we work with what we have/find?
* How do we deal with the inconsitencies in the esdb? For example, how do we solve the problem that in some cases, only one variant was actually used to assign people to, while in other cases all variants were used? Unfortunately, we cannot say, that only to the older or to the newer institution variant was used.
* Regarding the variants "not in use": Are there any types that link to the "empty" entities, other than persons?
* Regarding the missing entities in the "groups" list: is there a systematic behind this?
* Generally: would it be possible to match all variants of an institution to only one single wikidata entity? And if so, to which one? (This would require to identify all the institutions that have a common history. Where do we draw the line between one institutions and another?)
    * For example: To which wikidata entity should we match the main "Université de Strasbourg" entity in the esdb? To the [older one](https://www.wikidata.org/wiki/Q20808141) or to the [newest one](https://www.wikidata.org/wiki/Q157575)? Here is the query for listing all types in the esdb: https://elitessuisses.unil.ch/recherche.php?q=strasbourg
    * How do we deal with all the University colleges, ... institutes, ... departments, ... faculties, xy schools? For example Harvard College, Harvard Law School, Harvard Business School; Toulouse school of economics (École d'économie de Toulouse), which is a school within "Toulouse 1 University Capitol" ([wikidata](https://www.wikidata.org/wiki/Q3532921), [esdb](https://elitessuisses.unil.ch/e/entite3895), see [all Touulouse entities](https://elitessuisses.unil.ch/recherche.php?q=toulouse) in the esdb); [Bryant University, College of Business](https://elitessuisses.unil.ch/e/entite3869); Max-Planck-Institut ...
