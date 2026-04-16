from pprint import pprint
import sys
import argparse
from typing import Dict, List, Optional, Tuple

import pandas as pd


from database_creation import *
#from sheet_proccessing import *

def main():

    input_csv_path = "birth_places_citizenship_military_grades.csv"
    
    raw_df = pd.read_csv(input_csv_path)
    table_dict = {}
    table_dict["birth_place"] = make_birth_place_table(raw_df) 
    table_dict["citizenship"] = make_citizenship_place_table(raw_df) 
    table_dict["rank"] = make_rank_table(raw_df) 
    table_dict["citizenship_relation_person"] = make_citizenship_relation_person(raw_df, table_dict["citizenship"]) 
    table_dict["person"] = make_person_table(raw_df, table_dict["rank"], table_dict["birth_place"])

    engine = get_or_create_sql("rank.db")
    to_sql_db(table_dict, engine)


if __name__ == "__main__":
    main()
