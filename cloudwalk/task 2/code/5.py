import pandas as pd
import matplotlib.pyplot as plt

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

chargeback_data = data.groupby('has_cbk').agg(
    Count=('transaction_id', 'count'),
    Average_Amount=('transaction_amount', 'mean')
)

chargeback_by_user = data[data['has_cbk'] == True]['user_id'].value_counts()
chargeback_by_merchant = data[data['has_cbk'] == True]['merchant_id'].value_counts()

# Plotting the chargeback distribution by user and merchant
fig, ax = plt.subplots(1, 2, figsize=(14, 6))

ax[0].hist(chargeback_by_user, bins=30, color='red', alpha=0.7)
ax[0].set_title('Distribution of Chargebacks per User')
ax[0].set_xlabel('Number of Chargebacks')
ax[0].set_ylabel('Frequency')

ax[1].hist(chargeback_by_merchant, bins=30, color='orange', alpha=0.7)
ax[1].set_title('Distribution of Chargebacks per Merchant')
ax[1].set_xlabel('Number of Chargebacks')
ax[1].set_ylabel('Frequency')

plt.tight_layout()
plt.show()