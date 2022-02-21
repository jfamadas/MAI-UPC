# Feature Extraction with Univariate Statistical Tests (Chi-squared for classification)
def chooseXfeatures(X, Y, k):
    # Feature Extraction with RFE
    import numpy as np
    from sklearn.feature_selection import RFE
    from sklearn.linear_model import LogisticRegression

    # feature extraction
    model = LogisticRegression()
    rfe = RFE(model, k)
    fit = rfe.fit(X, Y)
    print("Num selected Features: %d") % fit.n_features_
    print("Selected Features: %s") % fit.support_
    print("Feature Ranking: %s") % fit.ranking_
    return np.where(fit.support_ == True)[0]

def labelsSetting(ax, selectedFeatures):
    if len(selectedFeatures) == 3:
        ax.set_xlabel("Feature {}".format(selectedFeatures[0]))
        ax.set_ylabel("Feature {}".format(selectedFeatures[1]))
        ax.set_zlabel("Feature {}".format(selectedFeatures[2]))

    if len(selectedFeatures) == 2:
        ax.set_xlabel("Feature {}".format(selectedFeatures[0]))
        ax.set_ylabel("Feature {}".format(selectedFeatures[1]))


# In order to plot more than one result in the same figure, only perform plt.show() after plot all data
# If multiple = 0: Unique plot in one figure. If multiple = 1: Different plots in same figure.
# If multiple = 2: Different plots in different subplots
def plotXfeatures(data, selectedFeatures, multiple, title, dataLabels, eigenVec, classes):
    import matplotlib.pyplot as plt
    from mpl_toolkits.mplot3d import Axes3D
    import numpy as np
    np.random.seed(19680801)
    N = 50
    colors = np.random.rand(N)
    classesColors = np.array(classes)
    unics = np.unique(classes)
    for j in range(0, unics.size):
        index = classes == unics[j]
        classesColors[index] = colors[j]

    fig = plt.figure()
    ax = []

    if len(selectedFeatures) == 3:
        if multiple == 1:
            ax = fig.add_subplot(1, 1, 1, projection='3d')
            ax.grid(True)
            labelsSetting(ax, selectedFeatures)
            plt.title(title)
            for dat in data:
                # ax.scatter(dat[:, 0], dat[:, 1], dat[:, 2], c=None)
                ax.scatter(dat[:, 0], dat[:, 1], dat[:, 2], c=classesColors)
        elif multiple == 2:

            j = 0
            ax.append(fig.add_subplot(len(data), 1, j + 1, projection='3d'))
            ax[j].grid(True)
            # ax[j].scatter(data[j][:, 0], data[j][:, 1], c=None, label=dataLabels[j])
            ax[j].scatter(data[j][:, 0], data[j][:, 1], data[j][:, 2], c=classesColors, label=dataLabels[j])
            labelsSetting(ax[j], selectedFeatures)
            plt.legend()
            plt.title(title)

            for j in range(1, len(data)):
                ax.append(plt.subplot(len(data), 1, j + 1, sharex=ax[j - 1], projection='3d'))
                ax[j].grid(True)
                labelsSetting(ax[j], selectedFeatures)
                # ax[j].scatter(data[j][:, 0], data[j][:, 1], data[j][:, 2], c=None, label=dataLabels[j])
                ax[j].scatter(data[j][:, 0], data[j][:, 1], data[j][:, 2], c=classesColors, label=dataLabels[j])
                # try:
                #     # ax[j].arrow(eigenVec[j][0], eigenVec[j][1], eigenVec[j][2], eigenVec[j][3], head_width=0.05, head_length=0.1, fc='k', ec='k')
                #     plt.arrow(eigenVec[j][0], eigenVec[j][1], eigenVec[j][2], eigenVec[j][3], head_width=0.05, head_length=0.1, fc='k', ec='k')
                # except:
                #     pass
                plt.legend()
        else:
            ax = fig.add_subplot(1, 1, 1, projection='3d')
            # ax.scatter(data[:, 0], data[:, 1], data[:, 2], c=None)
            ax.scatter(data[:, 0], data[:, 1], data[:, 2], c=classesColors)
            ax.grid(True)
            labelsSetting(ax, selectedFeatures)
            plt.title(title)

    elif len(selectedFeatures) == 2:

        if multiple == 1:
            ax = fig.add_subplot(1, 1, 1)
            ax.grid(True)
            labelsSetting(ax, selectedFeatures)
            plt.legend()
            plt.title(title)
            for dat in data:
                # ax.scatter(dat[:, 0], dat[:, 1], c=None)
                ax.scatter(dat[:, 0], dat[:, 1], c=classesColors)

        elif multiple == 2:
            j = 0
            # ax = fig.add_subplot(len(data), 1, j + 1, sharex=ax)
            ax.append(plt.subplot(len(data), 1, j + 1))
            ax[j].grid(True)
            # ax[j].scatter(data[j][:, 0], data[j][:, 1], c=None, label=dataLabels[j])
            ax[j].scatter(data[j][:, 0], data[j][:, 1], c=classesColors, label=dataLabels[j])
            labelsSetting(ax[j], selectedFeatures)
            plt.legend()
            plt.title(title)

            for j in range(1, len(data)):
                ax.append(plt.subplot(len(data), 1, j + 1, sharex=ax[j - 1]))
                ax[j].grid(True)
                labelsSetting(ax[j], selectedFeatures)
                try: #if there is data with 2 dimensions
                    # ax[j].scatter(data[j][:, 0], data[j][:, 1], c=None, label=dataLabels[j])
                    ax[j].scatter(data[j][:, 0], data[j][:, 1], c=classesColors, label=dataLabels[j])
                except: #if there is data with only 1 dimension
                    # ax[j].scatter(data[j], np.zeros(len(data[j])), c=None, label=dataLabels[j])
                    ax[j].scatter(data[j], np.zeros(len(data[j])), c=classesColors, label=dataLabels[j])
                # try:
                #     # ax[j].arrow(eigenVec[j][0], eigenVec[j][1], eigenVec[j][2], eigenVec[j][3], head_width=0.05, head_length=0.1, fc='k', ec='k')
                #     plt.arrow(eigenVec[j][0], eigenVec[j][1], eigenVec[j][2], eigenVec[j][3], head_width=0.05, head_length=0.1, fc='k', ec='k')
                # except:
                #     pass
                plt.legend()

        else:
            ax = fig.add_subplot(1, 1, 1)
            # ax.scatter(data[:, 0], data[:, 1], c=None)
            ax.scatter(data[:, 0], data[:, 1], c=classesColors)
            ax.grid(True)
            labelsSetting(ax, selectedFeatures)
            plt.legend()
            plt.title(title)

        # ax.set_xlabel("Feature {}".format(selectedFeatures[0]))
        # ax.set_ylabel("Feature {}".format(selectedFeatures[1]))

    # plt.legend()
    plt.show()#(block=False)

    return None

