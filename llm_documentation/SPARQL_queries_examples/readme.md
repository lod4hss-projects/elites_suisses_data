# SPARQL queries examples

This folder contains the various SPARQL queries examples needed to train the LLM in generating an appropriate SPARQL query.

Those examples are based on the Expasy project, and documentation on SPARQL queries can be found here: https://github.com/sib-swiss/sparql-examples and tempaltes here: https://github.com/sib-swiss/sparql-examples-template. This template should be copied in the Github repo of LESSH

SH (30.03.2026): It is still not clear for me how to organise the SPARQL queries. From the SIB examples and template, each ttl file contains the natural language question in the `rdfs:comment` of a `sh:SPARQLExecutable`.
Also, examples are organised in folders, but not sure what is the logic behind it.

For the moment, SPARQL queries examples are organised in a single .md file, with the natural language question followed by a code block with the SPARQL query.