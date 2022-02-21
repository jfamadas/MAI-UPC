from scipy.io import arff
import numpy as np


# Function creation
def parser(path):
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
    datamat = np.array(unsupervised)[:, 0:-1]
    classes = np.array(unsupervised)[:, -1]

    # This erases useless features and adds values to no-data elements
    col = 0
    while col < datamat.shape[1]:
        # Find the most common value in the column 'col'
        uniques, counts = np.unique(datamat[:, col], return_counts=True)
        mostcommon = uniques[np.argmax(counts)]

        # Finds the '?' in the column
        index = datamat[:, col] == '?'
        index_nan = datamat[:, col] == 'nan'
        index_nonan = datamat[:, col] != 'nan'

        # Executes the first or the second depending on the datatype of col
        try:  # If col is an array of numbers, substitutes the 'nan' (no data) for the average
            average = np.average(datamat[index_nonan, col].astype(np.float))
            datamat[index_nan, col] = average

        except:  # If col is an array of strings, substitutes the '?' (no data) for the most common element
            datamat[index, col] = mostcommon

        # If most common element is '?' or 'nan' (no data) this feature is useless, so the column corresponding to it is erased
        if mostcommon == '?' or mostcommon == 'nan':
            datamat = np.delete(datamat, col, 1)
            col = col - 1

        col = col + 1

    # Transforms the nominal data to numerical
    for col in range(0,datamat.shape[1]):
        try:
            datamat[:,col] = datamat[:,col].astype(np.float)
        except:
            unics= np.unique(datamat[:, col])
            for j in range(0,unics.size):
                index = datamat[:,col] == unics[j]
                datamat[index,col] = j

    datamat = datamat.astype(float)
    # Numerical data should be normalized
    for col in range(0, datamat.shape[1]):

        # With this normalization we get the values so that the maximum is always 1 and the minumum 0
        column = datamat[:, col]
        col_min0 = column - np.min(column)
        col_normalized = col_min0 / np.max(col_min0)

        datamat[:, col] = col_normalized


    # Returns the data and the classes
    return datamat, classes


a,b = parser('C:\Users\ALEIX\Desktop\AI_Master\IML\Work1\datasets\datasets\\adult.arff')
pass
