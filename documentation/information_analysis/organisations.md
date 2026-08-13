# Organisations

The organisations are treated in the Elites Suisses database partly as identified entities, in the *entites* table, and partly as strings, notably in the *organe* and *partiAffiliationOfficeSecteur* table. In the transformation process to LOD, which implies a logic *from strings to things* all organisations are to be identified so that they can be associated using their URIs to relevant facts.



## *entites* and *autresNomsEntites* table

[This page](organisations_entites_table_inspect.md) documents the *entites* and *autresNomsEntites* tables.



| Column Name | Data Type |   Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| id | integer |   |   |   |
| idEntite | character varying |   |   |   |
| sphere | character varying |   |   |   |
| typeEntite | character varying |   |   |   |
| nom | character varying |   |   |   |
| siege | character varying |   |   |   |
| siegeCanton | character varying |   |   |   |
| pays | character varying |   |   |   |
| dateCreation | character varying |   |   |   |
| dateDisparition | character varying |   |   |   |
| choixLogo | character varying |   |   |   |
| DHS | character varying |   |   |   |
| DHS_versionAuteur | character varying |   |   |   |
| affiliationSecteurType | character varying |   |   |   |
| echelle | character varying |   |   |   |
| creationLieu | character varying |   |   |   |
| creationCanton | character varying |   |   |   |
| nbrMandats | integer |   |   |   |
| nbrMandatsZH | integer |   |   |   |
| nbrMandatsGE | integer |   |   |   |
| nbrMandatsBS | integer |   |   |   |
| versionDate | date |   |   |   |

&nbsp;





## autresNomsEntites
| Column Name | Data Type | Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| id | integer |   |   |   |
| autreNom | character varying |   |   |   |
| idEntite | character varying |   |   |   |
| zkp | character varying |   |   |   |
| modif | timestamp without time zone |   |   |   |
| entite_id | integer |   |   |   |

&nbsp;
