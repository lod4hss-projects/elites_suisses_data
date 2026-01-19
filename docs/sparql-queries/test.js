const sparqlEndpoint = 'https://open-gdb.lod4hss.org/rdf4j-server/repositories/elites_suisses'
const sparqlQuery = `
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix esr: <http://elites_suisses/resource/>
prefix eso: <http://elites_suisses/ontology/>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>

select ?generation (count(*) as ?number)
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
                ) AS ?generation
    )
} 
group by ?generation
order by ?generation`;


fetch(sparqlEndpoint + '?query=' + encodeURIComponent(sparqlQuery), {
  headers: {
    'Accept': 'application/sparql-results+json'
  }
})
.then(res => res.json())
.then(data => {
  console.log(data.results.bindings);
  const generations = []
  const numbers = []

  data.results.bindings.forEach(binding => {
    generations.push(binding.generation.value);
    numbers.push(parseInt(binding.number.value, 10));
  });

const result = {
    generations: generations,
    numbers: numbers
};

console.log(result)

}).catch(err => console.error('Error:', err));
