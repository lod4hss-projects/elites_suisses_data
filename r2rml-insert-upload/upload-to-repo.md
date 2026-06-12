

### Tentative d'écriture sur rdf4j lod4hss (5 juin 2026)


curl -X POST \
  -H "Content-Type: application/n-quads" \
  -H "Content-Encoding: gzip" \
  --data-binary @chunks.nq.gz \
  "http://open-gdb.lod4hss.org/repositories/eos/statements"

  413 Request Entity Too Large



curl -G "https://open-gdb.lod4hss.org/repositories/eos" \
  --data-urlencode "query=SELECT ?graph_uri (COUNT(*) AS ?triples_count)
WHERE {
  GRAPH ?graph_uri {
    ?s ?p ?o
  }
}
GROUP BY ?graph_uri
ORDER BY DESC(?triples_count)" \
  -H "Accept: application/sparql-results+json"




curl -G "https://open-gdb.lod4hss.org/repositories/DH25-Lisbon" \
  --data-urlencode "query=SELECT ?graph_uri (COUNT(*) AS ?triples_count)
WHERE {
  GRAPH ?graph_uri {
    ?s ?p ?o
  }
}
GROUP BY ?graph_uri
ORDER BY DESC(?triples_count)" \
  -H "Accept: application/sparql-results+json"

