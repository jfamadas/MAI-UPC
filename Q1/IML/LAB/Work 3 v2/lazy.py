from __future__ import division
import numpy as np
import sklearn
import scipy
import matplotlib.pyplot as plt

from parserLazy import parser
from datasets import *
from parserDefinitiveWork1 import parserWork1
from kNNAlgorithm import kNNAlgorithm
from auxiliarMethods import distance
'''
STEP 1: ATENCION: CAMBIO DE PARSER (AL DE LA PRACTICA 1 MODIFICADO
        -> INTERESA GUARDAR ALGUNOS ATRIBUTOS COMO NOMINALES [ALVARO]
'''

num_folds = 10
dataset_name = 'hepatitis'
path = 'datasetsCBR\\'+dataset_name+'\\'+dataset_name+'.fold.00000'


numNeig = 3
correct_total = np.array([0,0,0])
test_size_total = np.array([0,0,0])

for i in range(num_folds):

    # Loads the train and test data for the i-th fold
    train_data, train_labels = parserWork1(path + str(i) + '.train.arff')
    test_data, test_labels = parserWork1(path + str(i) + '.test.arff')

    """
    AHORA AQUI REALIZAR KNN (Se realiza un total de 10 veces)
    """
    correct, test_size = kNNAlgorithm(numNeig, train_data, train_labels, test_data, test_labels, distance_type='Manhattan')
    correct_total[0] += correct
    test_size_total[0] += test_size

    correct, test_size = kNNAlgorithm(numNeig, train_data, train_labels, test_data, test_labels, distance_type='Euclidean')
    correct_total[1] += correct
    test_size_total[1] += test_size

    correct, test_size = kNNAlgorithm(numNeig, train_data, train_labels, test_data, test_labels, distance_type='Cosine')
    correct_total[2] += correct
    test_size_total[2] += test_size


average_accuracy = correct_total/test_size_total

print('\n\n')
print('Avegare accuracy (Manhattan) = '+str(average_accuracy[0]))
print('Avegare accuracy (Euclidean) = '+str(average_accuracy[1]))
print('Avegare accuracy (Cosine)    = '+str(average_accuracy[2]))

print('\nfinal')