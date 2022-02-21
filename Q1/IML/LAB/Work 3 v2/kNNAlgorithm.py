from __future__ import  division
import numpy as np
from auxiliarMethods import *
from numpy  import array

def kNNAlgorithm(k, train_data, train_labels, test_data, test_labels, distance_type):


    """
    :param k: number of neighbours
    :param train_data: training data in a matrix
    :param train_labels: outputs of training data
    :param test_data: test data in a matrix
    :param test_labels: outputs of test data (for the accuracy)
    :return: k neighbouts closer
    """

    accuracy = 0
    # FUNCIONA PARA CADA UNO
    aun = 0

    # fijamos instancia de test
    for testInstance in test_data:
        aun += 1
        measuredistance = []
        output = []
        # fijamos instancia de train
        for trainInstance in train_data:
            # medimos distancia entre ellas
            distanceTrainTest = distance(trainInstance, testInstance, distance_type=distance_type)
            # almacenamos
            measuredistance.append(distanceTrainTest)

        # cuando ya tenemos un array que contiene las distancias a la instancia de test ordenamos y sacamos los K indices menores
        arrayDistance = array(measuredistance)
        indexofmostlikely = np.argsort(arrayDistance)[:k]

        # Recogemos las salidas correspondientes a las K instancias que mas se parecen
        for i in range(k):
            output.append(str(train_labels[indexofmostlikely[i]]))

        # FINAL ES EL OUTPUT QUE DEBE DAR LA INSTANCIA: la media si es numerico y si es nominal el mas comun
        try:
            final = mean(output)
        except:
            final = Most_Common(output)

        # Para sacar el rendimiento, si final coincide con lo que deberia ir sumamos uno
        if final == str(test_labels[aun-1]):
            accuracy += 1

    rendimiento = accuracy / len(test_data)
    #print "Acertadas ", str(accuracy), " de un total de " + str(len(test_data)),"dando un porcentaje de acierto de " + str(rendimiento)





    return accuracy, len(test_data)



