Here is the folder for the database and your code, Nico :-)


Tasks:
* create a sqlite database and import the table of the persons
* create a table for the birthplaces (the places, with geocoordinates and wikidata URI)
* add a foreign key column to the person table pointing to the place table for the birthplace
* add a table for citizenships and a join n to n table between persons and citizenships
  * find citizenships in wikidata if possible and add the wikidata URI to the table
* create a military grade table
  * two labels, one german, one french
  * additional notes if needed
  * normally sould by 1 to n relation, so just add a foreign key in the person table (fk_military_grade) pointing to the primary key of the military grade table 