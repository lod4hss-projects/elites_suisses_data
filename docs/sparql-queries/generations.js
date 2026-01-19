
const sparqlEndpoint = 'https://open-gdb.lod4hss.org/rdf4j-server/repositories/elites_suisses'

// Convert CSV-like response (with header) to JSON array of objects
// works with two columns, probably not with more
function csvToJSON(csvText) {
  const lines = csvText.trim().split('\n');
  const headers = lines[0].split(',');
  
  return lines.slice(1).map(line => {
    const values = line.split(',');
    const obj = {};
    headers.forEach((header, i) => {
      // Convert to number if possible
      obj[header] = isNaN(values[i]) ? values[i] : Number(values[i]);
    });
    return obj;
  });
}

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

//console.log(sparqlQuery)

// Encode query for URL
const encodedQuery = encodeURIComponent(sparqlQuery);


// Construct GET URL with query parameter
const getUrl = `${sparqlEndpoint}?query=${encodedQuery}`;

//console.log(getUrl)


fetch(sparqlEndpoint + '?query=' + encodeURIComponent(sparqlQuery), {
  headers: {
    'Accept': 'application/sparql-results+json'
  }
})
.then(res => res.json())
.then(data => {
  console.log(data.results.bindings);
  const generations = data.results.bindings.map(b => b.generation.value);
  const numbers = data.results.bindings.map(b => parseInt(b.number.value, 10));


    // Labels and counts from the results
    const labels = generations;
    const counts = numbers;

 //console.log(counts)

 // Set up the dimensions and margins for the chart
 const margin = { top: 20, right: 20, bottom: 150, left: 40 };
 const width = 600 - margin.left - margin.right;
 const height = 400 - margin.top - margin.bottom;

 // Create the SVG container
 const svg = d3.select('#chart')
   .append('svg')
   .attr('width', width + margin.left + margin.right)
   .attr('height', height + margin.top + margin.bottom)
   .append('g')
   .attr('transform', `translate(${margin.left}, ${margin.top})`);

 // Create scales for x and y axes
 const x = d3.scaleBand()
   .domain(labels)
   .range([0, width])
   .padding(0.3);

const maxCount = d3.max(counts) || 0; // fallback if all NaN or empty
const y = d3.scaleLinear()
  .domain([0, maxCount])
  .range([height, 0]);

 // Add x and y axes
 svg.append('g')
   .attr('transform', `translate(0, ${height})`)
   .call(d3.axisBottom(x)) .selectAll("text")
   .style("text-anchor", "end")
   .attr("dx", "-.8em")
   .attr("dy", ".15em")
   .attr("transform", "rotate(-30)");

 svg.append('g')
   .call(d3.axisLeft(y));


// Add chart title at the bottom
svg.append("text")
  .attr("class", "chart-title")
  .attr("x", width / 2)  // center horizontally
  .attr("y", height + margin.bottom - 80)  // just below the x-axis
  .attr("text-anchor", "middle")
  .text("Number of Persons by Generation")
  .style("font-size", "12px")
  .style("font-weight", "bold")
  .style("fill", "#333")
  .style("font-family", "sans-serif");




// Add value labels ON TOP of bars
svg.selectAll(".bar-label")
  .data(counts)
  .enter().append("text")
    .attr("class", "bar-label")
    .attr("x", (d, i) => x(labels[i]) + x.bandwidth() / 2)  // center horizontally
    .attr("y", (d) => y(d) - 8)  // 8px above the top of the bar
    .attr("text-anchor", "middle")
    .text(d => d)  // or d.toLocaleString() for commas
    .style("font-size", "12px")
    //.style("font-weight", "bold")
    .style("fill", "black")
    .style("text-shadow", "1px 1px 2px rgba(255,255,255,0.8)")  // improves readability
    .style("pointer-events", "none");  // don't interfere with hover


 // Create bars
 svg.selectAll('.bar')
   .data(counts)
   .enter().append('rect')
   .attr('class', 'bar')
   .attr('x', (d, i) => x(labels[i]))
   .attr('y', d => y(d))
   .attr('width', x.bandwidth())
   .attr('height', d => height - y(d))
   .attr("fill", "#add8e6");

}).catch(error => console.error('Error:', error));