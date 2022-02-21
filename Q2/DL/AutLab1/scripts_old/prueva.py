from __future__ import division
import keras
#print 'Using Keras version', keras.__version__
from keras.datasets import mnist

import time

start_time = time.time()

#Load the MNIST dataset, already provided by Keras
(x_train, y_train), (x_test, y_test) = mnist.load_data()

#Check sizes of dataset
#print 'Number of train examples', x_train.shape[0]
#print 'Size of train examples', x_train.shape[1:]

#Normalize data
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train = x_train / 255
x_test = x_test / 255

#Adapt the labels to the one-hot vector syntax required by the softmax
from keras.utils import np_utils
y_train = np_utils.to_categorical(y_train, 10)
y_test = np_utils.to_categorical(y_test, 10)

#Find which format to use (depends on the backend), and compute input_shape
from keras import backend as K
#MNIST resolution
img_rows, img_cols = 28, 28

#Depending on the version of Keras, two different sintaxes are used to specify the ordering
###Keras 1.X (as in MinoTauro)
#K.image_dim_ordering == 'tf' or 'theano'
###Keras 2.X (probably in your local installation)
#K.image_data_format == 'channels_first' or 'channels_last'
#

if K.image_data_format() == 'channels_first':
    x_train = x_train.reshape(x_train.shape[0], 1, img_rows, img_cols)
    x_test = x_test.reshape(x_test.shape[0], 1, img_rows, img_cols)
    input_shape = (1, img_rows, img_cols)
else:
    x_train = x_train.reshape(x_train.shape[0], img_rows, img_cols, 1)
    x_test = x_test.reshape(x_test.shape[0], img_rows, img_cols, 1)
    input_shape = (img_rows, img_cols, 1)

#Define the NN architecture
from keras.models import Sequential
from keras.layers import Dense, Activation, Conv2D, MaxPooling2D, Flatten
#Two hidden layers
nn = Sequential()
nn.add(Conv2D(32, 3, 3, activation='relu', input_shape=input_shape))
nn.add(MaxPooling2D(pool_size=(2, 2)))
nn.add(Conv2D(64, 3, 3, activation='relu'))
nn.add(MaxPooling2D(pool_size=(2, 2)))
nn.add(Flatten())
nn.add(Dense(128, activation='relu'))
nn.add(Dense(10, activation='softmax'))

#Model visualization
#We can plot the model by using the ```plot_model``` function. We need to install *pydot, graphviz and pydot-ng*.
#from keras.util import plot_model
#plot_model(nn, to_file='nn.png', show_shapes=true)

#Compile the NN
nn.compile(optimizer='sgd',loss='categorical_crossentropy',metrics=['accuracy'])

#Start training using a 15% for validation
history = nn.fit(x_train,y_train,batch_size=128,nb_epoch=20, validation_split=0.15)

#Evaluate the model with test set
score = nn.evaluate(x_test, y_test, verbose=0)
print('test loss:', score[0])
print('test accuracy:', score[1])

##Store Plots
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
#Accuracy plot
plt.plot(history.history['acc'])
plt.plot(history.history['val_acc'])
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
#No validation loss in this example
plt.legend(['train','val'], loc='upper left')
plt.savefig('model_accuracy.pdf')
plt.close()
#Loss plot
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('model loss')
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train','val'], loc='upper left')
plt.savefig('model_loss.pdf')

#Confusion Matrix
#from sklearn.metrics import classification_report,confusion_matrix
#import numpy as np
#Compute probabilities
#Y_pred = nn.predict(x_test)
#Assign most probable label
#y_pred = np.argmax(Y_pred, axis=1)

#Plot statistics
#print 'Analysis of results'
#target_names = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
#print(classification_report(np.argmax(y_test,axis=1), y_pred,target_names=target_names))
#print(confusion_matrix(np.argmax(y_test,axis=1), y_pred))

#Saving model and weights
#from keras.models import model_from_json
#nn_json = nn.to_json()
#with open('nn.json', 'w') as json_file:
#    json_file.write(nn_json)
#weights_file = "weights-MNIST_"+str(score[1])+".hdf5"
#nn.save_weights(weights_file,overwrite=True)

#Loading model and weights
#json_file = open('nn.json','r')
#nn_json = json_file.read()
#json_file.close()
#nn = model_from_json(nn_json)
#nn.load_weights(weights_file)



print("\nElapsed time: " + str(time.time() - start_time))