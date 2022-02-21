from __future__ import division
from cmath import sqrt
from collections import Counter
import re
import math
from math import log
import numpy as np
from scipy import spatial
from numpy import array
from sklearn.feature_selection import SelectKBest, chi2, RFE
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.datasets import make_classification
import random

"""SCRIPT FOR AUXILIAR FUNCTIONS"""

WORD = re.compile(r'\w+')

"""DISTANCES"""

def distance(instance1, instance2, weightVector, distance_type):
    distance = 0
    # den1 = 0
    cosine_vec1 = []
    cosine_vec2 = []
    for i in range(len(instance1)):
        try:
            # The i-th feature is numerical (if float() works)
            instance1[i] = float(instance1[i]) * weightVector[i]
            instance1[i] = float(instance2[i]) * weightVector[i]

            if distance_type == 'cityBlock': #== 'Manhattan'
                distance += abs(float(instance1[i]) - float(instance2[i]))

            elif distance_type == 'correlation':
                xm = mean(instance1); ym=mean(instance2); x = instance1[i];y = instance2[i]
                den1 = sqrt((x-xm)*np.transpose(x-xm));  den2 = sqrt((y-ym)*np.transpose(y-ym)); num = (x-xm)*np.transpose(y-ym)
                distance += 1-num/(den1*den2)

            elif distance_type == 'hamming':
                distance += int(instance1[i] == instance2[i])

            elif distance_type == 'euclidean':
                distance += abs(float(instance1[i]) - float(instance2[i])) ** 2

            elif distance_type == 'cosine':
                cosine_vec1.append(float(instance1[i]))
                cosine_vec2.append(float(instance2[i]))

        except:
            # The i-th feature is nominal (if float() does not work)
            if str(instance1[i]) == str(instance2[i]):
                pass
            else:
                distance += 1 * weightVector[i]

    # Post aggregation of distances
    if distance_type == 'euclidean':
        # It has performed the last iteration, so it makes the square root of the sum of distances
        distance = np.sqrt(distance)
        # distance = np.linalg.norm(instance1 - instance2)

    elif distance_type == 'StandardizedEuclidean':
        distance = distance

    elif distance_type == 'Mahalanobis':
        distance = distance

    elif distance_type == 'hamming':
        distance = np.sum(np.equal(instance1, instance2))/np.size(instance1)

    elif distance_type == 'correlation':
        distance = distance

    elif distance_type == 'Jaccard':
        intersection_cardinality = len(set.intersection(*[set(instance1), set(instance2)]))
        union_cardinality = len(set.union(*[set(instance1), set(instance2)]))
        distance = 1-intersection_cardinality / float(union_cardinality)

    elif distance_type == 'Minkowski':
        distance = distance

    elif distance_type == 'Chebychev':
        distance = max(np.abs(np.subtract(instance1, instance2)))

    elif distance_type == 'cosine':
        # Performs the cosine distance between the 2 cosine vectors and adds it to the distance
        cv1 = np.array(cosine_vec1)
        cv2 = np.array(cosine_vec2)
        cosin = np.dot(cv1, cv2)/(np.linalg.norm(cv1)*np.linalg.norm(cv2))
        distance = cosin

    return distance

def elementDistance(element1, element2, distance_type):
    try:
        # The i-th feature is numerical (if float() works)
        # float(element1)
        if distance_type == 'cityBlock': #== 'Manhattan'
            distance = abs(float(element1) - float(element2))

        elif distance_type == 'correlation':
            xm = mean(element1); ym=mean(element2); x = element1;y = element2
            den1 = sqrt((x-xm)*np.transpose(x-xm));  den2 = sqrt((y-ym)*np.transpose(y-ym)); num = (x-xm)*np.transpose(y-ym)
            distance = 1-num/(den1*den2)

        elif distance_type == 'hamming':
            distance = int(element1 == element2)

        elif distance_type == 'euclidean':
            distance = np.sqrt(abs(float(element1) - float(element2)) ** 2)

    except:
        if str(element1) == str(element2):  # The i-th feature is nominal (if float() does not work)
            distance = 0
        else:
            distance = 1

    return distance

