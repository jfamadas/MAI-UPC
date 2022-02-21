def getDatasetPath(x):
    dataset0 = ['iris.arff', 3]  # 3c Little, only numbers, 33% each class
    dataset1 = ['glass.arff', 2]  # 2c Little, only numbers
    dataset2 = ['grid.arff', 2]  # Medium, both classes, 50% each class
    dataset3 = ['adult.arff', 2]  # Large, both classes
    dataset4 = ['hepatitis.arff', 2]  # Little, both classes
    dataset5 = ['autos.arff', 6]  # Little, both classes
    dataset6 = ['kropt.arff', 18]  # Very large, only nominal
    dataset7 = ['waveform.arff', 3]  # Large, only numbers
    dataset8 = ['pen-based.arff', 10]  # Large, only numbers
    dataset9 = ['satimage.arff', 6]  # Large, only numbers, huge difference between instances to each class ************
    dataset10 = ['pima_diabetes.arff', 2]
    dataset11 = ['satimage.arff', 6]
    dataset12 = ['bal.arff', 3]  # balance scale
    dataset13 = ['breast-w.arff', 2]  # breast cancer wisconsin
    dataset14 = ['soybean.arff', 19]  # only nominal but with little difference inside class and huge difference between instances to each class

    datasetsArray = []
    datasetsArray.append(dataset0)
    datasetsArray.append(dataset1)
    datasetsArray.append(dataset2)
    datasetsArray.append(dataset3)
    datasetsArray.append(dataset4)
    datasetsArray.append(dataset5)
    datasetsArray.append(dataset6)
    datasetsArray.append(dataset7)
    datasetsArray.append(dataset8)
    datasetsArray.append(dataset9)
    datasetsArray.append(dataset10)
    datasetsArray.append(dataset11)
    datasetsArray.append(dataset12)
    datasetsArray.append(dataset13)
    datasetsArray.append(dataset14)

    return 'C:\Users\ALEIX\Desktop\AI_Master\IML\Work1\datasets\datasets\\' + datasetsArray[x][0]

def getDatasetInfo(x):
    dataset0 = ['iris.arff', 3]  # 3c Little, only numbers, 33% each class
    dataset1 = ['glass.arff', 2]  # 2c Little, only numbers
    dataset2 = ['grid.arff', 2]  # Medium, both classes, 50% each class
    dataset3 = ['adult.arff', 2]  # Large, both classes
    dataset4 = ['hepatitis.arff', 2]  # Little, both classes
    dataset5 = ['autos.arff', 6]  # Little, both classes
    dataset6 = ['kropt.arff', 18]  # Very large, only nominal
    dataset7 = ['waveform.arff', 3]  # Large, only numbers
    dataset8 = ['pen-based.arff', 10]  # Large, only numbers
    dataset9 = ['satimage.arff', 6]  # Large, only numbers, huge difference between instances to each class ************
    dataset10 = ['pima_diabetes.arff', 2]
    dataset11 = ['satimage.arff', 6]
    dataset12 = ['bal.arff', 3]  # balance scale
    dataset13 = ['breast-w.arff', 2]  # breast cancer wisconsin
    dataset14 = ['soybean.arff', 19]  # only nominal but with little difference inside class and huge difference between instances to each class

    datasetsArray = []
    datasetsArray.append(dataset0)
    datasetsArray.append(dataset1)
    datasetsArray.append(dataset2)
    datasetsArray.append(dataset3)
    datasetsArray.append(dataset4)
    datasetsArray.append(dataset5)
    datasetsArray.append(dataset6)
    datasetsArray.append(dataset7)
    datasetsArray.append(dataset8)
    datasetsArray.append(dataset9)
    datasetsArray.append(dataset10)
    datasetsArray.append(dataset11)
    datasetsArray.append(dataset12)
    datasetsArray.append(dataset13)
    datasetsArray.append(dataset14)

    return datasetsArray[x]