import numpy as np
import sklearn
import scipy
import matplotlib.pyplot as plt

from parserPCA import parser
from datasets import *
from plotFeatures import plotXfeatures, chooseXfeatures

'''
Step 1. Read the .arff file and take the whole data set consisting of d-dimensional samples
        ignoring the class labels. Save the information in a matrix
'''
choosenDataset = 0
data, classes = parser(getDatasetPath(choosenDataset))

# xData = [2.5, 0.5, 2.2, 1.9, 3.1, 2.3, 2.0, 1.0, 1.5, 1.1]
# yData = [2.4, 0.7, 2.9, 2.2, 3.0, 2.7, 1.6, 1.1, 1.6, 0.9]
# data = []
# for i in range(len(xData)):
#     data.append([xData[i], yData[i]])
# data = np.asarray(data)
#
# numberOfFeatures = 2
# selectedFeaturesIndex0 = [0, 1]
# figureTitle = 'Trial with dummy dataset'
# dataLabels = ['Nothing x', 'Nothing y']
# plotXfeatures(data, selectedFeaturesIndex0, 0, figureTitle, dataLabels, [])

# numberOfFeatures = 1
# selectedFeaturesIndex0 = [0,1]
# figureTitle = 'Initially chosen features with ' + getDatasetInfo(choosenDataset)[0] + ' dataset with PCA from {} to {} features'.format(
#     getDatasetInfo(choosenDataset)[1], 1)
# plotXfeatures(data[:, selectedFeaturesIndex0[:, None]], selectedFeaturesIndex0, 0, figureTitle, [])

'''
Step 2. Plot the original data set (choose two or three of its features to visualize it).
'''
# The chooseXfeatures function only provide the possibility of choosing 2 or 3 features
numberOfFeatures = 2
selectedFeaturesIndex1 = chooseXfeatures(data, classes, numberOfFeatures)

figureTitle = 'Initially chosen features with ' + getDatasetInfo(choosenDataset)[0] + ' dataset with PCA from {} to {} features'.format(
    len(data[0]), numberOfFeatures)
dataLabels = []
plotXfeatures(data[:, selectedFeaturesIndex1[:, None]], selectedFeaturesIndex1, 0, figureTitle, dataLabels, [], classes)

'''
Step 3. Compute the d-dimensional mean vector (i.e., the means of every dimension of the whole data set).
'''
featuresMean = data.mean(0)
centeredData = data - featuresMean

'''
# Step 4. Compute the covariance matrix of the whole data set. Show this information.
'''
covarianceMatrix = np.cov(centeredData, rowvar=False)
print 'Covariance matrix: ', covarianceMatrix

'''
# Step 5. Calculate eigenvectors (e1, e2, ..., ed) and their corresponding eigenvalues of the
# covariance matrix. Write them in console.
'''
eigenvalues, eigenvectors = np.linalg.eig(covarianceMatrix)
eigenvectors = eigenvectors.T
print "Eigenvectors: ", eigenvectors
print "Eigenvalues: ", eigenvalues
print "Eigenvalues ratio: ", eigenvalues/sum(eigenvalues)


'''
# - Step 6. Sort the eigenvectors by decreasing eigenvalues and choose k eigenvectors with the
# largest eigenvalues to form a new d x k dimensional matrix (where every column
# represents an eigenvector). Write the sorted eigenvectors and eigenvalues in console.
'''
sortedEigenvaluesIndices = np.flip(np.argsort(eigenvalues), 0)

# Choose a value for p, the desired final data dimensionality (n is the initial dimensionality)
# To reduce dimensionality to p, ignore n-p components at the bottom of the list.
p = numberOfFeatures
n = len(data[0])
choosenEigenvalues = eigenvalues[sortedEigenvaluesIndices[:p]]
choosenEigenvectors = eigenvectors.T[sortedEigenvaluesIndices[:p]]
print "Choosen Eigenvectors: ", choosenEigenvectors
print "Choosen Eigenvalues: ", choosenEigenvalues

rowFeaturesVector = eigenvectors

'''
# - Step 7. Derive the new data set. Use this d x k eigenvector matrix to transform the samples
# onto the new subspace.
'''
transformedData = rowFeaturesVector.dot(centeredData.T)

'''
# - Step 8. Plot the new subspace (choose the largest eigenvectors to plot the matrix).
'''

dataToPlot = [centeredData[:, selectedFeaturesIndex1[:, None]], transformedData.transpose(), transformedData[0].transpose()]
figureTitle = 'PCA with eigenvectors compared with initial selection'
dataLabels = ['Centered initial selection', 'Transformed data with {} eigenvectors'.format(p), 'Transformed data with a single eigenvector']
# plotXfeatures(dataToPlot, sortedEigenvaluesIndices[:p], 2, figureTitle, dataLabels, choosenEigenvectors)

