import pandas as pd
import matplotlib.pyplot as plt

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

chargeback_time_data = data[data['has_cbk'] == True]

plt.figure(figsize=(14, 7))
plt.plot(chargeback_time_data['transaction_date'], chargeback_time_data['transaction_amount'], 'ro', markersize=4)
plt.title('Chargebacks Over Time')
plt.xlabel('Date')
plt.ylabel('Transaction Amount ($)')
plt.grid(True)
plt.show()