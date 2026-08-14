# Comments on ERD

This ERD reproduces the tables and main columns in the original database and adds with specific colors the new columns, classes and relations that we add for the sake of identifying implicit entities

In the database, the new tables that represent the classes in the ERD are prefixed with 't_', e.g. *t_group*, to distinguish them from the originalt tables

&nbsp;

## Color codes

* black: as in the original database
* green: new added classes / columns / relations
* red: foreign keys
* blue: views

## Tables

### Group (t_group)

New table for entities that allow to manage not yet explicitely identifies entities in the original database.

See [this file](organisation_groups.md) for more details about the creation of the Group class.

### Group Type (t_group)

Provides a unique type for a group

