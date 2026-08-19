# Information about the military grade maximum

## Data Exploration

The `identite` table contains a column called `gradMilitaireMax` that contains the maximum grade a person has obrained in the Swiss army. It contains a string value, and that mostly contains the french and german name of the military rank.

This column has 49834 empty cells, and 5641 cells containing the value "non" or "non?" or only "?", for a total of 58662 cells without a military rank as a value.

Here is the list of the distinct values with their frequency:

|gradeMilitaireMax|number_occurences|
|-----------------|-----------------|
|Colonel / Oberst|815|
|Capitaine / Hauptmann|641|
|Premier-lieutenant / Oberleutnant|459|
|Lieutenant-Colonel / Oberstleutnant|403|
|Major / Major|387|
|Brigadier / Brigadier|96|
|Non?|71|
|?|67|
|Divisionnaire / Divisionär|56|
|Commandant de corps / Korpskommandant|52|
|Lieutenant / Leutnant|41|
|Major|41|
|Colonel|35|
|Officier spécialiste / Fachoffizier|31|
|Capitaine / Hauptmann?|17|
|Oberst|15|
|Premier-lieutenant / Oberleutnant?|12|
|Capitaine / Hauptmann ?|8|
|Capitaine|6|
|Lieutenant-Colonel / Oberstleutnant?|5|
|Major / Major?|5|
|Premier-lieutenant / ?Oberleutnant|5|
|Caporal|4|
|Lieutenant / Leutnant?|4|
|Major / Major ?|4|
|Appointé|3|
|Lieutenant|3|
|Officier|3|
|Colonel brigadier|2|
|Colonel EMG|2|
|Colonel / Oberst?|2|
|Gefreiter|2|
|Général / General|2|
|Kommandant|2|
|Lieutenant-Colonel / ?Oberstleutnant|2|
|Premier-lieutenant / Oberleutnant (depuis 1946)|2|
|sous-officier|2|
|-|1|
|Adj sof|1|
|Adjudant (troupes cyclistes)|1|
|Adj Uof|1|
|Artilleriehauptmann|1|
|Bataillonskommandant|1|
|Battaillonskommandant|1|
|Brigadier|1|
|Brigadier |1|
|Brigadier / Brigadier?|1|
|Brigadier / Brigadier (1962-1975)|1|
|Capitaine / Hauptmann |1|
|Capitaine / Hauptmann (1959)|1|
|Capitaine / Hauptmann? (Grade en 1988)|1|
|Caporal d'artillerie|1|
|Chef de section |1|
|colonel|1|
|Colonel |1|
|Colonel d'artillerie|1|
|Colonel de cavalerie|1|
|Colonel de justice militaire|1|
|Colonel d'infanterie|1|
|Colonel divisionnaire?|1|
|Colonel fédéral|1|
|Colonel fédéral |1|
|Colonel / Oberst ?|1|
|Colonel / Oberst (depuis 1974)|1|
|Commandant|1|
|Commandant de corps / Korpskommandant  ?|1|
|Divisionsarzt|1|
|Divisionsarzt / Oberst Sanität|1|
|Fachoffizier|1|
|Fourier|1|
|Hauptmann Capitaine / Militärjustiz|1|
|Hauptmann der Infanterie|1|
|Hauptmann der Kavallerie|1|
|Hauptmann, Kommandant Flöchnerkorps|1|
|Hauptmann / Landwehrhauptmann|1|
|Hauptmann, Major der Artillerie|1|
|Hauptmann, Stabsmajor, Oberstleutnant|1|
|Hptm|1|
|Infanterie-Major|1|
|Infanterie-Major / Oberstleutnant, Kommandant 23. Infanterieregiment|1|
|Juge du tribunal de Division 9B (1947-1952)|1|
|Kavalleriehauptmann|1|
|Kavallerie-Leutnant|1|
|Leutnant der Infanterie / Hauptmann|1|
|Leutnant  / Hauptmann der Scharfschützen|1|
|Lieutenant colonel  |1|
|Lieutenant-colonel|1|
|Lieutenant Colonel (Bataillon 64)|1|
|Lieutenant-Colonel ? / Oberstleutnant|1|
|Lieutenant-Colonel ?/ Oberstleutnant|1|
|Lieutenant / Leutnant??|1|
|Lieutenant / Leutnant? (grade en 1988)|1|
|Lieutenant médecin|1|
|Lieutnant
|1|
|Lieutnant, Artilleriehauptmann|1|
|Major / Major (1968-1985)|1|
|Major / Major? (Grade en 1988)|1|
|Major / Oberst|1|
|Major / Oberstleutnant|1|
|Major / Oberstlieutenant|1|
|Oberstbrigadier / Oberauditor er Armee|1|
|Oberst (Justizoberst)|1|
|Oberstleutnant / GrossrichTerritorialgericht 5|1|
|Oberstleutnant i.Gst|1|
|Oberst, Oberstlieutnant|1|
|officier|1|
|Officier d'artillerie |1|
|Officier de l'armée allemande durant la Seconde Guerre mondiale|1|
|Officier de réserve, Marine Nationale Française|1|
|Premier-lieutenant ?/ Oberleutnant|1|
|Premier-lieutenant / Oberleutnant? (Grade 1988)|1|
|Premier-lieutenant / Oberleutnant? (Grade en 1988)|1|
|Reformé|1|
|Sanitäthauptmann|1|
|Scharfschützenhauptmann|1|
|Schützenhauptmann|1|
|Secrétaire d'état-major|1|
|Sergent-major|1|
|Sergenz|1|
|Stabsmajor / Oberstlieutnant /Oberst|1|
|Unteroffizier|1|
|Wachtmeister / Militärrichter|1|

The SQL queries can be found [here](../database_inspection/person_military-max.sql)

## Decision

It was decided, due to the highly unstructured state of this field, and it relative little importance, that it will not be transformed in the Semantic Graph.