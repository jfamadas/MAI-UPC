import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
import time
from keras.datasets import cifar10
import os
import shutil

start_time = time.time()

# CURRENT MODEL
model = 'L2_drop-05-09_deep'

# L2 Regularization
l2_regularization = True
beta = .005

# Dropout
dropout_probability = .5  # Dropout in the Fully Connected layers // 1.0 means NO dropout
dropout_probability_q = .9  # Dropout in the Convolutional layers // 1.0 means NO dropout


####################################
#          USEFUL FUNCTIONS        #
####################################

def W_init(shape, name):
    # Returns the weights with the input shape. Randomly initialized
    stddev = np.sqrt(2 / np.prod(shape[:-1]))
    initial = tf.truncated_normal(shape, stddev=stddev)
    return tf.Variable(initial, name=name)


def b_init(shape, name):
    # Returns the bias with the input shape. Initialized in .1
    initial = tf.constant(0.0, shape=shape)
    return tf.Variable(initial, name=name)


def conv2d(x, W, name):
    # Convolves the tensor 'x' with the kernel 'W'
    return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='SAME', name=name)


def max_pool_2x2(x, name):
    # Performs a 2x2 max pooling with the tensor 'x'
    return tf.nn.max_pool(x, ksize=[1, 2, 2, 1],
                          strides=[1, 2, 2, 1], padding='SAME', name=name)


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

####################################
#         DATA AUGMENTATION        #
####################################

data_train_flip = np.flip(data_train, 2)
data_train = np.concatenate((data_train, data_train_flip), axis=0)

labels_train = np.concatenate((labels_train, labels_train), axis=0)

####################################
#               CNN                #
####################################

# PLACEHOLDERS
x = tf.placeholder(tf.float32, shape=[None, 32, 32, 3], name='x')  # Input data
y_real = tf.placeholder(tf.float32, shape=[None, 10], name='y_real')  # Correct labels
dropout_p = tf.placeholder(tf.float32)
dropout_q = tf.placeholder(tf.float32)

# CONVOLUTIONAL + POOLING 1
W_conv1 = W_init([5, 5, 3, 32], name='W_conv1')
b_conv1 = b_init([32], name='b_conv1')

h_conv1 = tf.nn.relu(conv2d(x, W_conv1, name='conv2d') + b_conv1, name='h_conv1')  # shape [batch, 32, 32, 32]
h_conv1_drop = tf.nn.dropout(h_conv1, dropout_q)
h_pool1 = max_pool_2x2(h_conv1_drop, name='h_pool1')  # shape [batch, 16, 16, 32]

# CONVOLUTIONAL + POOLING 2
W_conv2 = W_init([5, 5, 32, 64], name='W_conv2')
b_conv2 = b_init([64], name='b_conv2')

h_conv2 = tf.nn.relu(conv2d(h_pool1, W_conv2, name='conv2d') + b_conv2, name='h_conv2')  # shape [batch, 16, 16, 64]
h_conv2_drop = tf.nn.dropout(h_conv2, dropout_q)
h_pool2 = max_pool_2x2(h_conv2_drop, name='h_pool2')  # shape [batch, 8, 8, 64]

# CONVOLUTIONAL + POOLING 3
W_conv3 = W_init([5, 5, 64, 128], name='W_conv3')
b_conv3 = b_init([128], name='b_conv3')

h_conv3 = tf.nn.relu(conv2d(h_pool2, W_conv3, name='conv2d') + b_conv3, name='h_conv3')  # shape [batch, 8, 8, 128]
h_conv3_drop = tf.nn.dropout(h_conv3, dropout_q)
h_pool3 = max_pool_2x2(h_conv3_drop, name='h_pool3')  # shape [batch, 4, 4, 128]

# FULLY CONNECTED 1
W_fc1 = W_init([int(np.prod(h_pool3.shape[1:])), 1024], name='W_fc1')
b_fc1 = b_init([1024], name='b_fc1')

# We have to reshape the output volume so it fits the FC layer
h_pool3_reshape = tf.reshape(h_pool3, [-1, int(np.prod(h_pool3.shape[1:]))], name='h_pool3_reshape')
h_fc1 = tf.nn.relu(tf.matmul(h_pool3_reshape, W_fc1) + b_fc1, name='h_fc1')
h_fc1_drop = tf.nn.dropout(h_fc1, dropout_p)

