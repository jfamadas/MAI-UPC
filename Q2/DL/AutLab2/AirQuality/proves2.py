from __future__ import print_function

from keras.models import Sequential, load_model
from keras.layers import Dense
from keras.layers import LSTM, GRU
from keras.optimizers import RMSprop
from keras.callbacks import TensorBoard, ModelCheckpoint
from sklearn.metrics import mean_squared_error, r2_score
import os
import tensorflow as tf
import json
import argparse
from time import time
import matplotlib.pyplot as plt
import numpy as np
from sklearn.preprocessing import StandardScaler

mse3 = np.load('results/mse_seq2seq3.npy')
mse6 = np.load('results/mse_seq2seq6.npy')
mse12 = np.load('results/mse_seq2seq12.npy')

x = np.arange(1, 11)
plt.plot(x, mse3[:10], label='window size = 3')
plt.plot(x, mse6[:10], label='window size = 6')
plt.plot(x, mse12[:10], label='window size = 12')
plt.xlabel('Steps ahead')
plt.ylabel('MSE')
plt.legend()
plt.show()