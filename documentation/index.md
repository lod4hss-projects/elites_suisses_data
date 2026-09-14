# Documentation

We document here the analysis of the information available in the Élites suisses MySQL database as well as the process of data cleaning, mapping to the final ontology and data conversion to RDF as part of the LESSH project.

The MySQL database comprises the information published on the [Élites suisses website](https://elitessuisses.unil.ch/). It is, in fact, a selected and partly cleaned up portion of the information available in the original FileMaker database that was not directly usable given some technical issues and the partly confidential data it contains.

&nbsp;

## Inspection of the information available

The following eight tables were delivered by the Élites suisses project:

* ***`identite`*** (Persons)
* ***`identifier`*** (Links)
* ***`filiations`*** (Parents)
* ***`mariage`*** (Marriage)
* ***`education`*** (Education)
* ***`entites`*** (Organisations)
* ***`autresNomsEntites`*** (Naming Variants of Organisations)
* ***`mandat`*** (Mandates)

An overview of the available information in these tables can be found [on this page](available_information.md). From there, more detailed inspections of the various concepts and categories inside the Élites suisses database can be found.

We found that there are many implicit entities stored as textual values in these tables (e.g. gender, organisation type, type of education). To transform the relational database into a knowledge graph, these implicit entities need to be identified and represented as explicit, identifiable entities. For this purpose, new tables were created to define and describe these entities using controlled vocabularies. This allows textual values occurring in the source data to be mapped to consistent, well-defined entities. In addition, some existing tables, namely the ***`entites`***, ***`education`*** and ***`mandat`*** tables, were recreated to facilitate further data cleaning, mapping and conversion.

We created an [extended ERD](../documentation/graphics/ERD_with_new_tables.png) that shows the original tables in relation to the newly created tables. The extended ERD is [described here in more detail](../documentation/graphics/ERD_with_new_tables.md)).

&nbsp;

## Technical documentation

- [Transformation from MySQL to PostgreSQL](database_management/creation_fdw.sql)

&nbsp;

## Conventions used in this documentation

### Naming conventions

To clearly distinguish between different database objects, the following conventions are used throughout this documentation:

* **Names of tables** are formatted as code + italic + bold,<br>e.g. ***`education`***
* **Names of views** are formatted as code + italic,<br>e.g. *`education`*
* **Names of columns** are formatted as code,<br>e.g. `Formation niveau`

As can be seen in the example above, some column names in the original tables contain uppercase letters or spaces. Throughout this documentation, the original table and column names are used exactly as they appear in the provided source tables.

In the newly created tables and columns, we only use lowercase names. In addition, the names of newly created tables are prefixed with "***`t_`***" to distinguish them from the original source tables (e.g. ***`t_mandates_cleaning_up`*** is the table we use for cleaning up the ***`mandat`*** table).

### Interlinkage

The pages in this documentation are interlinked to facilitate navigation to and between the information on the various source and newly created tables and processes of data cleaning, mapping, RDF conversion, and so on.

Links are also used to reference subpages that contain more detailed information about specific columns or individual categories and values within a column.

&nbsp;

---

Go back to [README](../README.md)