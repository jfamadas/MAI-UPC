import numpy as np
import os
import tensorflow as tf
from keras.datasets import cifar10


####################################
#          DATA LOADING            #
####################################

# Load the data
(x_train, y_train), (x_test, y_test) = cifar10.load_data()

# Convert the train set into train and validation
#   40k train
#   10k validation
#   10k test
data_train = x_train[:40000,:,:,:]
data_validation = x_train[40000:,:,:,:]
data_test = x_test

# Convert the labels into one-hot encoding
labels_train_validation = np.zeros([y_train.shape[0], 10])
labels_test = np.zeros([y_test.shape[0], 10])

for i, label in enumerate(y_train):
    labels_train_validation[i, label] = 1

labels_train = labels_train_validation[:40000,:]
labels_validation = labels_train_validation[40000:,:]

for i, label in enumerate(y_test):
    labels_test[i, label] = 1

# Class names
labels_text = ['Airplane', 'Automobile', 'Bird', 'Cat', 'Deer', 'Dog', 'Frog', 'Horse', 'Ship', 'Truck']
#     0 - Airplane
#     1 - Automobile
#     2 - Bird
#     3 - Cat
#     4 - Deer
#     5 - Dog
#     6 - Frog
#     7 - Horse
#     8 - Ship
#     9 - Truck


sess = tf.InteractiveSession()


export_dir = os.getcwd() + '\\model_basic\\';

tf.saved_model.loader.load(sess,tags='training',export_dir=export_dir)


x = sess.graph.get_tensor_by_name('x:0')
y_real = sess.graph.get_tensor_by_name('y_real:0')

accuracy = sess.graph.get_tensor_by_name('accuracy:0')


print(accuracy.eval(feed_dict={x: data_train[:10000, :, :, :], y_real: labels_train[:10000, :]}))

