#!/usr/bin/env python
import tensorflow as tf
import numpy as np


# Model parameters
W = tf.Variable([.3], dtype=tf.float32)
b = tf.Variable([-.3], dtype=tf.float32)
# Model input and output
x = tf.placeholder(tf.float32)
linear_model = W * x + b
y = tf.placeholder(tf.float32)

# loss
loss = tf.reduce_sum(tf.square(linear_model - y)) # sum of the squares
# optimizer
# optimizer = tf.train.GradientDescentOptimizer(0.0025)
# optimizer = tf.train.AdamOptimizer(0.1)
optimizer = tf.train.RMSPropOptimizer(0.00025)

train = optimizer.minimize(loss)

# training data
x_train = [1, 2, 3, 4]
y_train = [0, -1, -2, -3]
# training loop
init = tf.global_variables_initializer()
sess = tf.Session()
sess.run(init) # reset values to wrong

curr_W, curr_b, curr_loss = sess.run([W, b, loss], {x: x_train, y: y_train})
# print("W: %s b: %s loss: %s"%(curr_W, curr_b, curr_loss))


J = [curr_loss]

for i in range(10000):
  sess.run(train, {x: x_train, y: y_train})
  curr_W, curr_b, curr_loss = sess.run([W, b, loss], {x: x_train, y: y_train})
  # print("W: %s b: %s loss: %s"%(curr_W, curr_b, curr_loss))
  J = np.concatenate((J,[curr_loss]))

np.save('results_ex1/rmsProp_000025_10.npy', J)
print('final')








