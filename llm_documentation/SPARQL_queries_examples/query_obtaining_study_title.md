Question: What are the dates of the study titles obtained by a person?

``` sparql
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX sdh: <https://sdhss.org/ontology/core/>
PREFIX crm-sup: <https://sdhss.org/ontology/crm-supplement/>
PREFIX sdh-slc: <https://sdhss.org/ontology/social-life/>
PREFIX sdh-short: <https://sdhss.org/ontology/shortcuts/>
PREFIX sdh-info: <https://sdhss.org/ontology/sources-information-metadata/>
PREFIX sdh-slp: <https://sdhss.org/ontology/social-life-specific/>

SELECT ?person_id ?person_label ?obtention_date
WHERE {
  
?study_obtention a sdh-slp:C7.
?study_obtention sdh-slp:P9 ?person_id.
?person_id sdh-short:P9 ?person_label.
?study_obtention sdh-short:P1 ?obtention_date.

}

```

Question: What are the disciplines of the study titles obtained by a person?

``` sparql
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX sdh: <https://sdhss.org/ontology/core/>
PREFIX crm-sup: <https://sdhss.org/ontology/crm-supplement/>
PREFIX sdh-slc: <https://sdhss.org/ontology/social-life/>
PREFIX sdh-short: <https://sdhss.org/ontology/shortcuts/>
PREFIX sdh-info: <https://sdhss.org/ontology/sources-information-metadata/>
PREFIX sdh-slp: <https://sdhss.org/ontology/social-life-specific/>

SELECT ?person_id ?person_label ?discipline_id ?discipline_label
WHERE {
  
?study_obtention a sdh-slp:C7.
?study_obtention sdh-slp:P9 ?person_id.
?person_id sdh-short:P9 ?person_label.
?study_obtention sdh-slp:P25 ?discipline_id.
?discipline_id sdh-short:P9 ?discipline_label.

}

```

Question: What are the institutions that delivered the study titles obtained by a person?

``` sparql
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX sdh: <https://sdhss.org/ontology/core/>
PREFIX crm-sup: <https://sdhss.org/ontology/crm-supplement/>
PREFIX sdh-slc: <https://sdhss.org/ontology/social-life/>
PREFIX sdh-short: <https://sdhss.org/ontology/shortcuts/>
PREFIX sdh-info: <https://sdhss.org/ontology/sources-information-metadata/>
PREFIX sdh-slp: <https://sdhss.org/ontology/social-life-specific/>

SELECT ?person_id ?person_label ?institution_id ?institution_label
WHERE {
  
?study_obtention a sdh-slp:C7.
?study_obtention sdh-slp:P9 ?person_id.
?person_id sdh-short:P9 ?person_label.
?study_obtention sdh-slp:P17 ?institution_id.
?institution_id sdh-short:P9 ?institution_label.

}

```

Question: What are the places where the study titles was obtained by a person?

``` sparql
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX sdh: <https://sdhss.org/ontology/core/>
PREFIX crm-sup: <https://sdhss.org/ontology/crm-supplement/>
PREFIX sdh-slc: <https://sdhss.org/ontology/social-life/>
PREFIX sdh-short: <https://sdhss.org/ontology/shortcuts/>
PREFIX sdh-info: <https://sdhss.org/ontology/sources-information-metadata/>
PREFIX sdh-slp: <https://sdhss.org/ontology/social-life-specific/>

SELECT ?person_id ?person_label ?place_id ?place_label
WHERE {
  
?study_obtention a sdh-slp:C7.
?study_obtention sdh-slp:P9 ?person_id.
?person_id sdh-short:P9 ?person_label.
?study_obtention sdh-slp:P19 ?placce_id.
?place_id sdh-short:P9 ?place_label.

}

```

Question: What are the titles (type of diploma) of the study titles obtained by a person?

``` sparql
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX sdh: <https://sdhss.org/ontology/core/>
PREFIX crm-sup: <https://sdhss.org/ontology/crm-supplement/>
PREFIX sdh-slc: <https://sdhss.org/ontology/social-life/>
PREFIX sdh-short: <https://sdhss.org/ontology/shortcuts/>
PREFIX sdh-info: <https://sdhss.org/ontology/sources-information-metadata/>
PREFIX sdh-slp: <https://sdhss.org/ontology/social-life-specific/>

SELECT ?person_id ?person_label ?title_id ?title_label
WHERE {
  
?study_obtention a sdh-slp:C7.
?study_obtention sdh-slp:P9 ?person_id.
?person_id sdh-short:P9 ?person_label.
?study_obtention sdh-slp:P10 ?title_id.
?title_id sdh-short:P9 ?title_label.

}

```

Question: Who are the supervisors of the study titles obtained by a person?

``` sparql
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX sdh: <https://sdhss.org/ontology/core/>
PREFIX crm-sup: <https://sdhss.org/ontology/crm-supplement/>
PREFIX sdh-slc: <https://sdhss.org/ontology/social-life/>
PREFIX sdh-short: <https://sdhss.org/ontology/shortcuts/>
PREFIX sdh-info: <https://sdhss.org/ontology/sources-information-metadata/>
PREFIX sdh-slp: <https://sdhss.org/ontology/social-life-specific/>

SELECT ?person_id ?person_label ?supervisor_id ?supervisor_label
WHERE {
  
?study_obtention a sdh-slp:C7.
?study_obtention sdh-slp:P9 ?person_id.
?person_id sdh-short:P9 ?person_label.
?study_obtention sdh-slp:P11 ?supervisor_id.
?supervisor_id sdh-short:P9 ?supervisor_label.

}

```