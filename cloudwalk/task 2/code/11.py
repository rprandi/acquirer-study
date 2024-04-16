import pandas as pd

file_path = '../fraud.csv'
data = pd.read_csv(file_path)
chargebacks = data[data['has_cbk'] == True]

chargeback_cards = chargebacks['card_number']

chargebacks_per_card = chargeback_cards.value_counts()

print(chargebacks_per_card.describe(), chargebacks_per_card.head(10))