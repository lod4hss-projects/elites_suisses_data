


### mariage
| Column Name | Data Type |  Comments | Mapping  | Mapping Comments |
|-------------|-----------|------|------|------|
| sysid | integer |   |   |   |
| id | integer |   |   |   |
| idMariage | character varying | Use for the URI of the sdh-slc:C3 Social Relationship?  |   |   |
| idFemme | integer | Add Actor's Social Quality "Wife"  |   |   |
| idMari | integer | Add Actor's Social Quality "Husband"  |   |   |
| anneeMariage_Utilisee | character varying | begin date of the sdh-slc:C3 Social Relationship  |   |   |
| anneeDivorce_Utilisee | character varying | end date of the sdh-slc:C3 Social Relationship  |   |   |
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

There are 3 different ways to document marriage:
1. With the `crm:E21 Person` linked to the `sdh-slc:C3 Social Relationship` via the generic `sdh-slc:C43 Actor's Role in a Social Relationship`. This allows the documentation of marriages in a same way as other social relationship, keeping therefore some complexity
2. With a more generic `sdh-slc:C3 Social Relationship` linked to the `crm:E21 Person` involved via the property `sdh-slc:P15 involves partner`, without specifying the roles "husband" and "wife". This could be problematic when those roles bears different functions and/or rights
3. With specific class and properties for marriages, as this time of information is central to human relations but also generic for western societies. This means the creation of a `sdh-slc:CX Marriage` class, and the properties `sdh-slc:PX has husband` and `sdh-slc:PX has wife`.