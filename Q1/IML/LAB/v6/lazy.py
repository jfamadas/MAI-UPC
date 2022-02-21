from __future__ import division
# import numpy as np
# import sklearn
# import scipy
import matplotlib.pyplot as plt
# from datasets import *
# from parserWork3_categorical import parserImproved
from parserWork3 import *
from kNNAlgorithms import *
import time
from scipy.stats import rankdata

print('Imports')
from tempfile import TemporaryFile
# import plotly.plotly as py
# import plotly.graph_objs as go
# import xlwt

# wb = xlwt.Workbook()
# currentSheet = 1
# excelRow = 1
# ws = wb.add_sheet('Sheet{}'.format(str(currentSheet)))
# ws = wb.create_sheet('Sheet{}'.format(str(currentSheet)))

########## PARSER PARAMETERS ####################
num_folds = 10
allDatasetNames = ['hepatitis', 'bal', 'grid', 'autos', 'satimage', 'pen-based', 'adult', 'audiology', 'soybean', 'vowel']
bestKhamming = [12, 1, 12, 1, 5, 7]
bestKeuclidean = [8, 11, 15, 1, 3, 1]
bestKcosine = [8, 13, 1, 1, 5, 1]
bestKcorrelation = [12, 3, 1, 1, 5, 1]
iniDataset = 4; endDataset = 7
datasetNames = allDatasetNames[iniDataset:endDataset]
bestKhamming = bestKhamming[iniDataset:endDataset]; bestKeuclidean = bestKeuclidean[iniDataset:endDataset]; bestKcosine = bestKcosine[iniDataset:endDataset]
bestKcorrelation = bestKcorrelation[iniDataset:endDataset]
# path = 'datasetsCBR\\'+dataset_name+'\\'+dataset_name+'.fold.00000'
# rang = 'posNeg' # all data retrieved from parser will be normalized between -1 and 1
rang = 'pos'    # all data retrieved from parser will be normalized between  0 and 1
#################################################

########## ALL KNN PARAMETERS ###################
########## POLICIES ###################
# 2 available policies (only change the result when there is a draw when associating instance label)
policies = ['msrc', 'voting']  # most similar retrieved case or give weights based on distances
policy = policies[1]

########## DISTANCE METRICS ###################
# distance_types=['euclidean', 'cityblock', 'sqeuclidean', 'cosine', 'correlation', 'hamming', 'jaccard', 'chebyshev', 'canberra', 'braycurtis', 'yule', 'matching', 'dice', 'kulsinski', 'minkowski', 'seuclidean'] #, 'mahalanobis'
# distance_types = ['hamming', 'cosine', 'correlation']
distance_types = ['hamming', 'euclidean', 'cosine', 'correlation']
# distance_types = ['euclidean']

########## DISTANCE WEIGHTED KNN PARAMETERS ###################
distWeight = 2  # distWeight = 0 don't give any priority, same as KNN. distWeight > 1 give more priority to nearest neighbours. distWeight < 1 give less priority to nearest neighbours.
#################################################

########## WEIGHTED KNN PARAMETERS ###################
weightMetrics = ['kBest', 'extraTrees', 'reliefF']  # Select the metric used to weight the features in the weightedKNNalgorithm
wMetric = weightMetrics[2]
#################################################

########## SELECTION KNN PARAMETERS ###################
# kFeatures = 4 # number of the most important features to remain when applying feature selecting
threshold = 0.5
types = ['filter', 'wrapper']
type = types[1]
searchDirections = ['SBS', 'SFS']
searchDirection = searchDirections[0]
selectMetrics = ['informationGain', 'distances', 'correlation', 'tree']  #, 'consistency', 'tree']  # Select the metric used to weight the features in the weightedKNNalgorithm
sMetric = selectMetrics[0]
#################################################

################## KNN ALGORITHMS ###################
algorithms = ['scikitKNN', 'KNN', 'featureWeightedKNN', 'featureSelectionKNN', 'distanceWeightedKNN']
algorithms = algorithms[1:4]
#################################################
# ws = wb.add_sheet('Sheet{}'.format(str('wM{}typ{}sd{}sM{}'.format(wMetric, type, searchDirection, selectMetrics))))
numNeigIni = 1; numNeigEnd = 1  # Set the min and max number of neighbours that would like to test