# Measure the distance between two instances
def scipyDistance(instance1, instance2, distance_type):
    distance = 0
    instances=[]
    instances.append(instance1)
    instances.append(instance2)

    if distance_type == 'minkowski' or distance_type == 'seuclidean' or distance_type == 'mahalanobis':
        try:
            V = np.cov(instances)
            VI = np.linalg.inv(V)
            return spatial.distance.pdist(instances, distance_type, VI)
        except:
            return spatial.distance.pdist(instances, distance_type, VI=None)
        # It can perform minkowski, seuclidean, mahalanobis
    else:
        try:
            return spatial.distance.pdist(instances, distance_type)
        except:
            pass
        # It can perform euclidean, cityblock, sqeuclidean, cosine, correlation, hamming, jaccard, chebyshev, canberra,
        # braycurtis, mahalanobis, yule, matching, dice, kulsinski, ...


# Buscar el mas comun de una lista (para string)
def Most_Common(lst):
    data = Counter(lst)
    return data.most_common(1)[0][0]

# assign the label to an instance given the distances to other
def assignation(lst, dist, pol):
    # Find the most common value
    uniques, counts = np.unique(lst, return_counts=True)

    if list(counts).count(counts[np.argmax(counts)]) > 1:
        if pol == 'msrc': # in that case we break the draw assigning the label to the closest neighbour (min distance)
            mostcommon = lst[np.argmin(dist)]
        elif pol == 'voting':  # in that case we break the draw assigning the label to the closest neighbour
            votes = []
            for i in range(len(uniques)):
                votesEach = 0
                for j in range(len(lst)):
                    if uniques[i] == lst[j]:
                        votesEach += 1/dist[j]
                votes.append(votesEach)
            mostcommon = np.argmax(votes)
            mostcommon = uniques[mostcommon]
        else:
            mostcommon = uniques[np.argmax(counts)]
    else:
        mostcommon = uniques[np.argmax(counts)]

    return mostcommon


# Buscar la media de una lista (para numerico)
def mean(lst):
    counter = 0.0
    for i in range(0, len(lst)):
        counter += lst[i]
    # MEAN
    counter /= float(len(lst))
    return counter


def manhattan(instance1, instance2):
    for i in range(0, len(instance1)):
        distance = 0
        distance += abs(float(instance1[i]) - float(instance2[i]))
    return distance


def euclidean(instance1, instance2):
    distance = sqrt(sum([(xi - yi) ** 2 for xi, yi in zip(instance1, instance2)]))
    return distance


def distanceLevenshtein(str1, str2):
    longitud = len(str1)
    if len(str2) > longitud:
        longitud = len(str2)
    d = dict()
    for i in range(len(str1) + 1):
        d[i] = dict()
        d[i][0] = i
    for i in range(len(str2) + 1):
        d[0][i] = i
    for i in range(1, len(str1) + 1):
        for j in range(1, len(str2) + 1):
            d[i][j] = min(d[i][j - 1] + 1, d[i - 1][j] + 1, d[i - 1][j - 1] + (not str1[i - 1] == str2[j - 1]))
    return float((longitud - d[len(str1)][len(str2)]) / longitud)


# For cosine distance
def get_cosine(vec1, vec2):
    intersection = set(vec1.keys()) & set(vec2.keys())
    numerator = sum([vec1[x] * vec2[x] for x in intersection])

    sum1 = sum([vec1[x] ** 2 for x in vec1.keys()])
    sum2 = sum([vec2[x] ** 2 for x in vec2.keys()])
    denominator = math.sqrt(sum1) * math.sqrt(sum2)

    if not denominator:
        return 0.0
    else:
        return float(numerator) / denominator


# For cosine distance
def text_to_vector(text):
    words = WORD.findall(text)
    return Counter(words)

