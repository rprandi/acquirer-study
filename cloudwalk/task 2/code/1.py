#Apenas printa as primeiras linhas

import pandas as pd

file_path = '../fraud.csv'
data = pd.read_csv(file_path)


print(data.head())