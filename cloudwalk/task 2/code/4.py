import pandas as pd

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

chargeback_data = data.groupby('has_cbk').agg(
    Count=('transaction_id', 'count'),
    Average_Amount=('transaction_amount', 'mean')
)

print(chargeback_data)

