from scipy.io import arff
import numpy as np


# Function creation
def parserWork1(path):
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
            datamat[index, col] = mostcommon

        ## If most common element is '?' or 'nan' (no data) this feature is useless, so the column corresponding to it is erased
        #if mostcommon == '?' or mostcommon == 'nan':
        #    datamat = np.delete(datamat, col, 1)
        #   col = col - 1

        col = col + 1

    # Numerical data should be normalized
    datamat_list = datamat.tolist()
    for col in range(0, datamat.shape[1]):
        try:
            # With this normalization we get the values so that the maximum is always 1 and the minumum 0
            col_float = datamat[:, col].astype(np.float)
            col_float_normalized = (col_float - np.min(col_float))/(np.max(col_float)-np.min(col_float))

            for row in range(0, datamat.shape[0]):
                datamat_list[row][col] = col_float_normalized[row]
        except:
            pass

    # Returns the data and the classes as type list of lists and list respectively
    return datamat_list, classes.tolist()




