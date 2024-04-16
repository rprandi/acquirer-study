import pandas as pd

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

data['transaction_date'] = pd.to_datetime(data['transaction_date'])

unique_cards = data['card_number'].nunique()

transactions_per_card = data['card_number'].value_counts()

print(unique_cards, transactions_per_card.head(10))