'''FEATURES WEIGHTING'''
def reliefF(train_data, train_labels, distance_type):
    m = int(len(train_data)/10)
    weightVec = np.ones(len(train_data[0]))

    for j in range(m):
        randomIndex = random.randint(0, len(train_data) - 1)
        randomInstance = train_data[randomIndex]
        randomInstanceLabel = train_labels[randomIndex]

        distances = []
        for trainInstance in train_data:
            # oneDistance = distance(trainInstance, randomInstance, np.ones(len(train_data[0])), distance_type=distance_type)
            # distances.append(oneDistance)
            distance = scipyDistance(trainInstance, randomInstance, distance_type='correlation')
            distances.append(distance[0])

        arrayDistance = array(distances)
        indexofmostlikely = np.argsort(arrayDistance)
        hitFound = False; missFound = False
        for index in indexofmostlikely:
            if train_labels[index] == randomInstanceLabel and hitFound is False and index != randomIndex:
                nearestHit = train_data[index]
                hitFound = True
            elif train_labels[index] != randomInstanceLabel and missFound is False:
                nearestMiss = train_data[index]
                missFound = True
            elif missFound and hitFound:
                break

        for i in range(len(train_data[0])):
            weightVec[i] = weightVec[i] - elementDistance(nearestHit[i], randomInstance[i], distance_type='cityBlock')**2/m + elementDistance(nearestMiss[i], randomInstance[i], distance_type='cityBlock')**2/m

    if np.abs(np.min(weightVec)) != np.min(weightVec):
        weightVec = weightVec + np.abs(np.min(weightVec))

    return weightVec

def featureWeighting(data, labels, metric, distance_type):
    if metric == 'kBest':  # feature weighting with kBest
        test = SelectKBest(score_func=chi2)
        fit = test.fit(data, labels)
        featureWeight = fit.scores_

    elif metric == 'extraTrees':  # feature weighting with extraTrees
        model = ExtraTreesClassifier()
        model.fit(data, labels)
        featureWeight = model.feature_importances_

    elif metric == 'reliefF':
        featureWeight = reliefF(data, labels, distance_type)

    # featureWeight = np.divide((featureWeight - np.min(featureWeight)), (np.max(featureWeight) - np.min(featureWeight)))
    # featureWeight = np.divide(featureWeight, sum(featureWeight))
    featureWeight = np.divide(featureWeight, np.max(featureWeight))

    return featureWeight

'''FEATURES SELECTING'''
# Calculates the entropy of the given data set for the target attribute.
def entropy(data, target_attr):
    val_freq = {}
    data_entropy = 0.0

    # Calculate the frequency of each of the values in the target attr
    for record in data:
        if (val_freq.has_key(record[target_attr])):
            val_freq[record[target_attr]] += 1.0
        else:
            val_freq[record[target_attr]] = 1.0

    # Calculate the entropy of the data for the target attribute
    for freq in val_freq.values():
        data_entropy += (-freq / len(data)) * math.log(freq / len(data), 2)

    return data_entropy
#
# # Calculates the information gain (reduction in entropy) that would result by splitting the data on the chosen attribute (attr).
def gain(data, attr, target_attr):
    val_freq = {}
    subset_entropy = 0.0

    # Calculate the frequency of each of the values in the target attribute
    for record in data:
        if (val_freq.has_key(record[attr])):
            val_freq[record[attr]] += 1.0
        else:
            val_freq[record[attr]] = 1.0

    # Calculate the sum of the entropy for each subset of records weighted by their probability of occuring in the training set.
    for val in val_freq.keys():
        val_prob = val_freq[val] / sum(val_freq.values())
        data_subset = [record for record in data if record[attr] == val]
        subset_entropy += val_prob * entropy(data_subset, target_attr)

    # Subtract the entropy of the chosen attribute from the entropy of the whole data set with respect to the target attribute (and return it)
    return (entropy(data, target_attr) - subset_entropy)

def selectingInformationGain(npData, npLabels):
    # this function calculate the information gain with all features in relation to the labels
    aux = np.zeros((len(npData), len(npData[0]) + 1))
    aux[:, :-1] = npData
    aux[:, -1] = npLabels
    npData = aux
    entrpy = []
    for i in range(len(npData[0]) - 1):
        entrpy.append(gain(npData, i, len(npData[0]) - 1))
    return np.flip(np.argsort(entrpy), 0), entrpy