'''
# - Step 9. Reconstruct the data set back to the original one. Additionally, plot the data set.
'''
reconstructedDataAdjust = rowFeaturesVector.transpose().dot(transformedData).T
reconstructedOriginalData = reconstructedDataAdjust + featuresMean

# dataToPlot = [data[:, selectedFeaturesIndex1], centeredData[:, selectedFeaturesIndex1], transformedData.T[:, sortedEigenvaluesIndices[:p]], reconstructedOriginalData[:, selectedFeaturesIndex1]]
# figureTitle = 'Reconstructed data compared to original data'
# dataLabels = ['Initial data selection', 'Centered data', 'Transformed data', 'Reconstructed initial data selection']
# plotXfeatures(dataToPlot, selectedFeaturesIndex1, 2, figureTitle, dataLabels, choosenEigenvectors, classes)

dataToPlot = [data[:, selectedFeaturesIndex1[:, None]], transformedData.T[:, sortedEigenvaluesIndices[:p]], reconstructedOriginalData[:, selectedFeaturesIndex1[:, None]]]
figureTitle = 'Reconstructed data compared to original data with ' + getDatasetInfo(choosenDataset)[0] + ' dataset with PCA from {} to {} features'.format(
    len(data[0]), numberOfFeatures)
dataLabels = ['Initial data selection', 'Transformed data', 'Reconstructed initial data selection']
plotXfeatures(dataToPlot, selectedFeaturesIndex1, 2, figureTitle, dataLabels, choosenEigenvectors, classes)

# figureTitle = 'Initially chosen features with ' + getDatasetInfo(choosenDataset)[0] + ' dataset with PCA from {} to {} features'.format(
#     len(data[0]), numberOfFeatures)
# dataLabels = []
# plotXfeatures(transformedData.T[:, sortedEigenvaluesIndices[:p]], selectedFeaturesIndex1, 0, figureTitle, dataLabels, [], classes)



'''
Compare and analyze your results to the ones obtained using sklearn.PCA library.
'''

from sklearn.decomposition import PCA

scores = []
ini = 1
end = len(data[0]) + 1
if ini < 1:
    ini = 1
# if end > len(data[0]) + 1:
#     end = len(data[0]) + 1

for p in range(ini, end):

    pca = PCA(n_components=p)#, svd_solver='full')
    transformedDataSklearn = pca.fit_transform(data)

    covarianceMatrixSklearn = pca.get_covariance()
    print("SkLearn covariance matrix  {} with {} features".format(covarianceMatrixSklearn, p))
    # reconstructedManuallyDataAdjustSklearn = pca.components_.dot(transformedDataSklearn).T
    # reconstructedManuallyOriginalDataSklearn = reconstructedManuallyDataAdjustSklearn + pca.mean_

    # Reconstruction of original data using only the principal eigenvectors
    reconstructedOriginalDataSklearn = pca.inverse_transform(transformedDataSklearn)
    score = pca.score(data)
    scores.append(score)
    print("SkLearn score  {} with {} features".format(score, p))

    print("SkLearn components_  {} with {} features".format(pca.components_, p))

    print("SkLearn explained_variance_ratio_ {} with {} features".format(pca.explained_variance_ratio_, p))

    print("SkLearn singular_values_ {} with {} features".format(pca.singular_values_, p))

    print("SkLearn get_precision {} with {} features".format(pca.get_precision(), p))

p = numberOfFeatures
pca = PCA(n_components=p)#, svd_solver='full')
transformedDataSklearn = pca.fit_transform(data)
reconstructedOriginalDataSklearn = pca.inverse_transform(transformedDataSklearn)

dataToPlot = [data[:, selectedFeaturesIndex1], transformedDataSklearn[:, sortedEigenvaluesIndices[:p]], reconstructedOriginalDataSklearn[:, selectedFeaturesIndex1]]
figureTitle = 'SKlearn Reconstructed data compared to original data with ' + getDatasetInfo(choosenDataset)[0] + ' dataset with PCA from {} to {} features'.format(
    len(data[0]), numberOfFeatures)
dataLabels = ['Initial data selection', 'Transformed data', 'Reconstructed initial data selection']
plotXfeatures(dataToPlot, selectedFeaturesIndex1, 2, figureTitle, dataLabels, choosenEigenvectors, classes)

fig = plt.figure()
plt.plot(range(ini, end), scores)
plt.title('PCA score')
plt.xlabel('Number of dimensions')
plt.ylabel('Score')
axes = plt.gca()
axes.set_xlim([ini, end-1])
plt.show()

x=1