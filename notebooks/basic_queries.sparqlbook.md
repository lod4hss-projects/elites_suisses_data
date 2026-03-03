
```sparql
SELECT ?g (count(*) as ?n)
WHERE { graph ?g {?s ?p ?o} }
GROUP BY ?g
order by desc(?n)
```

```sparql
SELECT ?s ?p ?o
WHERE { graph <https://swiss-elites.lod4hss.cloud/resource/>
 {?s ?p ?o} }
LIMIT 5
```

```sparql
### Classes and number of their instances
SELECT ?class (COUNT(*) AS ?number)
 WHERE { graph <https://swiss-elites.lod4hss.cloud/resource/>
 {?s a ?class} }
GROUP BY ?class
ORDER BY DESC(?number)
```

```sparql
SELECT ?s ?p ?o
WHERE { graph <https://swiss-elites.lod4hss.cloud/resource/originatesFrom>
 {?s ?p ?o} }
LIMIT 10
```

```sparql
### How many triples in the Wisski metadata graph 
SELECT (COUNT(*) AS ?number)
WHERE { graph <https://swiss-elites.lod4hss.cloud/resource/originatesFrom>
 {?s ?p ?o} }
```

```sparql
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix esr: <http://elites_suisses/resource/>
prefix eso: <http://elites_suisses/ontology/>
prefix crm: <http://www.cidoc-crm.org/cidoc-crm/>
prefix swel: <https://swiss-elites.lod4hss.cloud/resource/>
prefix sdh-short: <https://sdhss.org/ontology/shortcuts/>




select * where {
    ?s a crm:E21;
             ?p ?o.
} 
order by ?s
offset 300
limit 100
```

```sparql
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix esr: <http://elites_suisses/resource/>
prefix eso: <http://elites_suisses/ontology/>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>

select ?period (count(*) as ?number)
where {
    ?s a eso:Person;
       eso:birthYear ?birth.
    FILTER (?birth != 0)   
    BIND ( 
        IF (?birth < 1801, '1800_et_ante', 
            IF (?birth < 1826, '1801-1925',
                IF (?birth < 1851, '1826-1850',
                    IF (?birth < 1876, '1851-1875', 
                        IF (?birth < 1901, '1876-1900', 
                        IF (?birth < 1926, '1901-1925', 
                        IF (?birth < 1951, '1926-1950', 
                        IF (?birth < 1976, '1951-1975', 
                        IF (?birth > 1975, '1976-...', 'none'))))))))
                ) AS ?period
    )
} 
group by ?period
order by ?period
```

```sparql
prefix owl: <http://www.w3.org/2002/07/owl#>
        prefix esr: <http://elites_suisses/resource/>
        prefix eso: <http://elites_suisses/ontology/>
        prefix xsd: <http://www.w3.org/2001/XMLSchema#>

        select ?name ?birthYear ?url
        where {
            ?s a eso:Person;
               eso:nameForename ?name;
               eso:birthYear ?birthYear.
            FILTER(CONTAINS(?name, 'Ogi') )  
            BIND(
                URI(REPLACE(str(?s), 'http://elites_suisses/resource/','https://elitessuisses.unil.ch/p/'))
                AS ?url
            )
        }
        LIMIT 100
```
