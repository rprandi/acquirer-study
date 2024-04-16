
import pandas as pd

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

numerical_summary = data.describe()
missing_data = data.isnull().sum()

print(numerical_summary, missing_data)