# from parserPCA import parser
#
# dataset0 = ['iris.arff', 3] # 3c Little, only numbers, 33% each class
# dataset1 = ['glass.arff', 2] # 2c Little, only numbers
# dataset2 = ['grid.arff', 2] # Medium, both classes, 50% each class
# dataset3 = ['adult.arff', 2] # Large, both classes
# dataset4 = ['hepatitis.arff', 2] # Little, both classes
# dataset5 = ['autos.arff', 6] # Little, both classes
# dataset6 = ['kropt.arff', 18] # Very large, only nominal
# dataset7 = ['waveform.arff', 3] # Large, only numbers
# dataset8 = ['pen-based.arff', 10] # Large, only numbers
# dataset9 = ['satimage.arff', 6] # Large, only numbers, huge difference between instances to each class ************
# dataset10 = ['pima_diabetes.arff', 2]
# dataset11 = ['satimage.arff', 6]
# dataset12 = ['bal.arff', 3] # balance scale
# dataset13 = ['breast-w.arff', 2] # breast cancer wisconsin
# dataset14 = ['soybean.arff', 19] # only nominal but with little difference inside class and huge difference between instances to each class
#
#
# datasetsArray = []
# datasetsArray.append(dataset0)
# datasetsArray.append(dataset1)
# datasetsArray.append(dataset2)
# datasetsArray.append(dataset3)
# datasetsArray.append(dataset4)
# datasetsArray.append(dataset5)
# datasetsArray.append(dataset6)
# datasetsArray.append(dataset7)
# datasetsArray.append(dataset8)
# datasetsArray.append(dataset9)
# datasetsArray.append(dataset10)
# datasetsArray.append(dataset11)
# datasetsArray.append(dataset12)
# datasetsArray.append(dataset13)
# datasetsArray.append(dataset14)
#
# path = 'C:\Users\ALEIX\Desktop\AI_Master\IML\Work1\datasets\datasets\\' + datasetsArray[8][0]
# data, classes = parser(path)
#
# numberOfFeatures = 2
# selectedFeaturesIndex = chooseXfeatures(data, classes, numberOfFeatures)
#
# plotXfeatures(data[:,selectedFeaturesIndex[:, None]], selectedFeaturesIndex)
# x = 1