def selectingFdistances(npData): # order features by distance
    orderedFeatures = []
    orderedFeaturesValue = []
    distanceMatrix = np.zeros((len(npData[0]), len(npData[0])))
    for i in range(len(npData[0])):  # construct a matrix with distances between all features
        for j in range(len(npData[0])):
            if i < j:
                distanceMatrix[i][j] = scipyDistance(npData[:, i], npData[:, j], 'euclidean')[0]
    # initially choose the most relevant 2 features combination
    bestPairX = np.divide(np.nanargmax(distanceMatrix), len(distanceMatrix[0])) - 1
    bestPairY = np.nanargmax(distanceMatrix[bestPairX])
    orderedFeatures.append(bestPairX); orderedFeatures.append(bestPairY)
    orderedFeaturesValue.append(distanceMatrix[bestPairX, bestPairY])
    orderedFeaturesValue.append(distanceMatrix[bestPairX, bestPairY])
    distanceMatrix[bestPairX, bestPairY] = 0
    # then, include 1 by 1 the features with most distance to the features also included
    while len(orderedFeatures) != len(npData[0]):
        bestPairX = np.divide(np.nanargmax(distanceMatrix), len(distanceMatrix[0])) - 1
        bestPairY = np.nanargmax(distanceMatrix[bestPairX])
        if np.sum(np.isin(orderedFeatures, [bestPairX, bestPairY])) == 1:
            orderedFeatures.append([bestPairX, bestPairY][np.argmax(np.isin(orderedFeatures, [bestPairX, bestPairY]) == 0)])
            orderedFeaturesValue.append(distanceMatrix[bestPairX, bestPairY])
        distanceMatrix[bestPairX, bestPairY] = 0

    return np.asarray(orderedFeatures), orderedFeaturesValue

# def selectingF_RFE(data, labels):
# # # feature extraction
#     model = LogisticRegression()
#     kFeatures = 1
#     rfe = RFE(model, kFeatures)
#     fit = rfe.fit(data, labels)
#     featureWeight = fit.feature_importances_.astype(float)
#
#     weighted_train_data = np.multiply(data, featureWeight)
#  return sortedFeatures, values

def selectingCorrelation(npData, npLabels):
    correlations = np.zeros(len(npData[0]))
    for i in range(len(npData[0])):
        correlations[i] = np.correlate(npData[:, i], npLabels)
    return np.flip(np.argsort(correlations), 0), correlations

def selectingConsistency(npData, npLabels):
    correlations = np.zeros(len(npData[0]))
    for i in range(len(npData[0])):
        correlations[i] = np.correlate(npData[:, i], npLabels)
    return np.flip(np.argsort(correlations), 0), correlations

def selectingTree(npData, npLabels):
    # Build a forest and compute the feature importances
    forest = ExtraTreesClassifier(n_estimators=250, random_state=0)
    forest.fit(npData, npLabels)
    importances = forest.feature_importances_
    indices = np.flip(np.argsort(importances), 0)

    return indices, importances

def pruneTree(npData, npLabels):
    # this function calculate the information gain with all features in relation to the labels
    sortedFeatures, values = selectingInformationGain(npData, npLabels)
    aux = np.zeros((len(npData), len(npData[0]) + 1))
    aux[:, :-1] = npData
    aux[:, -1] = npLabels
    npData = aux

    remainingClasses = []
    remainingClasses.append(sortedFeatures[0])
    currentLevel = 0
    previousSubsets = [npData]
    uniques = []
    for remainingClass in remainingClasses:
        uniques.append(np.unique(npData[:, sortedFeatures[remainingClass]]))
        newSubset = []
        uniques = np.asarray(uniques)
        for uniq in uniques:
            sameClass = []
            for subSet in previousSubsets:
                for instance in subSet:
                    if instance[sortedFeatures[remainingClass]] == uniq:
                        sameClass.append(instance)
            newSubset.append(sameClass)

    # tree.append(level)

    # while remainingClasses == 1 or x == len(npData[0]):
    #     for i in range(len(level)):





    return 1, 1

