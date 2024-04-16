import pandas as pd
import matplotlib.pyplot as plt

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

data['transaction_date'] = pd.to_datetime(data['transaction_date'])

unique_devices = data['device_id'].nunique()

transactions_per_device = data['device_id'].value_counts()

devices_multiple_transactions = transactions_per_device[transactions_per_device > 1].count()

print(unique_devices, devices_multiple_transactions)