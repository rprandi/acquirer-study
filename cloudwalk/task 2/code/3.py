
import pandas as pd
import matplotlib.pyplot as plt

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

data['transaction_date'] = pd.to_datetime(data['transaction_date'])

# Transacao x Tempo
plt.figure(figsize=(14, 7))
plt.plot(data['transaction_date'], data['transaction_amount'], marker='o', linestyle='', markersize=2)
plt.title('Transaction Amounts Over Time')
plt.xlabel('Date')
plt.ylabel('Transaction Amount ($)')
plt.grid(True)
plt.show()

user_transaction_count = data['user_id'].value_counts()
merchant_transaction_count = data['merchant_id'].value_counts()

# Distribuicoes
fig, ax = plt.subplots(1, 2, figsize=(14, 6))

ax[0].hist(user_transaction_count, bins=30, color='blue', alpha=0.7)
ax[0].set_title('Distribution of Transactions per User')
ax[0].set_xlabel('Number of Transactions')
ax[0].set_ylabel('Frequency')

ax[1].hist(merchant_transaction_count, bins=30, color='green', alpha=0.7)
ax[1].set_title('Distribution of Transactions per Merchant')
ax[1].set_xlabel('Number of Transactions')
ax[1].set_ylabel('Frequency')

plt.tight_layout()
plt.show()
