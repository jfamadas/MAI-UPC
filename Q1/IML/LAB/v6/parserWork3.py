from scipy.io import arff
import numpy as np
import math

def parser(path, rang):
    data, meta = arff.loadarff(path)

    unsupervised = []
    line = []

    # Creates a list of list with all the data
    for i in range(len(data)):
        for j in range(len(data[i])):
            line.append(data[i][j])
        unsupervised.append(line)
        line = []

    # Transforms the list into numpy arrays (in order to work better with them)
    datamat = np.array(unsupervised)[:, :-1]
    classes = np.array(unsupervised)[:, -1]

    # This erases useless features and adds values to no-data elements
    col = 0
    while col < datamat.shape[1]:
        # Find the most common value in the column 'col'
        uniques, counts = np.unique(datamat[:, col], return_counts=True)
        mostcommon = uniques[np.argmax(counts)]

        # Finds the '?' in the column
        index = datamat[:, col] == '?'
        a = np.sum(index)
        index_nan = datamat[:, col] == 'nan'
        b = np.sum(index_nan)
        index_nonan = datamat[:, col] != 'nan'
        c = np.sum(index_nonan)

        # Executes the first or the second depending on the datatype of col
        try:  # If col is an array of numbers, substitutes the 'nan' (no data) for the average
            average = np.average(datamat[index_nonan, col].astype(np.float))
            datamat[index_nan, col] = average

        except:  # If col is an array of strings, substitutes the '?' (no data) for the most common element
            # create a poligon with the same distance between all unique elements
            if '?' in uniques:
                index = datamat[:, col] == '?'
                datamat[index, col] = mostcommon
                index_aux = uniques == '?'
                index_aux = index_aux == False
                uniques = uniques[index_aux]
            if len(uniques) == 1:
                # col -= 1 # If there is only one value in this feature, delete column
                datamat[:, col] = 1.0
            elif len(uniques) == 2:
                index = datamat[:, col] == uniques[0]
                datamat[index, col] = 0.0
                index = datamat[:, col] == uniques[1]
                datamat[index, col] = 1.0
            else:
                datamat[index, col] = mostcommon

        col += 1

    # Numerical data should be normalized
    datamat_list = datamat.tolist()
    for col in range(0, datamat.shape[1]):
        try:
            col_float = datamat[:, col].astype(np.float)
            if np.max(col_float)-np.min(col_float) == 0:
                col_float_normalized = np.zeros(len(datamat[:, col])).astype(float)
            else:
                if rang == 'posNeg': # With this normalization we get the values so that the maximum is always 1 and the minumum -1
                    col_float_mean_extracted = col_float - np.mean(col_float)
                    col_float_normalized = np.divide(col_float_mean_extracted, np.max([np.max(col_float_mean_extracted),np.abs(np.min(col_float_mean_extracted))]))
                elif rang == 'pos': # With this normalization we get the values so that the maximum is always 1 and the minumum 0
                    col_float_normalized = (col_float - np.min(col_float)) / (np.max(col_float) - np.min(col_float))
                else:
                    pass

            for row in range(0, datamat.shape[0]):
                datamat_list[row][col] = col_float_normalized[row]
        except:
            pass

    # Find the most common value in the column 'col'
    uniques, counts = np.unique(classes[:], return_counts=True)
    mostcommon = uniques[np.argmax(counts)]
    # Executes the first or the second depending on the datatype of col
    try:  # Check if there are categorical labels
        classes = float(classes)

    except:  # There are categorical labels
        # create a poligon with the same distance between all unique elements
        if len(uniques) == 1:
            # col -= 1 # If there is only one value in this feature, delete column
            classes[:] = 0
        elif len(uniques) == 2:
            if rang == 'posNeg':
                index = classes[:] == uniques[0]
                classes[index] = -1
                index = classes[:] == uniques[1]
                classes[index] = 1
            elif rang == 'pos':
                index = classes[:] == uniques[0]
                classes[index] = 0
                index = classes[:] == uniques[1]
                classes[index] = 1
        else:
            classes[index] = mostcommon

    col_float = classes[:].astype(np.int)
    classes_list = classes.tolist()
    for row in range(0, datamat.shape[0]):
        classes_list[row] = col_float[row]

    # Returns the data and the classes as type list of lists and list respectively
    return datamat_list, classes_list

