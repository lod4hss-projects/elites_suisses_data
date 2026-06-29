from pprint import pprint
import sys
import argparse
from typing import Dict, List, Optional, Tuple
from random import randrange

import pandas as pd

from database_creation import *

def main():

    input_csv_path = "../csvs/birth-places-citizenship-military-grades-new-cleaned.csv"
    
    raw_df = pd.read_csv(input_csv_path)

    #raw_df = raw_df.iloc[[ randrange(len(raw_df)) for i in range(5000)]]
    #raw_df.rename(columns={"id" : "orginal_sheet_id"})
    #raw_df["id"] = generate_ids(len(raw_df)) 

    print(raw_df)

    table_dict = {}
    table_dict["birth_place"] = make_birth_place_table(raw_df) 
    table_dict["citizenship"] = make_citizenship_place_table(raw_df) 
    table_dict["rank"] = make_rank_table(raw_df) 
    table_dict["citizenship_relation_person"] = make_citizenship_relation_person(raw_df, table_dict["citizenship"]) 
    table_dict["person"] = make_person_table(raw_df, table_dict["rank"], table_dict["birth_place"])

    to_sql_db(table_dict, "person.db")


if __name__ == "__main__":
    main()
