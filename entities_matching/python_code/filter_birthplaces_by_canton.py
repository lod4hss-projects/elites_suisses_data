import pandas as pd

canton = "Etranger"
limit = 2

cleaned_rank_frame = pd.read_csv("birth-places-citizenship-military-grades-cleaned.csv")
cleaned_rank_frame = cleaned_rank_frame[["lieuNaissance", "cantonNaissance"]][ cleaned_rank_frame["cantonNaissance"] == canton]
place_count = cleaned_rank_frame.value_counts("lieuNaissance")

place_count = place_count[place_count >= 2]
place_count_names = place_count.keys()

df = pd.read_csv("birth_place.csv", index_col="id")
df = df[ df.apply(lambda row : row["name"] in place_count_names, axis=1)]
df.to_csv(f"birth_place_{canton}_{limit}.csv")