def kNNAlgorithm(k, train_data, train_labels, test_data, test_labels, policy, distance_type):
    """
    :param k: number of neighbours
    :param train_data: training data in a matrix
    :param train_labels: outputs of training data
    :param test_data: test data in a matrix
    :param test_labels: outputs of test data (for the accuracy)
    :return: k neighbours closer
    """

    accuracy = 0
    results = []

    # select test instance
    for testIndex in range(len(test_data)):
        measuredistance = []
        output = []
        indices = []
        for trainIndex in range(len(train_data)):
            # measure distance
            # distanceTrainTest = distance(train_data[trainIndex], test_data[testIndex], np.ones(len(train_data[0])), distance_type=distance_type)
            # measuredistance.append(distanceTrainTest)
            distanceTrainTest = scipyDistance(train_data[trainIndex], test_data[testIndex], distance_type=distance_type)[0]
            if len(measuredistance) < k:
                measuredistance.append(distanceTrainTest)
                indices.append(trainIndex)
                currentMax = np.max(measuredistance)
                maxIndex = np.argmax(measuredistance)
            else:
                if distanceTrainTest < currentMax:
                    del measuredistance[maxIndex]
                    del indices[maxIndex]
                    measuredistance.append(distanceTrainTest)
                    indices.append(trainIndex)
                    currentMax = np.max(measuredistance)
                    maxIndex = np.argmax(measuredistance)

        for i in range(k):  # select the K most similar (with less distance) train instances
            output.append(str(train_labels[indices[i]]))

        final = assignation(output, measuredistance, policy)
        results.append(int(final))

        if final == str(test_labels[testIndex]):  # If predicted output is correct, increment 'accuracy', later we will divide that value by the total test data
            accuracy += 1

    # evaluation metrics calculation
    accuracy = accuracy / len(test_data)

    return accuracy

def dataEvaluation(npData, npLabels, evaluationMetric):
    if evaluationMetric == 'informationGain':
        sortedFeatures, values = selectingInformationGain(npData, npLabels)
    elif evaluationMetric == 'distances':
        sortedFeatures, values = selectingFdistances(npData)
    elif evaluationMetric == 'correlation':
        sortedFeatures, values = selectingCorrelation(npData, npLabels)
    elif evaluationMetric == 'tree':
        sortedFeatures, values = selectingTree(npData, npLabels)
    # elif evaluationMetric == 'consistency':
    #     sortedFeatures, values = selectingConsistency(npData, npLabels)

    if np.abs(np.min(values)) != np.min(values):
        values = values + np.abs(np.min(values))

    values = np.divide((values - np.min(values)), (np.max(values) - np.min(values)))
    values = np.divide(values, sum(values))
    sortedFeatures = sortedFeatures.astype(int)

    # print ('evaluationMetric: {} sortedFeatures: {} values: {}'.format(evaluationMetric, sortedFeatures, values))

    return sortedFeatures, values

def filterFeaturesSelecting(train_data, train_labels, test_data, evaluationMetric, threshold, searchDirection):
    npTrainData = np.array(train_data)
    npTrainLabels = np.array(train_labels)
    npTestData = np.array(test_data)
    remainingFeatures = []

    sortedFeatures, values = dataEvaluation(npTrainData, npTrainLabels, evaluationMetric)

    count = 0
    if searchDirection == 'SBS':  # Sequential backward search
        remainingFeatures = sortedFeatures

        count = 1.0
        while len(remainingFeatures) > 1:
            count -= values[sortedFeatures[len(remainingFeatures)-1]]
            if count < threshold:
                break
            remainingFeatures = np.delete(remainingFeatures, len(remainingFeatures)-1, axis=0)

    elif searchDirection == 'SFS':  # Sequential forward search
        for i in range(len(sortedFeatures)):
            count += values[sortedFeatures[i]]
            if count < threshold:
                remainingFeatures.append(sortedFeatures[i])
            else:
                break

    finalTrainData = npTrainData[:, remainingFeatures]
    finalTestData = npTestData[:, remainingFeatures]

    return finalTrainData, finalTestData, remainingFeatures

    # return finalData.tolist(), remainingFeatures

def SBS(numNeig, train_data, train_labels, test_data, test_labels, policy, distance_type, threshold, evaluationMetric):
    # this function perform a sequential backward search
    accuracies = []
    remainingFeatures = np.asarray(range(len(train_data[0])))
    bestRemainingFeatures = remainingFeatures
    newTrainD = np.array(train_data); newTestD = np.array(test_data);
    bestTrainD = newTrainD; bestTestD = newTestD
    sortedFeatures, values = dataEvaluation(newTrainD, train_labels, evaluationMetric)
    initialAccuracy = kNNAlgorithm(numNeig, train_data, train_labels, test_data, test_labels, policy, distance_type=distance_type)
    accuracy = initialAccuracy
    accuracies.append(accuracy)
    worstFeature = sortedFeatures[len(sortedFeatures) - 1]

    while len(remainingFeatures) > 1 and accuracy > threshold * initialAccuracy:
        newTrainD = np.delete(newTrainD, worstFeature, axis=1); newTestD = np.delete(newTestD, worstFeature, axis=1);
        accuracy = kNNAlgorithm(numNeig, newTrainD, train_labels, newTestD, test_labels, policy, distance_type=distance_type)
        if accuracy >= np.max(accuracies):
            bestTrainD = newTrainD; bestTestD = newTestD
            bestRemainingFeatures = remainingFeatures
        accuracies.append(accuracy)
        sortedFeatures, values = dataEvaluation(newTrainD, train_labels, evaluationMetric)
        worstFeature = sortedFeatures[len(sortedFeatures) - 1]
        remainingFeatures = np.delete(remainingFeatures, worstFeature)

    return bestTrainD, bestTestD, newTrainD, newTestD, bestRemainingFeatures, remainingFeatures

