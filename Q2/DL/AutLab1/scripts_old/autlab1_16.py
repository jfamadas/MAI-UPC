import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
import time
from keras.datasets import cifar10
import os

start_time = time.time()


####################################
#          USEFUL FUNCTIONS        #
####################################

def W_init(shape,name):
    # Returns the weights with the input shape. Randomly initialized
    initial = tf.truncated_normal(shape, stddev=.1)
    return tf.Variable(initial,name=name)


def b_init(shape,name):
    # Returns the bias with the input shape. Initialized in .1
    initial = tf.constant(.1, shape=shape)
    return tf.Variable(initial,name=name)


def conv2d(x, W,name):
    # Convolves the tensor 'x' with the kernel 'W'
    return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='SAME',name=name)


def max_pool_2x2(x,name):
    # Performs a 2x2 max pooling with the tensor 'x'
    return tf.nn.max_pool(x, ksize=[1, 2, 2, 1],
                          strides=[1, 2, 2, 1], padding='SAME',name=name)


####################################
#          DATA LOADING            #
####################################

# Load the data
(x_train, y_train), (x_test, y_test) = cifar10.load_data()

# Convert the train set into train and validation
#   40k train
#   10k validation
#   10k test
data_train = x_train[:40000, :, :, :].astype('float32')/255.0
data_validation = x_train[40000:, :, :, :].astype('float32')/255.0
data_test = x_test.astype('float32')/255.0


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


####################################
#               CNN                #
####################################

# PLACEHOLDERS
x = tf.placeholder(tf.float32, shape=[None, 32, 32, 3], name='x')  # Input data
y_real = tf.placeholder(tf.float32, shape=[None, 10], name='y_real')  # Correct labels

# CONVOLUTIONAL + POOLING 1
W_conv1 = W_init([5, 5, 3, 32], name='W_conv1')
b_conv1 = b_init([32], name='b_conv1')

h_conv1 = tf.nn.relu(conv2d(x, W_conv1,name='conv2d') + b_conv1, name='h_conv1')  # shape [batch, 32, 32, 32]
h_pool1 = max_pool_2x2(h_conv1, name='h_pool1')  # shape [batch, 16, 16, 32]

# CONVOLUTIONAL + POOLING 2
W_conv2 = W_init([5, 5, 32, 64], name='W_conv2')
b_conv2 = b_init([64], name='b_conv2')

h_conv2 = tf.nn.relu(conv2d(h_pool1, W_conv2,name='conv2d') + b_conv2, name='h_conv2')  # shape [batch, 16, 16, 64]
h_pool2 = max_pool_2x2(h_conv2, name='h_pool2')  # shape [batch, 8, 8, 64]

# FULLY CONNECTED 1
W_fc1 = W_init([int(np.prod(h_pool2.shape[1:])), 1024], name='W_fc1')
b_fc1 = b_init([1024], name='b_fc1')

# We have to reshape the output volume so it fits the FC layer
h_pool2_reshape = tf.reshape(h_pool2, [-1, int(np.prod(h_pool2.shape[1:]))], name='h_pool2_reshape')
h_fc1 = tf.nn.relu(tf.matmul(h_pool2_reshape, W_fc1) + b_fc1, name='h_fc1')

# OUTPUT LAYER
W_fc2 = W_init([1024, 10], name='W_fc2')
b_fc2 = b_init([10], name='b_fc2')

labels_predict = tf.add(tf.matmul(h_fc1, W_fc2), b_fc2,name='labels_predict')

####################################
#      TRAINING PREPARATION        #
####################################

# Cost function
J = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=y_real, logits=labels_predict),name='J')

# Training algorithm
train_step = tf.train.AdamOptimizer(1e-4, name='train_step').minimize(J)

# Results preparation
correct_prediction = tf.equal(tf.argmax(y_real, 1), tf.argmax(labels_predict, 1), name='correct_prediction')
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32), name='accuracy')

####################################
#            TRAINING              #
####################################

sess = tf.InteractiveSession()
tf.global_variables_initializer().run()

batch_size = 16
num_epochs = 100

J_train = np.zeros([num_epochs])
J_validation = np.zeros([num_epochs])
acc_train = np.zeros([num_epochs])
acc_validation = np.zeros([num_epochs])

for epoch in range(num_epochs):
    auxidx = np.arange(data_train.shape[0])
    np.random.shuffle(auxidx)
    data_epoch = data_train[auxidx, :, :, :]
    labels_epoch = labels_train[auxidx, :]

    for it in range(int(np.divide(data_epoch.shape[0], batch_size))):
        idx = np.arange(it * batch_size, (it + 1) * batch_size)
        train_step.run(feed_dict={x: data_epoch[idx, :, :, :], y_real: labels_epoch[idx, :]})

    # Every epoch the cost function and error, with train and validation are computed
    J_train[epoch] = J_train[epoch] + J.eval(
        feed_dict={x: data_train[:10000, :, :, :], y_real: labels_train[:10000, :]})
    J_train[epoch] = J_train[epoch] + J.eval(
        feed_dict={x: data_train[10000:20000, :, :, :], y_real: labels_train[10000:20000, :]})
    J_train[epoch] = J_train[epoch] + J.eval(
        feed_dict={x: data_train[20000:30000, :, :, :], y_real: labels_train[20000:30000, :]})
    J_train[epoch] = J_train[epoch] + J.eval(
        feed_dict={x: data_train[30000:, :, :, :], y_real: labels_train[30000:, :]})
    J_validation[epoch] = J.eval(feed_dict={x: data_validation, y_real: labels_validation})

    acc_train[epoch] = acc_train[epoch] + 0.25 * accuracy.eval(
        feed_dict={x: data_train[:10000, :, :, :], y_real: labels_train[:10000, :]})
    acc_train[epoch] = acc_train[epoch] + 0.25 * accuracy.eval(
        feed_dict={x: data_train[10000:20000, :, :, :], y_real: labels_train[10000:20000, :]})
    acc_train[epoch] = acc_train[epoch] + 0.25 * accuracy.eval(
        feed_dict={x: data_train[20000:30000, :, :, :], y_real: labels_train[20000:30000, :]})
    acc_train[epoch] = acc_train[epoch] + 0.25 * accuracy.eval(
        feed_dict={x: data_train[30000:, :, :, :], y_real: labels_train[30000:, :]})
    acc_validation[epoch] = accuracy.eval(feed_dict={x: data_validation, y_real: labels_validation})

    print("Epoch " + str(epoch + 1) + ": Accuracy = " + str(acc_train[epoch] * 100) + "% \t J = " + str(J_train[epoch]))

dir = os.getcwd() + '\\variables\\';
np.save(dir + 'J_train_basic16.npy', J_train)
np.save(dir + 'acc_train_basic16.npy', acc_train)
np.save(dir + 'J_validation_basic16.npy', J_validation)
np.save(dir + 'acc_validation_basic16.npy', acc_validation)

# Save the model
export_dir = os.getcwd() + '\\model_basic16\\'
builder = tf.saved_model.builder.SavedModelBuilder(export_dir)

builder.add_meta_graph_and_variables(sess, tags='training')
builder.add_meta_graph(tags='serving')

builder.save()

print("\nElapsed time: " + str(time.time() - start_time))
