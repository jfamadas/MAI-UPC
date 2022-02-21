from __future__ import division
from cmath import sqrt
from collections import Counter
import difflib
import itertools
import re
import math
import numpy as np

"""
SCRIPT FOR AUXILIAR FUNCTIONS
"""

WORD = re.compile(r'\w+')


# Measure the distance between two instances

def distance(instance1, instance2, distance_type):
    distance = 0
    cosine_vec1 = []
    cosine_vec2 = []
    for i in range(0, len(instance1)):
        try:
            # The i-th feature is numerical (if float() works)
            float(instance1[i])

            if distance_type == 'Manhattan':
                """
                MANHATTAN (Se ha confundido y ha puesto hamming en la guia)
                """
                distance += abs(float(instance1[i]) - float(instance2[i]))

            elif distance_type == 'Euclidean':
                """
                EUCLIDEAN
                """
                distance += abs(float(instance1[i]) - float(instance2[i])) ** 2

            elif distance_type == 'Cosine':
                cosine_vec1.append(float(instance1[i]))
                cosine_vec2.append(float(instance2[i]))

            elif distance_type == 'Difflib':
                pass  # CODE HERE

        except:
            # The i-th feature is nominal (if float() does not work)

            if str(instance1[i]) == str(instance2[i]):
                pass
            else:
                distance += 1

    # Post aggregation of distances
    if distance_type == 'Euclidean':
        # It has performed the last iteration, so it makes the square root of the sum of distances
        distance = sqrt(distance)

    elif distance_type == 'Cosine':
        # Performs the cosine distance between the 2 cosine vectors and adds it to the distance
        cv1 = np.array(cosine_vec1)
        cv2 = np.array(cosine_vec2)
        cosin = np.dot(cv1,cv2)/(np.linalg.norm(cv1)*np.linalg.norm(cv2))
        distance += cosin
    return distance


# Buscar el mas comun de una lista (para string)
def Most_Common(lst):
    data = Counter(lst)
    return data.most_common(1)[0][0]


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


"""
PROBANDO LAS DISTANCIAS CON LISTAS SIMPLES, QUEDA PROBARLAS CON INSTANCIAS

a = [1, 2, 3]
b = [3, 2, 1]

print manhattan(a,b)
print euclidean(a,b)
print distanceLevenshtein(a, b)
print get_cosine(a,b)

"""
