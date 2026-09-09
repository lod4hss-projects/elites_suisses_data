# Inspection of the Original Table: ***`entites`***

The ***`entites`*** table is the main table in the Élites suisses database, where information on organisations, institutions and other group-like entities are stored as entities.

This table is referenced to via foreign key from other tables in the database, that is the ***`education`*** table (e.g. obtaining a study title from an educational institution) and the ***`mandat`*** table (e.g. holding a specific role position in a company, association or political party). For unknown reasons, two different keys are used for this purpose: `id`references to the ***`education`*** but not to the ***`mandat`*** table. Vice versa, `idEntite` references to the ***`mandat`*** table but not to ***`education`***.

There are columns in other tables in the database that hold information on organisations, but store them as *strings* and not as *identified entities* (see [this page](organisations.md) for an overview). In many cases, a link to the ***`entites`*** table is not provided.

&nbsp;

## Related Documents

* SQL script for data inspection, basic data cleaning and consistency check: [groups_entities_exploration.sql](../database_inspection/groups_entities_exploration.sql)
* SQL script for inscpeting entity types (column `typeEntite`): [groups_entities_types.sql](../database_inspection/groups_entities_types.sql)
* Documentation on name variants and language-specific variants of entities in the original [***`autresNomsEntites`***](organisations_autresNomsEntites.md) table
* Documentation on the new [***`t_group`***](organisations_groups.md) table and on the additional tables [***`t_group_appellation`***](organisations_groups_appellations.md), [***`t_group_type`***](organisations_groups_types.md) and [***`t_group_follower`***](organisations_groups_follower_partof.md)

&nbsp;

## Description of the Data

