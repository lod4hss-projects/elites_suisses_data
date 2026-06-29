import pandas as pd

orgine_sheet = "birth-place-settlements-reced.csv"
reduced_sheet = "birth-place-Etranger-2-reced.csv"

orgine_frame = pd.read_csv(orgine_sheet, index_col="id")
reduced_sheet = pd.read_csv(reduced_sheet, index_col="id")

for i, row in reduced_sheet.iterrows():
    print("#####")
    print(orgine_frame.iloc[int(i - 1)])
    print(row)

orgine_frame.to_csv("mixed_sheet")