# FULLY CONNECTED 2
W_fc2 = W_init([1024, 512], name='W_fc2')
b_fc2 = b_init([512], name='b_fc2')

h_fc2 = tf.nn.relu(tf.matmul(h_fc1_drop, W_fc2) + b_fc2, name='h_fc2')
h_fc2_drop = tf.nn.dropout(h_fc2, dropout_p)

# OUTPUT LAYER
W_fc3 = W_init([512, 10], name='W_fc3')
b_fc3 = b_init([10], name='b_fc3')

labels_predict = tf.add(tf.matmul(h_fc2_drop, W_fc3), b_fc3, name='labels_predict')

####################################
#      TRAINING PREPARATION        #
####################################

# Cost function
J = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=y_real, logits=labels_predict), name='J')
if l2_regularization:
    regul = tf.nn.l2_loss(W_conv1) + tf.nn.l2_loss(W_conv2) + tf.nn.l2_loss(W_conv3) + tf.nn.l2_loss(W_fc1) + \
            tf.nn.l2_loss(W_fc2) + tf.nn.l2_loss(W_fc3)
    J = tf.reduce_mean(J + beta * regul)

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

batch_size = 32
num_epochs = 50

J_train = np.zeros([num_epochs])
J_validation = np.zeros([num_epochs])
acc_train = np.zeros([num_epochs])
acc_validation = np.zeros([num_epochs])

best_acc = 0
best_epoch = 0

for epoch in range(num_epochs):
    auxidx = np.arange(data_train.shape[0])
    np.random.shuffle(auxidx)
    data_epoch = data_train[auxidx, :, :, :]
    labels_epoch = labels_train[auxidx, :]

    for it in range(int(np.divide(data_epoch.shape[0], batch_size))):
        idx = np.arange(it * batch_size, (it + 1) * batch_size)
        train_step.run(
            feed_dict={x: data_epoch[idx, :, :, :], y_real: labels_epoch[idx, :], dropout_p: dropout_probability, dropout_q: dropout_probability_q})

    # Every epoch the cost function and error, with train and validation are computed
    max_size = 10000
    steps = int(labels_train.shape[0] / max_size)
    for i in range(steps):
        J_train[epoch] = J_train[epoch] + J.eval(feed_dict={x: data_train[max_size * i:max_size * (i + 1), :, :, :],
                                                            y_real: labels_train[max_size * i:max_size * (i + 1), :],
                                                            dropout_p: 1.0, dropout_q: 1.0})
        acc_train[epoch] = acc_train[epoch] + 1 / steps * accuracy.eval(
            feed_dict={x: data_train[max_size * i:max_size * (i + 1), :, :, :],
                       y_real: labels_train[max_size * i:max_size * (i + 1), :], dropout_p: 1.0, dropout_q: 1.0})

    J_validation[epoch] = J.eval(feed_dict={x: data_validation, y_real: labels_validation, dropout_p: 1.0, dropout_q: 1.0})
    acc_validation[epoch] = accuracy.eval(feed_dict={x: data_validation, y_real: labels_validation, dropout_p: 1.0, dropout_q: 1.0})

    # This is in order to save the best model
    if acc_validation[epoch] > best_acc:
        best_acc = acc_validation[epoch]
        best_epoch = epoch

        export_dir = os.getcwd() + '\\model_' + model + '\\'
        # Erase the current best model
        if os.path.exists(export_dir):
            shutil.rmtree(export_dir)

        # Save the new best model
        builder = tf.saved_model.builder.SavedModelBuilder(export_dir)

        builder.add_meta_graph_and_variables(sess, tags='training')
        builder.add_meta_graph(tags='serving')

        builder.save()

    print("Epoch " + str(epoch + 1) + ": Accuracy = " + str(acc_train[epoch] * 100) + "% \t J = " + str(J_train[epoch]))

direct = os.getcwd() + '\\variables\\'
np.save(direct + 'J_train_' + model + '.npy', J_train)
np.save(direct + 'acc_train_' + model + '.npy', acc_train)
np.save(direct + 'J_validation_' + model + '.npy', J_validation)
np.save(direct + 'acc_validation_' + model + '.npy', acc_validation)

print("Best Model: Epoch" + str(best_epoch+1))
print("\nElapsed time: " + str(time.time() - start_time))