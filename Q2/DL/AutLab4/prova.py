import os
import numpy as np
import nltk
import re

# OPEN THE FILES AND TOKENIZE THE CORPUS
files = ''
os.chdir('C:\\Users\\Josep Famadas\\Desktop\\UPC\\Master\\Q2\\DL\\AutLab4')
for i in range(7):
    file = open('corpus/book' + str(i+1) + '.txt', 'r', encoding='utf-8').read()
    files = files + file

sentences = nltk.sent_tokenize(files)

# TOKENIZE THE SENTENCES
words = []
single_list = []
for sentence in sentences:
    clean = re.sub("[^a-zA-Z]", " ", sentence)
    words.append(clean.split())
    single_list.extend(clean.split())

print('final')

# # Characters to query, by house
# griff = ['Harry', 'Ron', 'Hermione', 'Nevile']
# slith = ['Draco', 'Crabbe', 'Goyle']
# huff = ['Sprout', 'Tonks']
# rave = ['Luna']
#
# # All characters
# characters = np.concatenate((griff, slith, huff, rave))
#
# # Real labels
# houses_true = np.concatenate((np.repeat(['Gryffindor'], len(griff)), np.repeat(['Slytherin'], len(slith)),
#                               np.repeat(['Hufflepuff'], len(huff)), np.repeat(['Ravenclaw'], len(rave))))
#
# houses = np.array(['Gryffindor', 'Slytherin', 'Hufflepuff', 'Ravenclaw'])
#
# sim_mat = np.zeros([characters.shape[0], houses.shape[0]])
# assignation = np.zeros([characters.shape[0],2],dtype='<U10')
# for i, character in enumerate(characters):
#     for j,house in enumerate(houses):
#         sim_mat[i,j] = np.random.randint(0,10)
#     assignation[i,0] = character
#     assignation[i,1] = houses[np.argmax(sim_mat[i,:])]
#
# print('final')