##################### PERFORMANCE METRICS ########################
# accuracy_total = np.zeros((len(algorithms), len(distance_types), numNeigEnd-numNeigIni+1, num_folds))
# precision_total = np.zeros((len(algorithms), len(distance_types), numNeigEnd-numNeigIni+1, num_folds))
# recall_total = np.zeros((len(algorithms), len(distance_types), numNeigEnd-numNeigIni+1, num_folds))
# f1_total = np.zeros((len(algorithms), len(distance_types), numNeigEnd-numNeigIni+1, num_folds))
# time_total = np.zeros((len(algorithms), len(distance_types), numNeigEnd-numNeigIni+1, num_folds))
testError = np.zeros((numNeigEnd-numNeigIni+1))
accuracy_total = np.zeros((len(algorithms), len(distance_types), num_folds))
precision_total = np.zeros((len(algorithms), len(distance_types), num_folds))
recall_total = np.zeros((len(algorithms), len(distance_types), num_folds))
f1_total = np.zeros((len(algorithms), len(distance_types), num_folds))
time_total = np.zeros((len(algorithms), len(distance_types), num_folds))

average_accuracy = np.zeros((len(distance_types), len(algorithms))); average_precision = np.zeros((len(distance_types), len(algorithms)))
average_recall = np.zeros((len(distance_types), len(algorithms))); average_f1 = np.zeros((len(distance_types), len(algorithms))); average_time = np.zeros((len(distance_types), len(algorithms)));


accuracyRank = np.zeros((numNeigEnd-numNeigIni+1, len(distance_types), len(datasetNames), len(algorithms)))
f1Rank = np.zeros((numNeigEnd-numNeigIni+1, len(distance_types), len(datasetNames), len(algorithms)))
timeRank = np.zeros((numNeigEnd-numNeigIni+1, len(distance_types), len(datasetNames), len(algorithms)))

