from __future__ import division
from auxiliarMethods import *
from numpy import array
from sklearn.metrics import f1_score, recall_score, precision_score
from sklearn.neighbors import KNeighborsClassifier

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

    for testIndex in range(len(test_data)):

        measuredistance = []
        output = []
        indices = []
        for trainIndex in range(len(train_data)):
            # measure distance
            # distanceTrainTest = distance(train_data[trainIndex], test_data[testIndex], np.ones(len(train_data[0])), distance_type=distance_type)

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
    precision = precision_score(test_labels, results, average='macro')
    recall = recall_score(test_labels, results, average='macro')
    f1score = f1_score(test_labels, results, average='macro')

    return accuracy, precision, recall, f1score

def distanceWeightedkNNAlgorithm(k, train_data, train_labels, test_data, test_labels, policy, weight,  distance_type):


    """
    :param k: number of neighbours
    :param train_data: training data in a matrix
    :param train_labels: outputs of training data
    :param test_data: test data in a matrix
    :param test_labels: outputs of test data (for the accuracy)
    :return: k neighbouts closer
    """

    accuracy = 0
    results = []
    # weights = []
    aun = 0

    
    for testInstance in test_data:
        aun += 1
        measuredistance = []
        output = []
        outputDistances = []
        
        for trainInstance in train_data:
            
            # distanceTrainTest = distance(trainInstance, testInstance, np.ones(len(train_data[0])), distance_type=distance_type)
            # measuredistance.append(distanceTrainTest ** weight)
            distanceTrainTest = scipyDistance(trainInstance, testInstance, distance_type=distance_type)[0]
            measuredistance.append(distanceTrainTest * distanceTrainTest ** weight)
            # weights.append(1.0/float(distanceTrainTest) ** weight)

        arrayDistance = array(measuredistance)
        indexofmostlikely = np.argsort(arrayDistance)[:k]

        for i in range(k):
            output.append(str(train_labels[indexofmostlikely[i]]))
            outputDistances.append(arrayDistance[indexofmostlikely[i]]) # we store the distances values to use it in case of assignation to a label draw

        final = assignation(output, outputDistances, policy)

        results.append(int(final))

        if final == str(test_labels[aun-1]):
            accuracy += 1

    accuracy = accuracy / len(test_data)
    precision = precision_score(test_labels, results, average='macro')
    recall = recall_score(test_labels, results, average='macro')
    f1score = f1_score(test_labels, results, average='macro')

    return accuracy, precision, recall, f1score

def weightedKNNalgorithm(k, train_data, train_labels, test_data, test_labels, policy, metric,  distance_type):
    """
    :param k: number of neighbours
    :param train_data: training data in a matrix
    :param train_labels: outputs of training data
    :param test_data: test data in a matrix
    :param test_labels: outputs of test data (for the accuracy)
    :return: k neighbouts closer
    """

    accuracy = 0
    results = []

    # we calculate the weight vector with the selected metric
    weightVector = featureWeighting(train_data, train_labels, metric, distance_type)
    # as weight vector give greater value to the more important features, we have to inverse it in order to decrease the distance between the most
    # important features and leave without modifiying the most irrelevant
    # aux = np.ones(len(weightVector)); inverseWeightVector = aux - weightVector

    # and we apply the weight vector to the data
    test_data = test_data * weightVector; train_data = train_data * weightVector
    # print ('weightVector: {}'.format(weightVector))
    # test_data = test_data * inverseWeightVector; train_data = train_data * inverseWeightVector

    for testIndex in range(len(test_data)):
        measuredistance = []
        output = []
        indices = []
        for trainIndex in range(len(train_data)):
            # measure distance
            # distanceTrainTest = distance(train_data[trainIndex], test_data[testIndex], weightVector, distance_type=distance_type)
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

    accuracy = accuracy / len(test_data)
    precision = precision_score(test_labels, results, average='macro')
    recall = recall_score(test_labels, results, average='macro')
    f1score = f1_score(test_labels, results, average='macro')

    return accuracy, precision, recall, f1score, weightVector

def selectionKNNalgorithm(k, train_data, train_labels, test_data, test_labels, policy, metric, type, searchDirection, threshold, distance_type):
    """
    :param k: number of neighbours
    :param train_data: training data in a matrix
    :param train_labels: outputs of training data
    :param test_data: test data in a matrix
    :param test_labels: outputs of test data (for the accuracy)
    :return: k neighbouts closer
    """

    accuracy = 0
    results = []

    if type == 'filter':
        selected_train_data, selected_test_data, selectedFeatures = filterFeaturesSelecting(train_data, train_labels, test_data, metric, threshold, searchDirection)
    elif type == 'wrapper':
        selected_train_data, selected_test_data, selectedFeatures = wrapperFeaturesSelecting(k, train_data, train_labels, test_data, test_labels, policy, distance_type, searchDirection, threshold, metric)

    # print ('selectedFeatures: {}'.format(selectedFeatures))
    # selected_test_data = np.asarray(test_data)
    # selected_test_data = selected_test_data[:, selectedFeatures].tolist()

    for testIndex in range(len(selected_test_data)):
        measuredistance = []
        output = []
        indices = []
        for trainIndex in range(len(selected_train_data)):
            # measure distance
            # distanceTrainTest = distance(train_data[trainIndex], test_data[testIndex], np.ones(len(train_data[0])), distance_type=distance_type)
            distanceTrainTest = scipyDistance(selected_train_data[trainIndex], selected_test_data[testIndex], distance_type=distance_type)[0]
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

    accuracy = accuracy / len(test_data)
    precision = precision_score(test_labels, results, average='macro')
    recall = recall_score(test_labels, results, average='macro')
    f1score = f1_score(test_labels, results, average='macro')

    return accuracy, precision, recall, f1score, selectedFeatures

def scikitKNNalgorithm(k, train_data, train_labels, test_data, test_labels, distance_type):
    neigh = KNeighborsClassifier(n_neighbors=k, metric=distance_type)
    neigh.fit(train_data, train_labels)
    results = neigh.predict(test_data)

    accuracy = neigh.score(test_data, test_labels)
    precision = precision_score(test_labels, results, average='macro')
    recall = recall_score(test_labels, results, average='macro')
    f1score = f1_score(test_labels, results, average='macro')

    return accuracy, precision, recall, f1score