def SFS(numNeig, train_data, train_labels, test_data, test_labels, policy, distance_type, threshold, evaluationMetric):
    # this function perform a sequential forward search
    accuracies = []
    newTrainD = np.array(train_data); iniTrain = newTrainD
    newTestD = np.array(test_data); iniTest = newTestD

    sortedFeatures, values = dataEvaluation(newTrainD, train_labels, evaluationMetric)
    bestFeature = sortedFeatures[0]

    currentFeatures = [sortedFeatures[0]]; bestCurrentFeatures = currentFeatures
    newTrainD = newTrainD[:, currentFeatures]; newTestD = newTestD[:, currentFeatures]; bestTrainD = newTrainD; bestTestD = newTestD

    initialAccuracy = kNNAlgorithm(numNeig, newTrainD, train_labels, newTestD, test_labels, policy, distance_type=distance_type)
    accuracy = initialAccuracy
    accuracies.append(accuracy)

    for i in range(1, len(sortedFeatures)):
        if accuracy < threshold * initialAccuracy:
            break

        auxTrain = np.zeros((len(newTrainD), len(newTrainD[0]) + 1)); auxTrain[:, :-1] = newTrainD; auxTrain[:, -1] = iniTrain[:, bestFeature]; newTrainD = auxTrain
        auxTest = np.zeros((len(newTestD), len(newTestD[0]) + 1));  auxTest[:, :-1] = newTestD; auxTest[:, -1] = iniTest[:, bestFeature]; newTestD = auxTest
        accuracy = kNNAlgorithm(numNeig, newTrainD, train_labels, newTestD, test_labels, policy, distance_type=distance_type)
        if accuracy > np.max(accuracies):
            bestTrainD = newTrainD; bestTestD = newTestD
            bestCurrentFeatures = currentFeatures
        accuracies.append(accuracy)

        bestFeature = sortedFeatures[i]
        currentFeatures = np.append(currentFeatures, bestFeature)

    return bestTrainD, bestTestD, newTrainD, newTestD, bestCurrentFeatures, currentFeatures

def wrapperFeaturesSelecting(numNeig, train_data, train_labels, test_data, test_labels, policy, distance_type, searchDirection, threshold, metric):
    # npData = np.array(train_data)
    # npLabels = np.array(train_labels)
    # remainingFeatures = []

    # if metric == 'tree':
    #     sortedFeatures, values = pruneTree(npData, npLabels)

    if searchDirection == 'SBS':  # Sequential backward search
        bestTrainD, bestTestD, newTrainD, newTestD, bestRemainingFeatures, remainingFeatures = SBS(numNeig, train_data, train_labels, test_data, test_labels, policy, distance_type, threshold, metric)
    elif searchDirection == 'SFS':  # Sequential forward search
        bestTrainD, bestTestD, newTrainD, newTestD, bestRemainingFeatures, remainingFeatures = SFS(numNeig, train_data, train_labels, test_data, test_labels, policy, distance_type, threshold, metric)
    # elif searchDirection == 'SFBS': # Sequential forward-backward search
    #     bestTrainD, bestTestD, newTrainD, newTestD, bestRemainingFeatures, remainingFeatures = SBFS(numNeig, train_data, train_labels, test_data, test_labels, policy, distance_type, threshold, metric)




            # # WRAPPERS
        # elif metric == 'RFE':
        #     selectingF_RFE(data, labels)
    # finalData = np.zeros((len(data), len(remainingFeatures)))
    # for j in range(len(remainingFeatures)):
    # finalData = npData[:, remainingFeatures]

    return bestTrainD, bestTestD, bestRemainingFeatures