# maxAccuracyIndex = np.zeros((len(distance_types), numNeigEnd-numNeigIni+1))
# maxPrecisionIndex = np.zeros((len(distance_types), numNeigEnd-numNeigIni+1))
# maxRecallIndex = np.zeros((len(distance_types), numNeigEnd-numNeigIni+1))
# maxF1Index = np.zeros((len(distance_types), numNeigEnd-numNeigIni+1))
# accuracy_var = np.zeros((len(distance_types), numNeigEnd-numNeigIni+1))
# min_time = np.zeros((len(distance_types), numNeigEnd-numNeigIni+1))
################# EVALUATION PARAMETERS #########################
# F = len(datasetNames) - 1; degreesOfFreedom = F * (len(algorithms) - 1)
currNeig = 0
# maxAccuracyIndex = [];maxPrecisionIndex = [];maxRecallIndex = [];maxF1Index = [];accuracy_var = []; min_time = []
print('Primera part')
for numNeig in range(numNeigIni, numNeigEnd + 1):
    # if numNeig % 2 != 0:  # Uncomment that block if only even numbers of neighbours would like to be used
    #     continue
    for datasetIndex in range(len(datasetNames)):
        path = 'datasetsCBR\\' + datasetNames[datasetIndex] + '\\' + datasetNames[datasetIndex] + '.fold.00000'

        for i in range(num_folds):
            # print ('fold {}'.format(i))
            # Loads the train and test data for the i-th fold
            # train_data, train_labels = parser(path + str(i) + '.train.arff', rang); test_data, test_labels = parser(path + str(i) + '.test.arff', rang)

            train_data, train_labels, test_data, test_labels = parserImproved(path + str(i) + '.train.arff', path + str(i) + '.test.arff', rang)
            """
            Perform each selected KNN algorithm variant for current number of neighbours
            """
            for j in range(len(distance_types)):
                if distance_types[j] is 'hamming':
                    numNeigEnd = bestKhamming[datasetIndex]
                elif distance_types is 'euclidean':
                    numNeigEnd = bestKeuclidean[datasetIndex]
                elif distance_types is 'cosine':
                    numNeigEnd = bestKcosine[datasetIndex]
                elif distance_types is 'correlation':
                    numNeigEnd = bestKcorrelation[datasetIndex]
                print ('distance_types {}'.format(distance_types[j]))
                times = []; corrects = []; precisions = []; recalls = []; f1scores = []
                if 'scikitKNN' in algorithms:
                    startTime = time.time()
                    correct, precision, recall, f1score = scikitKNNalgorithm(numNeig, train_data, train_labels, test_data, test_labels, distance_type=distance_types[j])
                    corrects.append(correct); precisions.append(precision); recalls.append(recall); f1scores.append(f1score); times.append(time.time() - startTime)
                    print ('scikitKNN done')
                if 'KNN' in algorithms:
                    startTime = time.time()
                    correct, precision, recall, f1score = kNNAlgorithm(numNeig, train_data, train_labels, test_data, test_labels, policy, distance_type=distance_types[j])
                    corrects.append(correct);precisions.append(precision);recalls.append(recall);f1scores.append(f1score);times.append(time.time() - startTime)
                    print ('KNN done')
                if 'featureWeightedKNN' in algorithms:
                    startTime = time.time()
                    correct, precision, recall, f1score, weightVector = weightedKNNalgorithm(numNeig, train_data, train_labels, test_data,test_labels, policy, wMetric, distance_type=distance_types[j])
                    corrects.append(correct); precisions.append(precision);recalls.append(recall);f1scores.append(f1score);times.append(time.time() - startTime)
                    print ('featureWeightedKNN done')
                if 'featureSelectionKNN' in algorithms:
                    startTime = time.time()
                    correct, precision, recall, f1score, selectedFeatures = selectionKNNalgorithm(numNeig, train_data, train_labels, test_data,test_labels, policy, sMetric, type, searchDirection, threshold, distance_type=distance_types[j])
                    corrects.append(correct);precisions.append(precision);recalls.append(recall);f1scores.append(f1score);times.append(time.time() - startTime)
                    print ('featureSelectionKNN done')
                if numNeig == numNeigIni and 'distanceWeightedKNN' in algorithms:
                    startTime = time.time()
                    correct, precision, recall, f1score = distanceWeightedkNNAlgorithm(numNeig, train_data, train_labels, test_data, test_labels, policy, distWeight, distance_type=distance_types[j])
                    corrects.append(correct); precisions.append(precision);recalls.append(recall);f1scores.append(f1score);times.append(time.time() - startTime)

                for ii in range(len(algorithms)):
                    accuracy_total[ii][j][i] = corrects[ii]
                    precision_total[ii][j][i] = precisions[ii]
                    recall_total[ii][j][i] = recalls[ii]
                    f1_total[ii][j][i] = f1scores[ii]
                    time_total[ii][j][i] = times[ii]

                    # accuracy_total[datasetIndex][ii][j][currNeig][i] = corrects[ii]
                    # precision_total[datasetIndex][ii][j][currNeig][i] = precisions[ii]
                    # recall_total[datasetIndex][ii][j][currNeig][i] = recalls[ii]
                    # f1_total[datasetIndex][ii][j][currNeig][i] = f1scores[ii]
                    # time_total[datasetIndex][ii][j][currNeig][i] = times[ii]

        for ii in range(len(algorithms)):  # average all folds results
            for j in range(len(distance_types)):
                average_accuracy[j,  ii] = np.mean(accuracy_total[ii, j, :])
                average_precision[j,  ii] = np.mean(precision_total[ii, j, :])
                average_recall[j,  ii] = np.mean(recall_total[ii, j, :])
                average_f1[j,  ii] = np.mean(f1_total[ii, j, :])
                average_time[j,  ii] = np.mean(time_total[ii, j, :])


                # average_accuracy[currNeig, j, datasetIndex, ii] = np.mean(accuracy_total[datasetIndex, ii, j, currNeig, :])
                # average_precision[currNeig, j, datasetIndex, ii] = (np.mean(precision_total[datasetIndex, ii, j, currNeig, :]))
                # average_recall[currNeig, j, datasetIndex, ii] = np.mean(recall_total[datasetIndex, ii, j, currNeig, :])
                # average_f1[currNeig, j, datasetIndex, ii] = np.mean(f1_total[datasetIndex, ii, j, currNeig, :])
                # average_time[currNeig, j, datasetIndex, ii] = np.mean(time_total[datasetIndex, ii, j, currNeig, :])

        # outfile = TemporaryFile()
        # np.save(outfile, x)

        for j in range(len(distance_types)):  # extract rankings
            accuracyRank[currNeig, j, datasetIndex, :] = rankdata(average_accuracy[j, :])
            f1Rank[currNeig, j, datasetIndex, :] = rankdata(average_f1[j, :])
            timeRank[currNeig, j, datasetIndex, :] = rankdata(1/average_time[j, :])

        # print('\n')
        for j in range(len(distance_types)):
            for ii in range(len(algorithms)):
                print('{:<15} dtset, {:^6} NN, {:^15}, {:^20} -> Avg accuracy: {:<5} precision: {:<5} recall: {:<5} F1-score: {:<5} Time: {}'.format(datasetNames[datasetIndex], numNeig, distance_types[j], algorithms[ii], round(average_accuracy[j, ii], 3),
                                                                                                                    round(average_precision[j, ii], 3), round(average_recall[j, ii], 3), round(average_f1[j, ii], 3), round(average_time[j, ii], 3)))

                # ws.write(excelRow, 1, '{} dtset, {} NN, {}, {} -> Avg accuracy: {} precision: {} recall: {} F1-score: {} Time: {}'.format(datasetNames[datasetIndex], numNeig, distance_types[j], algorithms[ii], round(average_accuracy[currNeig, j, datasetIndex, ii], 3),
                #                                                                                                     round(average_precision[currNeig, j, datasetIndex, ii], 3), round(average_recall[currNeig, j, datasetIndex, ii], 3), round(average_f1[currNeig, j, datasetIndex, ii], 3), round(average_time[currNeig, j, datasetIndex, ii], 3)))
                # excelRow += 1
    # contruct the table
    for j in range(len(distance_types)):
        print ('Accuracy ranking matrix using {}Neigbors and {} distance)'.format(numNeig, distance_types[j]))
        print (algorithms)
        for d in range(len(datasetNames)):
            print ('{} {}'.format(datasetNames[d], accuracyRank[currNeig, j, d, :]))
        print ('F1 score ranking matrix using {}Neigbors and {} distance)'.format(numNeig, distance_types[j]))
        print (algorithms)
        for d in range(len(datasetNames)):
            print ('{} {}'.format(datasetNames[d], f1Rank[currNeig, j, d, :]))
        print ('Cp. Time ranking matrix using {}Neigbors and {} distance)'.format(numNeig, distance_types[j]))
        print (algorithms)
        for d in range(len(datasetNames)):
            print ('{} {}'.format(datasetNames[d], timeRank[currNeig, j, d, :]))

    # maxAccuracyIndex = np.nanargmax(average_accuracy[currNeig, 0, 0, 0])
