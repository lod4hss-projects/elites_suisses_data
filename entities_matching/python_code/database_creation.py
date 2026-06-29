from typing import Dict, List, Tuple

import sqlalchemy
from sqlalchemy import create_engine, inspect
from sqlalchemy.dialects import sqlite, postgresql
from sqlalchemy.schema import CreateTable
from sqlalchemy.orm import Session

import pandas as pd
import numpy as np

from sqlalchemy_classes import *

def generate_ids(frame_len : int) -> List[int]:
    return [id for id in range(frame_len)]

def make_birth_place_table(raw_frame : pd.DataFrame) -> pd.DataFrame:
    
    out_frame = raw_frame[["cantonNaissance", "lieuNaissance"]]
    out_frame = out_frame.rename(columns={"lieuNaissance": "name", "cantonNaissance" : "birth_canton"})
    out_frame = out_frame.dropna()
    out_frame = out_frame.drop_duplicates()
    
    out_frame["id"] = generate_ids(len(out_frame)) 
    return out_frame

def make_citizenship_place_table(raw_frame : pd.DataFrame) -> pd.DataFrame:
    
    mid_frame = raw_frame[["nationalite"]]
    mid_frame = mid_frame.dropna()

    mid_frame = mid_frame.drop_duplicates()

    citizenship_list = []
    #citizenship_uri_list = []
    for i, row in mid_frame.iterrows():
        options = row["nationalite"].split(",")
        for option in options:
            option = option.strip()
            citizenship_list.append(option)
            
            #citizenship_uri = find_country(option)
            #citizenship_uri_list.append(citizenship_uri)

    out_frame = pd.DataFrame({"name" : citizenship_list})
    #out_frame = pd.DataFrame({"citizenship" : citizenship_list, "wikidata_uri" :  citizenship_uri_list })
    out_frame = out_frame.drop_duplicates()
    out_frame["id"] = generate_ids(len(out_frame)) 
    return out_frame

def make_rank_table(raw_frame : pd.DataFrame) -> pd.DataFrame:
   
    #out_frame = raw_frame[["gradeMilitaireMax_French", "gradeMilitaireMax_German", "french_rank_uri", "german_rank_uri"]]
    out_frame = raw_frame[["gradeMilitaireMax_French", "gradeMilitaireMax_German", "gradeMilitaireMax"]]
    out_frame = out_frame.rename(columns={"gradeMilitaireMax" : "orginal_rank_value", "gradeMilitaireMax_French": "french_rank", "gradeMilitaireMax_German": "german_rank"})
    out_frame = out_frame.dropna(subset=["french_rank", "german_rank"], how="all")
    out_frame = out_frame.drop_duplicates()
    out_frame["id"] = generate_ids(len(out_frame)) 
    return out_frame

def insert_rank_id(row: pd.Series, french_rank_list : List, german_rank_list : List, rank_frame : pd.DataFrame, rank_ids : List):

    if not pd.isna(row["gradeMilitaireMax_French"]) and row["gradeMilitaireMax_French"] in french_rank_list:
        rank = row["gradeMilitaireMax_French"]
        rank_id = rank_frame.loc[rank_frame['french_rank'] == rank]["id"].values[0]
        rank_ids.append(rank_id)
    elif not pd.isna(row["gradeMilitaireMax_German"]) and row["gradeMilitaireMax_German"] in german_rank_list:
        rank = row["gradeMilitaireMax_German"]
        rank_id = rank_frame.loc[rank_frame['german_rank'] == rank]["id"].values[0]
        rank_ids.append(rank_id)
    else:
        rank_ids.append(None)
    

def make_person_table(raw_frame : pd.DataFrame, rank_frame : pd.DataFrame, birth_place_frame : pd.DataFrame) -> pd.DataFrame:

    raw_frame["rank_id"] = "" 
    raw_frame["birth_place_id"] = ""

    rank_ids = []
    birth_place_ids = []

    birth_place_list = list(birth_place_frame["name"])
    french_rank_list = list(rank_frame["french_rank"]) 
    german_rank_list = list(rank_frame["german_rank"])

    for i, row in raw_frame.iterrows():
        if row["lieuNaissance"] in birth_place_list:
            birth_place = row["lieuNaissance"]
            birth_place_id = birth_place_frame.loc[birth_place_frame['name'] == birth_place]["id"].values[0]
            birth_place_ids.append(birth_place_id)
        else:
            birth_place_ids.append(None)

        insert_rank_id(row, french_rank_list, german_rank_list, rank_frame, rank_ids)

    raw_frame["rank_id"] = rank_ids
    raw_frame["birth_place_id"] = birth_place_ids

    out_frame = raw_frame.drop(['gradeMilitaireMax_French', 'gradeMilitaireMax', 'gradeMilitaireMax_German', 'cantonNaissance', 'notes' ,'lieuNaissance', 'nationalite'], axis=1)
    out_frame = out_frame.rename(columns={"nom": "name", "prenom" : "first_name", "naissance" : "birth_date", "lieuNaissance_orginal" : "uncleaned_birth_place_name"})

    return out_frame

def make_citizenship_relation_person(raw_frame : pd.DataFrame, citizen_table : pd.DataFrame):
    
    country_list = list(citizen_table["name"])

    table_info = { "citizenship_id" : [], "person_id" : [] }

    for i, row in raw_frame.iterrows():

        if row["nationalite"] in country_list:
            country = row["nationalite"]
            citizenship_id = citizen_table.loc[citizen_table['name'] == country]["id"].values[0]

            table_info["citizenship_id"].append(int(citizenship_id))
            table_info["person_id"].append(row["id"])

    return pd.DataFrame(table_info)


def to_sql_db(
    table_dict: dict[str, pd.DataFrame], sqlite_db_name: str 
):

    engine = create_engine(f"sqlite:///{sqlite_db_name}", echo=True)
    inspector = inspect(engine)
    if not inspector.has_table("person"):
        with Session(engine) as session:
            Base.metadata.create_all(engine)

    for table_name in table_dict:

        table_dict[table_name].to_sql(
            table_name, con=engine, if_exists="delete_rows", index=False
        )

