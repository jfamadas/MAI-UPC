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

mse_mat = np.load('results/mse_varsites3.npy')
r2_mat = np.load('results/r2_9vars12.npy')


x = ['0.0', '0.25', '0.50', '0.75', '0.9']
y = ['1 | 32', '1 | 64', '2 | 64', '2 | 128', '3 | 128', '3 | 256', '4 | 256', '4 | 512']

# plt.matshow(r2_mat)
# plt.colorbar()
# plt.xticks(range(len(x)), x, fontsize=10)
# plt.yticks(range(len(y)), y, fontsize=10)
# plt.xlabel('dropout')
# plt.ylabel('#layers | #neurons')

plt.matshow(mse_mat, vmin=0.17, vmax=0.195)
# plt.matshow(mse_mat)
plt.colorbar()
plt.xticks(range(len(x)), x, fontsize=10)
plt.yticks(range(len(y)), y, fontsize=10)
#plt.xlabel('dropout')
#plt.ylabel('#layers | #neurons')


plt.show()