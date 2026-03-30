# Query Examples

## Example 1: Federal Council List

Question: Who has been a swiss federal councillor?

Alternative question: What is the list of all the members of the Federal Council?

Expected answer: The list of all the person that has been a member of the Swiss Federal Council.

Comment:
- From this question, the LLM needs to find the URI of the Federal Council. How can this be done? Should the LLM find entities with the label "federal council"?
- Should the answer contain just the label of the persons? oR the URI too?
- Should we also add the role of the person in the Federal Council?

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

SELECT ?person_id ?person_label
WHERE {
  ?membership sdh-so:P1 ?person_id.
  ?membership sdh-so:P2 ?group_id.
  ?group_id sdh-short:P9 "Federal Council". # here should it be directly the URI of the Federal Council?
  ?person_id sdh-short:P9 ?person_label.

}

```

## Example 2: Federal Council List at Time

Question: Who was in the Federal Council in 2001?

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

SELECT ?person_id ?person_label
WHERE {
  
  # This BIND is when dates are documented only in years.
  BIND(2001 AS ?year)
  BIND(xsd:date(CONCAT(STR(?year), "-01-01")) AS ?yearStart)
  BIND(xsd:date(CONCAT(STR(?year), "-12-31")) AS ?yearEnd)

  ?membership sdh-so:P1 ?person_id.
  ?membership sdh-so:P2 ?group_id.
  ?membership sdh-short:P3 ?start_date .
  ?membership sdh-short:P8 ?end_date . # Should we add the possibilité of not having the end date?
  
  ?group_id sdh-short:P9 "Federal Council". # here should it be directly the URI of the Federal Council?
  ?person_id sdh-short:P9 ?person_label.

  FILTER (
    ?start_date <= ?yearEnd &&
    ?end_date >= ?yearStart
  )

}

```