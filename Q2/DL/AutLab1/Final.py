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
data_train = x_train[:40000, :, :, :].astype('float32') / 255.0
mean = np.mean(data_train)
data_train = data_train - mean
data_validation = x_train[40000:, :, :, :].astype('float32') / 255.0 - mean
data_test = x_test.astype('float32') / 255.0 - mean

# Convert the labels into one-hot encoding
labels_train_validation = np.zeros([y_train.shape[0], 10])
labels_test = np.zeros([y_test.shape[0], 10])

for i, label in enumerate(y_train):
    labels_train_validation[i, label] = 1

labels_train = labels_train_validation[:40000, :]
labels_validation = labels_train_validation[40000:, :]

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


export_dir = os.getcwd() + '\\model_L2_0005-drop_08_09\\'

tf.saved_model.loader.load(sess,tags='training',export_dir=export_dir)


x = sess.graph.get_tensor_by_name('x:0')
y_real = sess.graph.get_tensor_by_name('y_real:0')
dropout_p = sess.graph.get_tensor_by_name('Placeholder:0')
dropout_q = sess.graph.get_tensor_by_name('Placeholder_1:0')

accuracy = sess.graph.get_tensor_by_name('accuracy:0')
J = sess.graph.get_tensor_by_name('J:0')


print('Training accuracy: = ' + str(100*accuracy.eval(feed_dict={x: data_train[:10000, :, :, :], y_real: labels_train[:10000, :], dropout_p: 1.0, dropout_q: 1.0})))
print('Validation accuracy: = ' + str(100*accuracy.eval(feed_dict={x: data_validation, y_real: labels_validation, dropout_p: 1.0, dropout_q: 1.0})))
print('Test accuracy: = ' + str(100*accuracy.eval(feed_dict={x: data_test, y_real: labels_test, dropout_p: 1.0, dropout_q: 1.0})))


print('Training J: = ' + str(J.eval(feed_dict={x: data_train[:10000, :, :, :], y_real: labels_train[:10000, :], dropout_p: 1.0, dropout_q: 1.0})))
print('Validation J: = ' + str(J.eval(feed_dict={x: data_validation, y_real: labels_validation, dropout_p: 1.0, dropout_q: 1.0})))
print('Test J: = ' + str(J.eval(feed_dict={x: data_test, y_real: labels_test, dropout_p: 1.0, dropout_q: 1.0})))