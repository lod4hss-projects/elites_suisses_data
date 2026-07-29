## Documentation of institutions of type "Enseignement" from within the mandates table

This table is to match the groups (institutions, organisations) from within the mandats table with the crm_group table under the general question, if the former contains new groups that are not yet present in the latter.

### Documentation of the matching process

to be documented

### Wrongly named institutions in field 'entite' in mandats table

So far, this has been verified for "typeEntite" = 'Enseignement', as in the t_entity_sub_entity_education table:


| tesee.id | m.entite | m.name_correct_false | organe | fk_crm_group | name_standard | num | name_entity | id_entity | string_agg (m.id) |
|----|--------|-----------------|---------|--------------|---------------|-----|-------------|-----------|------------|
| 381 | Handelshochschule Leipzig | false name in mandat table |  | 94 | Universität Leipzig | 1 | Universität Leipzig | 2379 | 45056 |
| 382 | Handelshochschule Leipzig | correct name |  | 258 | Handelshochschule Leipzig | 1 | Handelshochschule Leipzig | 3506 | 61794 |
| 523 | London Business School | false name |  | 131 | University of London | 2 | University of London | 2513 | 48078,48077 |
| 524 | London Business School | correct name |  | 317 | London Business School | 1 | London Business School | 3137 | 77261 |
| 624 | Princeton University | false name |  | 120 | Universität Konstanz | 1 | Universität Konstanz | 2383 | 47407 |
| 625 | Princeton University | correct name |  | 124 | Princeton University | 30 | Princeton University | 2380 | 67332,52238,47286,45039,45037,65050,65049,65048,63017,65369,76830,51576,76685,76636,78359,63967,66007,66613,63832,45038,63843,67782,66363,55467,66425,52296,47790,51413,52297,52078 |
| 634 | Queen Mary University of London | false name |  | 131 | University of London | 1 | University of London | 2513 | 76890 |
| 635 | Queen Mary University of London | not yet in crm_group |  | [null] | [null] | 1 | [null] | [null] | 76938 |
| 1190 | Universität Leipzig | false name |  | 83 | Université de Berne | 1 | UniBe | 2347 | 52540 |
| 1191 | Universität Leipzig | correct name |  | 94 | Universität Leipzig | 11 | Universität Leipzig | 2379 | 55167,46235,57040,62404,52386,54968,53606,37289,52387,54844,48346 |
| 1197 | Universität Mannheim | false name |  | 89 | Université de Saint-Gall | 1 | UniSG | 2364 | 47701 |
| 1198 | Universität Mannheim | correct name |  | 136 | Universität Mannheim | 17 | Universität Mannheim | 2403 | 52566,76891,76639,77638,76984,62679,47095,62662,47087,76691,45920,77661,55391,45432,66494,61437,45391 |
| 1373 | Université de Provence | check |  | 2945 | [null] | 1 | Université d'Aix-Marseille I | 2606 | 64135 |
| 1374 | Université de Provence | check |  | 2946 | [null] | 2 | Université d'Aix-Marseille | 2607 | 64134,64133 |
| 1414 | Université de Varsovie | false name |  | 88 | Université de Fribourg | 1 | UniFr | 2353 | 112151 |
| 1415 | Université de Varsovie | correct name |  | 3143 | [null] | 3 | Université de Varsovie | 2878 | 65598,52350,48344 |
| 1487 | Université Paris I (Panthéon-Sorbonne) | false name |  | 95 | Université de Paris (Sorbonne) | 1 | Université de Paris (Sorbonne) | 2569 | 57392 |
| 1488 | Université Paris I (Panthéon-Sorbonne) | correct name |  | 125 | Université Paris I (Panthéon-Sorbonne) | 7 | Université Paris I (Panthéon-Sorbonne) | 2556 | 76941,65932,46475,66459,60095,61085,64176 |

**No changes on the data made so far (July 29).**