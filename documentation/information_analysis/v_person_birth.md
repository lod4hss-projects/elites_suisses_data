# Information about the new `v_person_birth` table.

## Table creation

As the documentation of parents in the SDHSS ontology ecosystem is done through the birth event, a new view called `v_person_birth` is created, which contains information mostly from the `filiation` table as well as the `identite` table:
- an identifier which is the concatenation of the two `idFiliation` values (mother and father)
- a new identifier for the birth, based on the child id
- the birth year, based on the new column `birth_year` of the `identite` table (see [here](../information_analysis/person_birth-death.md))
- the foreign key of the child
- the foreign keys of the mother and father

The SQL queries are documented [here](../database_inspection/filiations.sql). See also the [filiation page](../information_analysis/filiations.md)

In addition, we need to add in this view the birth place. Based on what is described in the [`t_geo_place`](../information_analysis/t_geo_place.md) page, a new `t_geo_place` table has been created, and a link between the person and the birth place has been added in the `identite` table. The new `v_person_birth` view also this fk of the place as a `birth_place` column

First 20 lignes of the view:

|string_agg|id_birth|child|birth_year|mother|father|fk_birth_place|
|----------|--------|-----|----------|------|------|--------------|
|8566|bir_78271|78271|1938||61549|11|
|12200_6924|bir_76016|76016|1851|97903|67018|18|
|5458_4432|bir_69078|69078|1857|74121|61114|21|
|4709|bir_63147|63147|1853||69237|213|
|9419_13107|bir_91038|91038|1914|101268|91125|435|
|81_3540|bir_53142|53142|1896|64073|50249|11|
|2650_2651|bir_55550|55550|1898|66875|66874|369|
|50_14126|bir_54156|54156|1945|102157|52754|21|
|668_3869|bir_51067|51067|1921|68338|51250|658|
|15038|bir_103911|103911|1778||103910|21|
|9271_10087|bir_50728|50728|1836|98264|97166|11|
|15920|bir_75594|75594|1904||106326|1153|
|2974_2975|bir_55235|55235|1929|67299|67298|567|
|4114_4116|bir_61735|61735|1924|68531|68532|18|
|11256_11255|bir_63091|63091|1874|99172|99171|933|
|8551_13890|bir_61088|61088|1836|101960|88412|21|
|3429|bir_55822|55822|1852||67929|37|
|3120_3119|bir_55381|55381|1905|67496|67495|296|
|14292_14291|bir_61450|61450|1865|102331|102330|2665|
|2898|bir_55142|55142|1923||67192|51|

The SQL queries are documented [here](../database_inspection/filiations.sql)

## Data Mapping

The ontological mapping from the table and the SDHSS ontology ecosystem is as follows:
- the births are instances of the class [`crm:E67 Birth`](http://www.cidoc-crm.org/cidoc-crm/E67_Birth)
- The column `child` is the ID of the person linked to the instance of birth through the property [`crm:P98 brought into life`](http://www.cidoc-crm.org/cidoc-crm/P98_brought_into_life)
- The column `mother` is the ID of the person linked to the instance of birth through the property [`crm:P96 by mother`](http://www.cidoc-crm.org/cidoc-crm/P96_by_mother)
- The column `father` is the ID of the person linked to the instance of birth through the property [`crm:P97 from father`](http://www.cidoc-crm.org/cidoc-crm/P97_from_father)
- The column `birth_year` is a string of the birth year linked to the instance of birth through the property [`sdh-shortcut:P1 at some tinme within`](https://sdhss.org/ontology/shortcuts/P1)
- The column `fk_birth_place` is the ID of the geographical place linked to the instance of birth through the property [`sdh:P6 took place at`](https://sdhss.org/ontology/core/P6)

The ontological diagram:

![Filiation](../graphics/filiation.png)

### Ontological Profiles

[Person - Familiy light](https://ontome.net/profile/601)
[Person - Birth and Death](https://ontome.net/profile/510)
