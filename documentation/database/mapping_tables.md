
# Semantic Analysis and Mapping of Tables 

&nbsp;

## "identite" - Persons


Rows in this table represent persons.

They correspond to instances of the CIDOC CRM E21 Person class.

Available information about them:


| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| id | integer |   |   |   |
| nom | character varying |   |   |   |
| prenom | character varying |   |   |   |
| naissance | character varying | [Birth Dates](../information_analysis/persons.md#birth-dates)  |   |   |
| mort | character varying |   |   |   |
| nbrMandats | character varying |   |   |   |
| cantonNaissance | character varying |   |   |   |
| confidentiel | character varying |   |   |   |
| confidentiel_naissance | character varying |   |   |   |
| DHS | character varying |   |   |   |
| choixPhoto | character varying |   |   |   |
| formationDoctorat | character varying |   |   |   |
| formationUniversitaire | character varying |   |   |   |
| gradeMilitaireMax | character varying |   |   |   |
| lieuNaissance | character varying |   |   |   |
| nationalite | character varying |   |   |   |
| profession | character varying |   |   |   |
| saisie | character varying |   |   |   |
| sexe | character | [Gender](../information_analysis/persons.md#gender)  |   |   |
| sourcesBio | text |   |   |   |
| sourcesFormations | text |   |   |   |
| creation | character varying |   |   |   |
| versionDate | date |   |   |   |

&nbsp;


### identifier
| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| zkf_ID_linked | integer |   |   |   |
| Identifier_code | character varying |   |   |   |
| Identifier | character varying |   |   |   |
| 

&nbsp;

### education
| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| zkp_edu | character varying |   |   |   |
| ID_IDENTITE | integer |   |   |   |
| Formation niveau | character varying |   |   |   |
| Titre_stxt | character varying |   |   |   |
| TITRE_Codé | character varying |   |   |   |
| Catégorie | character varying |   |   |   |
| Ordre | integer |   |   |   |
| Institution | character varying |   |   |   |
| Lieu | character varying |   |   |   |
| Canton | character varying |   |   |   |
| Pays | character varying |   |   |   |
| Date | character varying |   |   |   |
| THÈSE_Titre | character varying |   |   |   |
| THÈSE_NomDirecteur | character varying |   |   |   |
| THÈSE_Directeur_IdIdentité | integer |   |   |   |
| zlg_Creation | timestamp without time zone |   |   |   |
| zlg_CreationNom | character varying |   |   |   |
| zlg_Modif | timestamp without time zone |   |   |   |
| zlg_ModifNom | character varying |   |   |   |
| principal_annexe | character varying |   |   |   |
| séjour_étranger | character varying |   |   |   |
| versionDate | date |   |   |   |

&nbsp;


### filiations
| Column Name | Data Type |   Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| idFiliation | integer |   |   |   |
| idFils | integer |   |   |   |
| idParent | integer |   |   |   |
| sexeParent | character |   |   |   |
| creation | character varying |   |   |   |
| saisie | character varying |   |   |   |
| auteurModif | character varying |   |   |   |
| zkp_filiation | character varying |   |   |   |
| versionDate | date |   |   |   |


&nbsp;

### mariage
| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| id | integer |   |   |   |
| idMariage | character varying |   |   |   |
| idFemme | integer |   |   |   |
| idMari | integer |   |   |   |
| anneeMariage_Utilisee | character varying |   |   |   |
| anneeDivorce_Utilisee | character varying |   |   |   |
| auteurModif | character varying |   |   |   |
| creation | character varying |   |   |   |
| dateExacte_divorce | character varying |   |   |   |
| dateExacte_mariage | character varying |   |   |   |
| saisie | character varying |   |   |   |
| sources | text |   |   |   |
| debut_EnToutCas | character varying |   |   |   |
| dureeAffichee | character varying |   |   |   |
| fin_EnToutCas | character varying |   |   |   |
| zkp_Mariage | character varying |   |   |   |
| versionDate | date |   |   |   |

&nbsp;

### entites
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

### autresNomsEntites
| Column Name | Data Type | Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| id | integer |   |   |   |
| autreNom | character varying |   |   |   |
| idEntite | character varying |   |   |   |
| zkp | character varying |   |   |   |
| modif | timestamp without time zone |   |   |   |
| entite_id | integer |   |   |   |

&nbsp;


### mandat
| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| id | integer |   |   |   |
| idMandat | character varying |   |   |   |
| idIdentite | integer |   |   |   |
| fonction | character varying |   |   |   |
| entite | character varying |   |   |   |
| typeEntite | character varying |   |   |   |
| organe | character varying |   |   |   |
| partiAffiliationOfficeSecteur | character varying |   |   |   |
| sphere | character varying |   |   |   |
| annexePrincipale | character varying |   |   |   |
| dateEntree | character varying |   |   |   |
| dateSortie | character varying |   |   |   |
| dureeAffichee | character varying |   |   |   |
| anneeEntreeUtilisee | character varying |   |   |   |
| anneeSortieUtilisee | character varying |   |   |   |
| idEntite | character varying |   |   |   |
| sinergiaEchantillon | character varying |   |   |   |
| sinergiaCanton | character varying |   |   |   |
| creation | character varying |   |   |   |
| saisie | character varying |   |   |   |
| auteurModif | character varying |   |   |   |
| sourcesMandat | text |   |   |   |
| versionDate | date |   |   |   |
| entite_id | integer |   |   |   |
