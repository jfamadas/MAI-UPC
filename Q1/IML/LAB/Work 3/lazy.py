import numpy as np
import sklearn
import scipy
import matplotlib.pyplot as plt

from parserLazy import parser
from datasets import *

num_folds = 10
dataset_name = 'audiology'

path = 'datasetsCBR\\'+dataset_name+'\\'+dataset_name+'.fold.00000'

'''
STEP 1: NEW PARSER --- DONE

'''


for i in range(num_folds):

    train_data, train_classes = parser(path+str(i)+'.train.arff')
    test_data, test_classes = parser(path + str(i) + '.test.arff')



print('final')