The table consists of 23 columns with 3554 rows containing various types of organisations across different spheres (see [distribution of spheres and entity types](#distribution-of-spheres-and-entity-types) below).

Relevant columns include the following information for characterising an organisation (if available):

* Organisational sphere (`sphere`)
* Organisation type (`typeEntite`)
* Name of organisation (`nom`)
* Seat or location (local: `siege`, canton: `siegeCanton` or country: `pays`)
* Foundation year/date (`dateCreation`)
* Dissolution year/date (`dateDisparation`)
* Scope of an organisation (national, cantonal, municipal or international level) (`echelle`)
* Foundation place (local: `creationLieu` or cantonal level: `creationCanton`)

&nbsp;

## The ***`entites`*** Table

| Column Name | Data Type | Description | Mapping |
|-------------|-----------|-------------|---------|
| `sysid` | integer | MySQL export related id |  |
| `id` | integer | Internal id (FileMaker?). We use this identifier in the foreign key management of all the existing data referencing to organisations as it is also used by the project for the entity identification in the ***`education`*** table (but not in the ***`mandat`*** table, where `idEntite` is used instead). |  |
| `idEntite` | character varying | Semi-semantic identifier to mandates but not education. It is also used for referencing entities on the Élites suisses website (e.g. https://elitessuisses.unil.ch/e/entite27) |  |
| `sphere` | character varying | This column references the field in which an entity is rooted, e.g. politics, economoy, research etc. (see [distribution of spheres and entity types](#distribution-of-spheres-and-entity-types) below). It is also present in the ***`mandat`*** table. | <font color="red"> Is the information in "idEntite" in the entites and the mandat tables the same? </font> |
| `typeEntite` | character varying | Type of entity. It has a variable meaning depending on the `sphere` (e.g. in the academic sphere, it is mostly about types of organisations, where in the philantropic sphere it narrows down the field of activity of philantropic organisations, see [distribution of spheres and entity types](#distribution-of-spheres-and-entity-types) below). |  |
| `nom` | character varying | Name of entity (organisations and institutions). In addition to this column, the column `Institution` in the ***`education`*** table as well as to the columns `entite`, `organe` and `partiAffiliationOfficeSecteur` in the ***`mandat`*** table contain names of entities, which are organisations and institutions. |  |
| `siege` | character varying | Seat of entity (organisations and institutions). <br><font color="red">"Siège" probably means the (current) seat of an organisation, which may or may not be the same as the place the organisation was founded (see `creationLieu` and `creationCanton`)</font> | See [documentation on geographical places](t_geo_place.md) |
| `siegeCanton` | character varying | Canton of entity (organisations and institutions). <br><font color="red">"Siège" probably means the (current) seat of an organisation, which may or may not be the same as the place the organisation was founded (see `creationLieu` and `creationCanton`)</font> | See [documentation on geographical places](t_geo_place.md) |
| `pays` | character varying | Country of entity (organisations and institutions) | See [documentation on geographical places](t_geo_place.md) |
| `dateCreation` | character varying | Foundation year or date of an entity (organisation and institution) |  |
| `dateDisparition` | character varying | Dissolution year or date of an entity (organisation and institution) |  |
| `choixLogo` | character varying | Identifier probably to select different logo versions stored in the backend |  |
| `DHS` | character varying | URL to the DHS/HLS <br><font color="red">Is there an indirect link to the identifier table, i.e. an overlap of URLs to DHS/HLS in this table and in the identifier table? Or apply the linked resources in the identifier only to persons?</font> |  |
| `DHS_versionAuteur` | character varying | <font color="red">Is empty? => check!</font> |  |
| `affiliationSecteurType` | character varying | Depending on sphere and typeEntite denoting the economic sector or entity type | <font color="red">Needs to be analysed in cooccurrence with sphere, typeEntite and nom; there might be some implicit entities inside</font> |
| `echelle` | character varying | The scope, level or reach of an entity's field of activity, i.e. national ("Fed"/"FED"), cantonal ("Cant"), municipal ("Comm") or international ("Int"/"Inter"). Some fields are emtpy. |  |
| `creationLieu` | character varying | Foundation place of entity | See [documentation on geographical places](t_geo_place.md) |
| `creationCanton` | character varying | Foundation canton of entity | See [documentation on geographical places](t_geo_place.md) |
| `nbrMandats` | integer | Aggregated number of associated mandats (whole of database) |  |
| `nbrMandatsZH` | integer | Aggregated number of associated mandats in the canton of Zurich |  |
| `nbrMandatsGE` | integer | Aggregated number of associated mandats in the canton of Geneva |  |
| `nbrMandatsBS` | integer | Aggregated number of associated mandats in the canton of Basel-City |  |
| `versionDate` | date | Internal version date in the format DD.MM.YYYY |  |

&nbsp;

## Distribution of Spheres and Entity Types

The distribution of spheres and entity types in this table shows the variety of entities to which persons in the Élites suisses database are associated. These are mostly independent organisations or sub-organisations of the academic, administrative, economic, political, philantrophic and sociability spheres.

The following table shows that the entity types, which are recorded as strings in the `typeEntite` column, are partly semantical concepts for differentiating various sub-fields of the respective sphere they are attributed to (e.g. an entity from the field of academic "Enseignement", an entity that operates within the field of "Recherche", a philantropic institution of the field "II. Vieillesse, maladie, accidents, hygiène", and so on). For transforming the database into LOD, the entities need to be attributed to actual organisation types, such as "Higher education institution", "Association", "Enterprise", "Academic society" and so on. Some entity types to already meet these requirements (e.g. a political party or a Federal Office). The original information in 'typeEntite`can be kept for reference or analysis purposes.

It is evident, that some entities may not be organisations in a narrower sense, such as the academic prizes (although also these have an organisation in the background). It will have to be decided, whether the fact that a person has won the Nobel Prize is modeled as "Receiving a prize" (with the entity in this table being the Nobel Prize itself) or as "Receiving a prize from the Nobel Foundation" (with the entity in this table being the Nobel Foundation).

Also evident from the glimpse in the data is that some data cleaning could to be done on the names (e.g. transform "BNS" to "Banque Nationale Suisse (BNS)" for better readability).

| `sphere` | `typeEntite` | `nom` (example/s) | N |
|---|---|---|---:|
|  |  | Verein für das Schweizerische Sozialmuseum | 1 |
|  | Prix/Distinction | Prix Nobel; Médaille Albert-Einstein; ... | 8 |
| Académique | Administration | Conseil des écoles polytechniques fédérales | 1 |
| Académique | Association | Académie suisse des sciences naturelles; Association Suisse des Enseignants d'Université; ... | 8 |
| Académique | Enseignement | UniNe; IDHEAP; University of Cambridge; ... | 842 |
| Académique | Prix/Distinction | Prix Leenaards; Prix Cloetta; Werner Preis | 3 |
| Académique | Recherche | Fonds national suisse de la recherche scientifique; Conseil suisse de la science et de la technologie; Commission suisse d'étude pour l'énergie atomique; Commission pour la technologie et l'innovation CTI; Commission pour la science atomique | 5 |
| Administrative |  | Comm. extra-parl | 1 |
| Administrative | Autorités judiciaires | Tribunal fédéral | 1 |
| Administrative | BNS | BNS | 1 |
| Administrative | Comm. extra-parl | Commission pour le service alpin; Croix Rouge Suisse; Conseil de direction; Office fédéral de conciliation en matière de conflits collectifs du travail; Groupe de travail: "Politique structurelle"; ... | 653 |
| Administrative | Département fédéral | DFAE; Chancellerie; DFI; DFJP; DDPS; DFF; DFE; DETEC | 8 |
| Administrative | Office fédéral | Caisse nationale suisse; Office fédéral de la statistique; Bibliothèque nationale suisse; Musée national suisse; Commissariat central des guerres ... | 112 |
| Economique | Association | Société suisse des fonctionnaires postaux SSFP; Syndicat suisse des mass media SSM; Union fédérative UF; PTT+Douanes; ... | 81 |
| Economique | Entreprise | Steckborn Kunstseide; Ciba; Banque cantonale du Tessin (Banca Stato); Pictet & Cie; Camille Bloch; Zurich Assurances; Fonderie Boillat SA; BCSG; ... | 503 |
| Militaire | Militaire | EMG | 1 |
| Philanthropie | Annexes | Association du sou pour les œuvres de relèvement; Association du sou pour l'évangélisation de la France; Association chrétienne évangélique; Comité central international des Unions chrétiennes de jeunes gens; Comité de la mission intérieure; ... | 47 |
| Philanthropie | III. Instruction | Ecole ménagère de Carouge; Société de l'enseignement libre; Caisse de subsides pour les étudiants genevois du Gymnase et de l'Université; Commission des fonds universitaires; Comité de patronage des étudiants étrangers; Bureau de renseignements généraux et d'éducation; Asiles de l'enfance à Plainpalais; ... | 52 |
| Philanthropie | II. Vieillesse, maladie, accidents, hygiène | Asile Magnenat à Carouge; Asile pour vieillards français; Comité Tronchin de secours pour les vieillards; Hôpital cantonal; Maternité; ... | 102 |
| Philanthropie | I. Philanthropie et bienfaisance | Hospice général; Caisse de police; Rapatriements, voyages à prix réduits; Stations de secours pour voyageurs nécessiteux; Fondation Lissignol; ... | 41 |
| Philanthropie | IV. Education et moralisation | Comité de patronage pour buveuses de l'Asile de Béthesda; Soirées familières de tempérance; Secrétariat Anti-alcoolique suisse; Cafés-chocolat et cafés de tempérance; Société d'activité chrétienne de jeunesse; Salle du dimanche ... | 142 |
| Philanthropie | VI. Economie domestique | Société pour l'amélioration du logement; Association coopérative immobilière; Le Foyer; Société genevoise des logements hygiéniques; Maisons ouvrières et logements hygiéniques; Logements salubres (Fondation des); ... | 24 |
| Philanthropie | VII. Prévoyance, Assurance et Secours mutuels | La Prévoyance des Eaux-Vives; Association pour les vêtements d'hiver à Carra (Presinges); Société de retraite pour la vieillesse; Société de secours mutuels aux orphelins; ... | 146 |
| Philanthropie | V. Travail | Classes professionnelles dans les écoles publiques; Bureau de garde-malades; Ouvroir des Eaux-Vives; Caisse publique de prêts sur gages; ... | 32 |
| Politique | Assemblée Féd. | Conseil des Etats; Conseil national | 2 |
| Politique | Autorités cant. | BE; TI; VD; ZH; ... | 26 |
| Politique | Autorités comm. | Aarau; Aarwangen; Adelboden; Adliswil; ... | 431 |
| Politique | Commission parlementaire | Politique de sécurité CE; Politique de sécurité CN; Environnement, aménagement du territoire et énergie CE; Environnement, aménagement du territoire et énergie CN; ... | 24 |
| Politique | Conseil Féd. | Conseil fédéral | 1 |
| Politique | Constituante | VD Constituante; ZH Constituante; AR Constituante; SO Constituante; ... | 13 |
| Politique | Parti politique | Union démocratique du centre; Parti politique [`affiliationSecteurType` = "Cant"]; Parti politique [`affiliationSecteurType` = "Comm"]; Parti démocrate-chrétien (PDC); Parti socialiste suisse; ... | 99 |
| Politique-Sociabilité | Autorités comm. | Bâle (commune bourgeoise) | 1 |
| Sociabilité |  | Association des intérêts de Genève | 1 |
| Sociabilité | Lieux de sociabilité | Alliance de Sociétés Féminines Suisses; ASIN; Association Olympique Suisse; Automobile Club de Suisse (ACS); British Chamber of Commerce for Switzerland; Caritas; ... | 141 |
|  |  |  |  |
|  |  |  | **3554** |
&nbsp;
