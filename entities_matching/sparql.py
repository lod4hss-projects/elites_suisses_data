import sys
import time
import statistics as stats
import traceback

from SPARQLWrapper import SPARQLWrapper, JSON
from typing import Union
import urllib

def find_location(place_name : str, source : str = "qlever") -> Dict[str, Union[str, float, float, str]]:

    #little helper function to help in choosing where to send sparql querries 

    print(source == "qlever") 
    if source == "qlever":
        
        return find_location_qlever(place_name)

    elif source == "wikidata":

        return find_location_wikidata(place_name)

    elif source == "wikidata_generic":

        return find_location_wikidata_generic(place_name)

    else:
        raise ValueError("Invalid data source for sparql querries") 
        return None

def find_location_qlever(place_name : str) -> Dict[str, Union[str, float, float, str]]:

    wikidata_endpoint = "https://qlever.dev/api/wikidata"

    query = f"""
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX wd: <http://www.wikidata.org/entity/>
    PREFIX wdt: <http://www.wikidata.org/prop/direct/>
    PREFIX wikibase: <http://wikiba.se/ontology#>
    SELECT ?place ?placeLabel ?location ?type ?typeLabel ?sitelinks ?typelinks WHERE {{
    # Search for the place by label (replace 'Iceland' with your desired name)
    ?place rdfs:label "{place_name}"@fr.

    ?place  wikibase:sitelinks ?sitelinks.

    # Get the coordinates
    ?place wdt:P625 ?location.

    # Get the type of the place (instance of)
    ?place wdt:P31 ?type.
    
    ?type  wikibase:sitelinks ?typelinks.


    # Fetch labels without using the label service
    ?place rdfs:label ?placeLabel.
    ?type rdfs:label ?typeLabel.

    # Ensure we only get English labels
    FILTER(LANG(?placeLabel) = "en")
    FILTER(LANG(?typeLabel) = "en")
    }}
    ORDER BY DESC(?sitelinks) DESC(?typelinks) 
    LIMIT 1
    """

    user_agent = 'nepoc_passports/0.0 (https://github.com/lod4hss-projects/nepoc; nicholas.kaegi@unibe.ch)'
    #user_agent = "WDQS-example Python/%s.%s" % (sys.version_info[0], sys.version_info[1])
    # TODO adjust user agent; see https://w.wiki/CX6
    try:
        sparql = SPARQLWrapper(wikidata_endpoint, agent=user_agent)
        sparql.setQuery(query)
        sparql.setReturnFormat(JSON)
        result = sparql.query().convert()

        result = result["results"]["bindings"]

        if len(result) != 0:
            result = result[0]
            location = result["location"]["value"]
            lat = location.split(" ")[0][6:]
            lon = location.split(" ")[1][:-1]
            out_value = {"place" : result["place"]["value"], "lat" : lat, "lon" : lon, "label" : result["typeLabel"]['value'] }
            return out_value

        else:

            return None

    except urllib.error.HTTPError as err :
            
            traceback.print_exc()
    
            return None

def find_location_wikidata(place_name : str) -> Dict[str, Union[str, float, float, str]]:

    number_of_responses = 1
    wikidata_endpoint = "https://query.wikidata.org/sparql"

    query = f"""
    SELECT ?place ?typeLabel ?location WHERE {{
    # Search for entities with a label matching an arbitrary string
    ?place rdfs:label "{place_name}"@fr.

    # Coordinate location property (P625 in Wikidata)
    ?place wdt:P625 ?location.

    # Get the type (instance of) property (P31 in Wikidata)
    ?place wdt:P31 ?type.

    # Boilerplate to get human-readable labels
    SERVICE wikibase:label {{ bd:serviceParam wikibase:language "en". }}
    }}
    LIMIT {number_of_responses}
    """

    user_agent = 'nepoc_passports/0.0 (https://github.com/lod4hss-projects/nepoc; nicholas.kaegi@unibe.ch)'
    #user_agent = "WDQS-example Python/%s.%s" % (sys.version_info[0], sys.version_info[1])
    # TODO adjust user agent; see https://w.wiki/CX6
    try:
        sparql = SPARQLWrapper(wikidata_endpoint, agent=user_agent)
        sparql.setQuery(query)
        sparql.setReturnFormat(JSON)
        result = sparql.query().convert()


        result = result["results"]["bindings"]

        if len(result) != 0:
            result = result[0]
            location = result["location"]["value"]
            lat = location.split(" ")[0][6:]
            lon = location.split(" ")[1][:-1]
            out_value = {"place" : result["place"]["value"], "lat" : lat, "lon" : lon, "label" : result["typeLabel"]['value'] }

            return out_value

        else:

            return None

    except urllib.error.HTTPError as err :
            
            traceback.print_exc()
    
            return None


def find_location_wikidata_generic(place_name : str) -> Dict[str, Union[str, float, float, str]]:

    # just a test function to see how well nginx can handle reverse proxing qurries 

    number_of_responses = 1
    wikidata_endpoint = "https://query.wikidata.org/sparql"

    query = f"""
    SELECT ?place ?typeLabel ?location WHERE {{
    # Search for entities with a label matching an arbitrary string
    ?place rdfs:label "{place_name}"@fr.

    # Coordinate location property (P625 in Wikidata)
    ?place wdt:P625 ?location.

    # Get the type (instance of) property (P31 in Wikidata)
    ?place wdt:P31 ?type.

    # Boilerplate to get human-readable labels
    SERVICE wikibase:label {{ bd:serviceParam wikibase:language "en". }}
    }}
    LIMIT {number_of_responses}
    """

    try:
        sparql = SPARQLWrapper(wikidata_endpoint)
        sparql.setQuery(query)
        sparql.setReturnFormat(JSON)
        result = sparql.query().convert()


        result = result["results"]["bindings"]

        if len(result) != 0:
            result = result[0]
            location = result["location"]["value"]
            lat = location.split(" ")[0][6:]
            lon = location.split(" ")[1][:-1]
            out_value = {"place" : result["place"]["value"], "lat" : lat, "lon" : lon, "label" : result["typeLabel"]['value'] }

            return out_value

        else:

            return None

    except urllib.error.HTTPError as err :
            
            traceback.print_exc()
    
            return None

if __name__ == "__main__":

    times = []

    places = ["Berlin", "Paris", "London", "Londerzeel", "Belgique", "Bruxelles"]

    for item in range(1000):
        
        start_time = time.time()

        out_value = find_location(places[item % 6], "wikidata_generic")
        end_time = time.time() - start_time
        print("Querry Time", end_time)
        print(out_value)

    print("Mean Querry Time :", stats.mean(times))
