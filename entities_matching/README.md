# Elite swiss entity matching  

This project is managed with the [UV python enviroment manager](https://docs.astral.sh/uv/getting-started/installation/) 

To set up the python virtual environment and install all necessary packages install UV and run 

```bash
uv sync
```

From there you can run any of the python scripts using. No python virtual enviroment activation necessary

```bash
uv run <<script you want to run>>
```

To create a copy of person.db run

```bash
uv run python_code/main.py
```

to run the sql scripts simply run 

```sql
sqlite3 person.db < <<sql-script you wish to run>>
```

## Workflow 

The following is how the data in person.db is proccessed. 

1. First the data was cleaned/regularized with openrefine, and turned into the file "birth-places-citizenship-military-grades-new-cleaned.csv".

2. Then CSV is broken is transformed into a copy of person.db using the main.py script. 

3. The rank, birth place, and citizenship tables are then extracted using the export sql-script to a series of csvs with the same names.

4. The table csvs are then imported into open refine to do the final wikidata reconciliation, and later re inserted into the database using the import sql-script.  