def parserImproved(trainPath, testPath, rang):
    trainData, _ = arff.loadarff(trainPath)
    testData, _ = arff.loadarff(testPath)

    unsupervised = []
    # Creates a list of list with all the data
    for i in range(len(trainData)):
        line = []
        for j in range(len(trainData[i])):
            line.append(trainData[i][j])
        unsupervised.append(line)

    indexTrain = i

    for i in range(len(testData)):
        line = []
        for j in range(len(testData[i])):
            line.append(testData[i][j])
        unsupervised.append(line)

    # Transforms the list into numpy arrays (in order to work better with them)
    datamat = np.array(unsupervised)[:, :-1]
    classes = np.array(unsupervised)[:, -1]

    # This erases useless features and adds values to no-data elements
    col = 0
    for col in range(len(datamat[0])):
        # Find the most common value in the column 'col'
        currentCol = datamat[:, col]
        uniques, counts = np.unique(currentCol, return_counts=True)
        mostcommon = uniques[np.argmax(counts)]

        # Executes the first or the second depending on the datatype of col
        try:  # If col is an array of numbers, substitutes the 'nan' (no data) for the average
            index_nan = currentCol == 'nan'
            index_nonan = currentCol != 'nan'

            average = np.average(currentCol[index_nonan].astype(np.float))
            currentCol[index_nan] = average
            currentCol = np.asarray(currentCol).astype(float)

            auxCol = np.zeros((len(currentCol), 1))
            for i in range(len(currentCol)):
                auxCol[i, 0] = currentCol[i]
            currentCol = auxCol

        except:  # If col is an array of strings, substitutes the '?' (no data) for the most common element
            if '?' in uniques:
                index = currentCol == '?'
                currentCol[index] = mostcommon
                index_aux = uniques == '?'
                index_aux = index_aux == False
                uniques = uniques[index_aux]
            if len(uniques) == 1: # If there is only one value in this feature, delete column
                currentCol = []
            elif len(uniques) == 2:
                index = currentCol == uniques[0]
                currentCol[index] = 0.0
                index = currentCol == uniques[1]
                currentCol[index] = 1.0

                auxCol = np.zeros((len(currentCol), 1))
                for i in range(len(currentCol)):
                    auxCol[i, 0] = currentCol[i]
                currentCol = auxCol
            else:
                expandCol = np.zeros((len(currentCol), 1))
                originalCol = currentCol
                for uni in range(len(uniques)):
                    if uni > 0:
                        auxExpandCol = np.zeros((len(expandCol), len(expandCol[0]) + 1))
                        auxExpandCol[:, :-1] = expandCol
                        expandCol = auxExpandCol
                    expandCol[:, -1] = originalCol == uniques[uni]
                    currentCol = expandCol
            currentCol = np.asarray(currentCol).astype(float)

        if col > 0:
            newDatamat = np.concatenate((newDatamat, currentCol), axis=1)
        else:
            newDatamat = np.zeros((len(currentCol), len(currentCol[0])))

            for i in range(len(currentCol)):
                for j in range(len(currentCol[0])):
                    newDatamat[i, j] = currentCol[i][j]

    # Numerical data should be normalized
    datamat_list = newDatamat.tolist()
    for col in range(0, newDatamat.shape[1]):
        col_float = newDatamat[:, col].astype(np.float)
        if np.max(col_float)-np.min(col_float) == 0:
            col_float_normalized = np.zeros(len(newDatamat[:, col])).astype(float)
        else:
            if rang == 'posNeg': # With this normalization we get the values so that the maximum is always 1 and the minumum -1
                col_float_mean_extracted = col_float - np.mean(col_float)
                col_float_normalized = np.divide(col_float_mean_extracted, np.max([np.max(col_float_mean_extracted),np.abs(np.min(col_float_mean_extracted))]))
            elif rang == 'pos': # With this normalization we get the values so that the maximum is always 1 and the minumum 0
                col_float_normalized = (col_float - np.min(col_float)) / (np.max(col_float) - np.min(col_float))
            else:
                pass

        for row in range(0, newDatamat.shape[0]):
            datamat_list[row][col] = col_float_normalized[row]

    # Find the most common value in the column 'col'
    uniques, counts = np.unique(classes[:], return_counts=True)
    # Executes the first or the second depending on the datatype of col
    try:  # Check if there are categorical labels
        classes = float(classes)
    except:  # There are categorical labels
        for uni in range(len(uniques)):
            index = classes == uniques[uni]
            classes[index] = uni

    col_float = classes[:].astype(np.int)
    classes_list = classes.tolist()
    for row in range(0, newDatamat.shape[0]):
        classes_list[row] = col_float[row]

    # Returns the data and the classes as type list of lists and list respectively
    indexTrain += 1
    datamatTrain_list = datamat_list[:indexTrain][:]
    classesTrain_list = classes_list[:indexTrain]
    datamatTest_list = datamat_list[indexTrain:][:]
    classesTest_list = classes_list[indexTrain:]

    return datamatTrain_list, classesTrain_list, datamatTest_list, classesTest_list




