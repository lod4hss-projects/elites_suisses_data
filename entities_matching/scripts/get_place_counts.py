import pandas as pd
import numpy as np

def main():

    person_df = pd.read_csv("person.csv")
    person_df = person_df["birth_place_id"]
    birth_place_id_counts = person_df.value_counts(sort = False)

    place_df = pd.read_csv("birth_place.csv", index_col="id").drop(columns=["lat", "long", "wikidata_uri"])

    place_df["frequency"] = np.nan

    for id, count in zip(birth_place_id_counts.keys(), birth_place_id_counts):
        place_df.at[int(id), "frequency"] = int(count)

    place_df.to_csv("birth_place_counts.csv")

if "__main__" == __name__ :

    main()
