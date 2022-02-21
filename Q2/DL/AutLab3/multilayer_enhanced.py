#!/usr/bin/env python
import tensorflow as tf
import read_inputs
import numpy as N
import time

starttime = time.time()

# read data from file
data_input = read_inputs.load_data_mnist('MNIST_data/mnist.pkl.gz')
# FYI data = [(train_set_x, train_set_y), (valid_set_x, valid_set_y), (test_set_x, test_set_y)]
data = data_input[0]
# //mean = N.mean(data)
# print ( N.shape(data[0][0])[0] )
# print ( N.shape(data[0][1])[0] )


# data layout changes since output should be an array of 10 with probabilities
real_output = N.zeros((N.shape(data[0][1])[0], 10), dtype=N.float)
for i in range(N.shape(data[0][1])[0]):
    real_output[i][data[0][1][i]] = 1.0

# data layout changes since output should be an array of 10 with probabilities
real_check = N.zeros((N.shape(data[2][1])[0], 10), dtype=N.float)
for i in range(N.shape(data[2][1])[0]):
    real_check[i][data[2][1][i]] = 1.0

# set up the computation. Definition of the variables.
x = tf.placeholder(tf.float32, [None, 784])
W = tf.Variable(tf.zeros([784, 10]))
y_ = tf.placeholder(tf.float32, [None, 10])


# declare weights and biases
def weight_variable(shape):
    stddev = N.sqrt(2 / N.prod(shape[:-1]))
    initial = tf.truncated_normal(shape, stddev=stddev)
    return tf.Variable(initial)


def bias_variable(shape):
    initial = tf.constant(0.0, shape=shape)
    return tf.Variable(initial)


# convolution and pooling
def conv2d(x, W):
    return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='SAME')


def max_pool_2x2(x):
    return tf.nn.max_pool(x, ksize=[1, 2, 2, 1],
                          strides=[1, 2, 2, 1], padding='SAME')


# First convolutional layer: 32 features per each 5x5 patch
W_conv1 = weight_variable([5, 5, 1, 32])
b_conv1 = bias_variable([32])

# Reshape x to a 4d tensor, with the second and third dimensions corresponding to image width and height.
# 28x28 = 784
# The final dimension corresponding to the number of color channels.
x_image = tf.reshape(x, [-1, 28, 28, 1])

# We convolve x_image with the weight tensor, add the bias, apply the ReLU function, and finally max pool.
# The max_pool_2x2 method will reduce the image size to 14x14.

h_conv1 = tf.nn.relu(conv2d(x_image, W_conv1) + b_conv1)
h_pool1 = max_pool_2x2(h_conv1)

# Second convolutional layer: 64 features for each 5x5 patch.
W_conv2 = weight_variable([5, 5, 32, 64])
b_conv2 = bias_variable([64])

h_conv2 = tf.nn.relu(conv2d(h_pool1, W_conv2) + b_conv2)
h_pool2 = max_pool_2x2(h_conv2)

# Densely connected layer: Processes the 64 7x7 images with 1024 neurons
# Reshape the tensor from the pooling layer into a batch of vectors,
# multiply by a weight matrix, add a bias, and apply a ReLU.
W_fc1 = weight_variable([7 * 7 * 64, 1024])
b_fc1 = bias_variable([1024])

h_pool2_flat = tf.reshape(h_pool2, [-1, 7 * 7 * 64])
h_fc1 = tf.nn.relu(tf.matmul(h_pool2_flat, W_fc1) + b_fc1)

# drop_out
keep_prob = tf.placeholder(tf.float32)
h_fc1_drop = tf.nn.dropout(h_fc1, keep_prob)

# Readout Layer
W_fc2 = weight_variable([1024, 10])
b_fc2 = bias_variable([10])

y_conv = tf.matmul(h_fc1_drop, W_fc2) + b_fc2

# Crossentropy
cross_entropy = tf.reduce_mean(
    tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y_conv))

train_step = tf.train.AdamOptimizer(1e-4).minimize(cross_entropy)

correct_prediction = tf.equal(tf.argmax(y_conv, 1), tf.argmax(y_, 1))

accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    # TRAIN
    print("TRAINING")
    num_epochs = 15
    batch_size = 50

    acc_total = []

    for epoch in range(num_epochs):
        print('Epoch: ' + str(epoch))

        train_accuracy = accuracy.eval(feed_dict={x: data[2][0], y_: real_check, keep_prob: 1.0})
        print('test accuracy %g' % (train_accuracy))



        # Shuffles the dataset
        idx = N.arange(N.shape(data[0][0])[0])
        N.random.shuffle(idx)

        current_data = data[0][0][idx]
        current_ground_truth = real_output[idx]

        for i in range(int(N.shape(idx)[0]/batch_size)):
            # until 1000 96,35%
            batch_ini = 50 * i
            batch_end = 50 * i + 50

            batch_xs = current_data[batch_ini:batch_end]
            batch_ys = current_ground_truth[batch_ini:batch_end]

            if i % 1000 == 0:
                train_accuracy = accuracy.eval(feed_dict={
                    x: batch_xs, y_: batch_ys, keep_prob: 1.0})
                # print('step %d, training accuracy %g Batch [%d,%d]' % (i, train_accuracy, batch_ini, batch_end))

            train_step.run(feed_dict={x: batch_xs, y_: batch_ys, keep_prob: 0.5})
        acc_total = N.concatenate((acc_total, [accuracy.eval(feed_dict={x: data[2][0], y_: real_check, keep_prob: 1.0})]))

    N.save('results_ex3/accuracy_15epochs_initialization.npy', acc_total)
    # TEST
    print("TESTING")

    train_accuracy = accuracy.eval(feed_dict={x: data[2][0], y_: real_check, keep_prob: 1.0})
    print('test accuracy %g' % (train_accuracy))


print("Time = " + str(time.time() - starttime))