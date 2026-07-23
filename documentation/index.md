# Documentation

We document here the analysis of the information available in the Elites Suisses MySQL database as well as the process of data cleaning, mapping to the final ontology and data conversion to RDF.

The MySQL database comprises the information published on the [Elites Suisses website](https://elitessuisses.unil.ch/index.php). It is in fact a selected and partly cleaned up portion of the information available in the original FileMaker database that was not directly usable given some technical issues and the partly confidential data it contains.

## Inspection of the information available

We provide first a [detailed analysis of the available information](available_information.md)

## Technical documentation

- [Transformation from MySQL to PostgreSQL](database_management/creation_fdw.sql)