import uuid
from typing import Dict, List, Tuple

import sqlalchemy
from sqlalchemy import create_engine, inspect
from sqlalchemy.dialects.postgresql import insert

import pandas as pd
import numpy as np

from sqlalchemy_classes import *
#from sparql import find_location

def make_birth_place_table(raw_frame : pd.DataFrame) -> pd.DataFrame:
    
    out_frame = raw_frame[["cantonNaissance", "lieuNaissance"]]
    out_frame = out_frame.rename(columns={"lieuNaissance": "birth_place", "cantonNaissance" : "birth_canton"})
    out_frame = out_frame.dropna()
    out_frame = out_frame.drop_duplicates()
    out_frame["id"] = list(range(len(out_frame)))

    return out_frame

def make_citizenship_place_table(raw_frame : pd.DataFrame) -> pd.DataFrame:
    
    out_frame = raw_frame[["nationalite"]]
    out_frame = out_frame.rename(columns={"nationalite": "citizenship"})
    out_frame = out_frame.dropna()
    out_frame = out_frame.drop_duplicates()
    out_frame["id"] = list(range(len(out_frame)))

    return out_frame

def make_rank_table(raw_frame : pd.DataFrame) -> pd.DataFrame:
    
    out_frame = raw_frame[["gradeMilitaireMax"]]
    out_frame = out_frame.rename(columns={"gradeMilitaireMax": "rank"})
    out_frame = out_frame.dropna()
    out_frame = out_frame.drop_duplicates()
    out_frame["id"] = list(range(len(out_frame)))

    return out_frame

def make_person_table(raw_frame : pd.DataFrame, rank_frame : pd.DataFrame, birth_place_frame : pd.DataFrame) -> pd.DataFrame:

    raw_frame["rank_id"] = np.nan 
    raw_frame["birth_place_id"] = np.nan

    rank_ids = []
    birth_place_ids = []

    birth_place_list = list(birth_place_frame["birth_place"])
    rank_list = list(rank_frame["rank"])
    
    for i, row in raw_frame.iterrows():
        if row["lieuNaissance"] in birth_place_list:
            birth_place = row["lieuNaissance"]
            birth_place_id = birth_place_frame.loc[birth_place_frame['birth_place'] == birth_place]["id"].values[0]
            birth_place_ids.append(birth_place_id)
        else:
            birth_place_ids.append(None)


        if row["gradeMilitaireMax"] in rank_list:
            rank = row["gradeMilitaireMax"]
            rank_id = rank_frame.loc[rank_frame['rank'] == rank]["id"].values[0]
            rank_ids.append(rank_id)
        else:
            rank_ids.append(None)

    raw_frame["rank_id"] = rank_ids
    raw_frame["birth_place_id"] = birth_place_ids

    out_frame = raw_frame.drop(['gradeMilitaireMax', 'cantonNaissance', 'lieuNaissance', 'nationalite'], axis=1)

    return out_frame

def make_citizenship_relation_person(raw_frame : pd.DataFrame, citizen_table : pd.DataFrame):
    
    country_list = list(citizen_table["citizenship"])

    table_info = { "citizenship_id" : [], "person_id" : [] }

    for i, row in raw_frame.iterrows():

        if row["nationalite"] in country_list:
            country = row["nationalite"]
            citizenship_id = citizen_table.loc[citizen_table['citizenship'] == country]["id"].values[0]
            table_info["citizenship_id"].append(citizenship_id)
            table_info["person_id"].append(row["id"])

    return pd.DataFrame(table_info)

def get_or_create_sql(sqlite_db_name: str) -> sqlalchemy.Engine:
    engine = create_engine(f"sqlite:///{sqlite_db_name}")
    
    inspector = inspect(engine)
    if not inspector.has_table("person"):
       Base.metadata.create_all(engine)
    
    return engine

def to_sql_db(
    table_dict: dict[str, pd.DataFrame], db_engine: sqlalchemy.Engine
):
    # Creates a new sqlite database if none exist already
    # Otherwise append data  to the existing database

    for table_name in table_dict:

        table_dict[table_name].to_sql(
            table_name, con=db_engine, if_exists="replace", index=False
        )