# maxPrecisionIndex.append(np.nanargmax(average_precision))
# maxRecallIndex.append(np.nanargmax(average_recall))
# maxF1Index.append(np.nanargmax(average_f1))
# accuracy_var.append(np.var(average_accuracy))
# min_time.append(np.nanargmin(average_time))
#
    # testError[currNeig] = str(1.0-average_accuracy[0, 0])

    currNeig += 1
#
# print('\nBEST ACHIEVED RESULTS')
# print('Best accuracy with   {}NN  ({}) = '.format(numNeig, distance_types[maxAccuracyIndex]) + str(average_accuracy[maxAccuracyIndex]))
# print('Best precision with  {}NN  ({}) = '.format(numNeig, distance_types[maxPrecisionIndex]) + str(average_precision[maxPrecisionIndex]))
# print('Best recall with     {}NN  ({}) = '.format(numNeig, distance_types[maxRecallIndex]) + str(average_recall[maxRecallIndex]))
# print('Best f1 score with   {}NN  ({}) = '.format(numNeig, distance_types[maxF1Index]) + str(average_f1[maxF1Index]))
# print('')
# print('Accuracy variance    {}NN       = '.format(numNeig) + str(accuracy_var))
#
#
# plt.plot(testError, range(numNeigIni, numNeigEnd))
# plt.ylabel('test error')
# plt.xlabel('knn')
# plt.show()
# print('\nfinal')

# wb.save('lazyResults.xls')