import pandas as pd
from keras.models import Sequential
from keras.layers import Dense

df = pd.read_csv("/Users/jonasmiosga/Desktop/kicktipp_odds/df_nn.csv")
print(df)
