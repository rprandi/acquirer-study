import pandas as pd
import matplotlib.pyplot as plt

file_path = '../fraud.csv'
data = pd.read_csv(file_path)

data['transaction_date'] = pd.to_datetime(data['transaction_date'])
chargebacks = data[data['has_cbk'] == True]

chargeback_devices = chargebacks['device_id']

chargebacks_per_device = chargeback_devices.value_counts()

print(chargebacks_per_device.describe(), chargebacks_per_device.head(10))