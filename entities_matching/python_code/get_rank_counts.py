import pandas as pd
import numpy as np

def main():

    person_df = pd.read_csv("person.csv")
    print(len(person_df))
    rank_id_counts = person_df.value_counts("rank_id", sort = False)
    print(len(rank_id_counts))

    rank_df = pd.read_csv("rank.csv", index_col="id")

    rank_df["frequency"] = np.nan

    for id, count in zip(rank_id_counts.keys(), rank_id_counts):
        rank_df.at[int(id), "frequency"] = count 

    rank_df.to_csv("rank_counts.csv")

if "__main__" == __name__ :

    main()
