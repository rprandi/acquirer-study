import pandas as pd
import matplotlib.pyplot as plt

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

data['transaction_date'] = pd.to_datetime(data['transaction_date'])

chargebacks = data[data['has_cbk'] == True]

chargebacks['transaction_hour'] = chargebacks['transaction_date'].dt.hour

chargeback_distribution = chargebacks['transaction_hour'].value_counts().sort_index()

chargeback_distribution

plt.figure(figsize=(12, 6))
chargeback_distribution.plot(kind='bar', color='skyblue')
plt.title('Distribuição de Chargebacks por Hora do Dia')
plt.xlabel('Hora do Dia')
plt.ylabel('Número de Chargebacks')
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.xticks(rotation=0)
plt.show()