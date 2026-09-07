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

From these inspections, we found that there are many implicit entities stored as text data in these tables (e.g. gender, organisation type, type of education) that are necessary to transform the data into a knowledge graph. For this, new tables were created to describe the entities using a controlled vocabulary. Some tables, namely the ***`education`***, ***`mandat`*** and ***`entites`*** table, were recreated for further data cleaning (see [extended ERD](../documentation/graphics/ERD_with_new_tables.png) representing the original tables as well as [information on these tables](../documentation/graphics/ERD_with_new_tables.md)).

&nbsp;

## Technical documentation

- [Transformation from MySQL to PostgreSQL](database_management/creation_fdw.sql)

&nbsp;

## Conventions used in this documentation

### Naming conventions

To clearly distinguish between different database objects, the following conventions are used throughout this documentation:

* **Names of tables** are formatted as bold + italics + code,<br>e.g. ***`education`***
* **Names of columns** are formatted as code,<br>e.g. `Formation niveau`

Some column names in the original tables contain uppercase letters or spaces. Throughout this documentation, the original table and column names are used exactly as they appear in the provided source tables.

For newly created tables and columns, only lowercase names are used. In addition, the names of newly created tables are prefixed with "t_" to distinguish them from the original source tables (e.g. ***`t_mandates_cleaning_up`***).

### Interlinkage

The pages in this documentation are interlinked to facilitate navigation to and between the information on the various source and newly created tables and processes of data cleaning, mapping, RDF conversion, and so on.

Links are also used to reference subpages that contain more detailed information about specific columns or individual categories and values within a column.

&nbsp;

---

Go back to [README](../README.md)