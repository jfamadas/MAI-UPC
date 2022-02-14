import numpy as np
import matplotlib.pyplot as plt
from Reader import read, read_triples
from sklearn.linear_model import LogisticRegression
import Metrics

# Reads the words and lemmas of the training and test sets.
sentence_list_train, sentence_word_list_train, sentence_lemmas_list_train, sentence_synsets_list_train, labels_true_train = read(
    'train')
sentence_list_test, sentence_word_list_test, sentence_lemmas_list_test, sentence_synsets_list_test, labels_true_test = read(
    'test')

# Reads the triples of the training and test sets.
list_triples_train, labels_true_train_triples = read_triples('train')
list_triples_test, labels_true_test_triples = read_triples('test')

'''
----------------------------------
            PART 1
----------------------------------
'''

# METRICS COMPUTATION

# Phrasal overlap measure
swo_words = Metrics.phrasal_overlap_measure(sentence_word_list_train)
swo_words_test = Metrics.phrasal_overlap_measure(sentence_word_list_test)
swo_lemmas = Metrics.phrasal_overlap_measure(sentence_lemmas_list_train)
swo_lemmas_test = Metrics.phrasal_overlap_measure(sentence_lemmas_list_test)
print('Phrasal Overlap Measure done')

# Jaccard
jacc_words = Metrics.jaccard(sentence_word_list_train)
jacc_words_test = Metrics.jaccard(sentence_word_list_test)
jacc_lemmas = Metrics.jaccard(sentence_lemmas_list_train)
jacc_lemmas_test = Metrics.jaccard(sentence_lemmas_list_test)
print('Jaccard done')

# Cosine
cosinesim_lemmas = Metrics.TFIDF(sentence_lemmas_list_train, type='standard')
cosinesim_lemmas_test = Metrics.TFIDF(sentence_lemmas_list_test, type='standard')
cosinesim_words = Metrics.TFIDF(sentence_word_list_train, type='standard')
cosinesim_words_test = Metrics.TFIDF(sentence_word_list_test, type='standard')
print('Cosine Similarity TF-IDF done')

# Simple Word Overlap
sim_wo_words = Metrics.simple_word_overlap_IDF(sentence_word_list_train, type='standard')
sim_wo_words_test = Metrics.simple_word_overlap_IDF(sentence_word_list_test, type='standard')
sim_wo_lemmas = Metrics.simple_word_overlap_IDF(sentence_lemmas_list_train, type='standard')
sim_wo_lemmas_test = Metrics.simple_word_overlap_IDF(sentence_lemmas_list_test, type='standard')
print('IDF Simple Overlap Measure')



# TRAINING AND TEST

# Phrasal Overlap Measure Accuracy using Words.
Classifier = LogisticRegression()
Classifier.fit(swo_words[:, np.newaxis], labels_true_train)
labels_predicted = Classifier.predict(swo_words_test[:, np.newaxis])
Accuracy_words_swo, Precision_words_swo, Recall_words_swo, F1_words_swo = Metrics.ResultsStatistics(labels_predicted,
                                                                                                    labels_true_test)

# Phrasal Overlap Measure Accuracy using Lemmas.
Classifier = LogisticRegression()
Classifier.fit(swo_lemmas[:, np.newaxis], labels_true_train)
labels_predicted = Classifier.predict(swo_lemmas_test[:, np.newaxis])
Accuracy_lemmas_swo, Precision_lemmas_swo, Recall_lemmas_swo, F1_lemmas_swo = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test)

# Jaccard Accuracy using Words
Classifier = LogisticRegression()
Classifier.fit(jacc_words[:, np.newaxis], labels_true_train)
labels_predicted = Classifier.predict(jacc_words_test[:, np.newaxis])
Accuracy_words_jacc, Precision_words_jacc, Recall_words_jacc, F1_words_jacc = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test)

# Jaccard Accuracy using Lemmas
Classifier = LogisticRegression()
Classifier.fit(jacc_lemmas[:, np.newaxis], labels_true_train)
labels_predicted = Classifier.predict(jacc_lemmas_test[:, np.newaxis])
Accuracy_lemmas_jacc, Precision_lemmas_jacc, Recall_lemmas_jacc, F1_lemmas_jacc = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test)

# TFIDF cosine similarity using words
Classifier = LogisticRegression()
Classifier.fit(cosinesim_words[:, np.newaxis], labels_true_train)
labels_predicted = Classifier.predict(cosinesim_words_test[:, np.newaxis])
Accuracy_words_cosinesim, Precision_words_cosinesim, Recall_words_cosinesim, F1_words_cosinesim = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test)

# TFIDF cosine similarity using lemmas
Classifier = LogisticRegression()
Classifier.fit(cosinesim_lemmas[:, np.newaxis], labels_true_train)
labels_predicted = Classifier.predict(cosinesim_lemmas_test[:, np.newaxis])
Accuracy_lemmas_cosinesim, Precision_lemmas_cosinesim, Recall_lemmas_cosinesim, F1_lemmas_cosinesim = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test)

# Simple word overlap IDF using words
Classifier = LogisticRegression()
Classifier.fit(sim_wo_words[:, np.newaxis], labels_true_train)
labels_predicted = Classifier.predict(sim_wo_words_test[:, np.newaxis])
Accuracy_words_sim_wo, Precision_words_sim_wo, Recall_words_sim_wo, F1_words_sim_wo = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test)

# Simple word overlap IDF using Lemmas
Classifier = LogisticRegression()
Classifier.fit(sim_wo_lemmas[:, np.newaxis], labels_true_train)
labels_predicted = Classifier.predict(sim_wo_lemmas_test[:, np.newaxis])
Accuracy_lemmas_sim_wo, Precision_lemmas_sim_wo, Recall_lemmas_sim_wo, F1_lemmas_sim_wo = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test)


# RESULTS

# ONLY WORDS
print('\n\nACCURACY:\n')
print('Jaccard         : ' + str(Accuracy_words_jacc))
print('Phrasal overlap : ' + str(Accuracy_words_swo))
print('IDF word overlap: ' + str(Accuracy_words_sim_wo))
print('TF-IDF cosine   : ' + str(Accuracy_words_cosinesim))

print('\n\nPRECISION:\n')
print('Jaccard         : ' + str(Precision_words_jacc))
print('Phrasal overlap : ' + str(Precision_words_swo))
print('IDF word overlap: ' + str(Precision_words_sim_wo))
print('TF-IDF cosine   : ' + str(Precision_words_cosinesim))

print('\n\nRECALL:\n')
print('Jaccard         : ' + str(Recall_words_jacc))
print('Phrasal overlap : ' + str(Recall_words_swo))
print('IDF word overlap: ' + str(Recall_words_sim_wo))
print('TF-IDF cosine   : ' + str(Recall_words_cosinesim))

print('\n\nF1:\n')
print('Jaccard         : ' + str(F1_words_jacc))
print('Phrasal overlap : ' + str(F1_words_swo))
print('IDF word overlap: ' + str(F1_words_sim_wo))
print('TF-IDF cosine   : ' + str(F1_words_cosinesim))

# LEMMAS

print('\n\nACCURACY (LEMMAS):\n')
print('Jaccard         : ' + str(Accuracy_lemmas_jacc))
print('Phrasal overlap : ' + str(Accuracy_lemmas_swo))
print('IDF word overlap: ' + str(Accuracy_lemmas_sim_wo))
print('TF-IDF cosine   : ' + str(Accuracy_lemmas_cosinesim))

print('\n\nPRECISION (LEMMAS):\n')
print('Jaccard         : ' + str(Precision_lemmas_jacc))
print('Phrasal overlap : ' + str(Precision_lemmas_swo))
print('IDF word overlap: ' + str(Precision_lemmas_sim_wo))
print('TF-IDF cosine   : ' + str(Precision_lemmas_cosinesim))

print('\n\nRECALL (LEMMAS):\n')
print('Jaccard         : ' + str(Recall_lemmas_jacc))
print('Phrasal overlap : ' + str(Recall_lemmas_swo))
print('IDF word overlap: ' + str(Recall_lemmas_sim_wo))
print('TF-IDF cosine   : ' + str(Recall_lemmas_cosinesim))

print('\n\nF1 (LEMMAS):\n')
print('Jaccard         : ' + str(F1_lemmas_jacc))
print('Phrasal overlap : ' + str(F1_lemmas_swo))
print('IDF word overlap: ' + str(F1_lemmas_sim_wo))
print('TF-IDF cosine   : ' + str(F1_lemmas_cosinesim))

'''
--------------------------------------
                PART 2
--------------------------------------
'''

# METRICS COMPUTATION

# Jaccard
jacc_triples = Metrics.jaccard(list_triples_train)
jacc_triples_test = Metrics.jaccard(list_triples_test)

# Cosine
cosinesim_triples = Metrics.TFIDF(list_triples_train, type='whitespace')
cosinesim_triples_test = Metrics.TFIDF(list_triples_test, type='whitespace')

# Simple Word Overlap
sim_wo_triples = Metrics.simple_word_overlap_IDF(list_triples_train, type='whitespace')
sim_wo_triples_test = Metrics.simple_word_overlap_IDF(list_triples_test, type='whitespace')


# TRAINING AND TEST

# Jaccard
Classifier = LogisticRegression()
Classifier.fit(jacc_triples[:, np.newaxis], labels_true_train_triples)
labels_predicted = Classifier.predict(jacc_triples_test[:, np.newaxis])
Accuracy_triples_jacc, Precision_triples_jacc, Recall_triples_jacc, F1_triples_jacc = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test_triples)

# Cosine
Classifier = LogisticRegression()
Classifier.fit(cosinesim_triples[:, np.newaxis], labels_true_train_triples)
labels_predicted = Classifier.predict(cosinesim_triples_test[:, np.newaxis])
Accuracy_triples_cosinesim, Precision_triples_cosinesim, Recall_triples_cosinesim, F1_triples_cosinesim = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test_triples)

# Simple Word Overlap
Classifier = LogisticRegression()
Classifier.fit(sim_wo_triples[:, np.newaxis], labels_true_train_triples)
labels_predicted = Classifier.predict(sim_wo_triples_test[:, np.newaxis])
Accuracy_triples_sim_wo, Precision_triples_sim_wo, Recall_triples_sim_wo, F1_triples_sim_wo = Metrics.ResultsStatistics(
    labels_predicted, labels_true_test_triples)


# RESULTS

# TRIPLES
print('\n\nACCURACY (TRIPLES):\n')
print('Jaccard         : ' + str(Accuracy_triples_jacc))
print('IDF word overlap: ' + str(Accuracy_triples_sim_wo))
print('TF-IDF cosine   : ' + str(Accuracy_triples_cosinesim))

print('\n\nPRECISION (TRIPLES) :\n')
print('Jaccard         : ' + str(Precision_triples_jacc))
print('IDF word overlap: ' + str(Precision_triples_sim_wo))
print('TF-IDF cosine   : ' + str(Precision_triples_cosinesim))

print('\n\nRECALL (TRIPLES) :\n')
print('Jaccard         : ' + str(Recall_triples_jacc))
print('IDF word overlap: ' + str(Recall_triples_sim_wo))
print('TF-IDF cosine   : ' + str(Recall_triples_cosinesim))

print('\n\nF1 (TRIPLES) :\n')
print('Jaccard         : ' + str(F1_triples_jacc))
print('IDF word overlap: ' + str(F1_triples_sim_wo))
print('TF-IDF cosine   : ' + str(F1_triples_cosinesim))


# GENERAL

# GENERAL MATRIX CREATION
mat_train = np.transpose(np.array([jacc_words, jacc_lemmas, jacc_triples, cosinesim_words, cosinesim_lemmas, cosinesim_triples
                 , sim_wo_words, sim_wo_lemmas, sim_wo_triples, swo_words, swo_lemmas]))
mat_test = np.transpose(np.array([jacc_words_test, jacc_lemmas_test, jacc_triples_test, cosinesim_words_test, cosinesim_lemmas_test,
              cosinesim_triples_test, sim_wo_words_test, sim_wo_lemmas_test, sim_wo_triples_test, swo_words_test,
              swo_lemmas_test]))

# TRAINING AND TEST
Classifier = LogisticRegression()
Classifier.fit(mat_train, labels_true_train)
labels_predicted = Classifier.predict(mat_test)
Accuracy_general, Precision_general, Recall_general, F1_general = Metrics.ResultsStatistics(labels_predicted,
                                                                                            labels_true_test)
classifier_coefficients = Classifier.coef_[0]

AccuracyVec = [Accuracy_triples_jacc, Accuracy_triples_cosinesim, Accuracy_triples_sim_wo, Accuracy_lemmas_jacc,
               Accuracy_words_jacc, Accuracy_lemmas_swo, Accuracy_words_swo, Accuracy_lemmas_cosinesim,
               Accuracy_words_cosinesim, Accuracy_lemmas_sim_wo, Accuracy_words_sim_wo, Accuracy_general]
PrecisionVec = [Precision_triples_jacc, Precision_triples_cosinesim, Precision_triples_sim_wo, Precision_lemmas_jacc,
                Precision_words_jacc, Precision_lemmas_swo, Precision_words_swo, Precision_lemmas_cosinesim,
                Precision_words_cosinesim, Precision_lemmas_sim_wo, Precision_words_sim_wo, Precision_general]
RecallVec = [Recall_triples_jacc, Recall_triples_cosinesim, Recall_triples_sim_wo, Recall_lemmas_jacc,
             Recall_words_jacc, Recall_lemmas_swo, Recall_words_swo, Recall_lemmas_cosinesim, Recall_words_cosinesim,
             Recall_lemmas_sim_wo, Recall_words_sim_wo, Recall_general]
F1Vec = [F1_triples_jacc, F1_triples_cosinesim, F1_triples_sim_wo, F1_lemmas_jacc, F1_words_jacc, F1_lemmas_swo,
         F1_words_swo, F1_lemmas_cosinesim, F1_words_cosinesim, F1_lemmas_sim_wo, F1_words_sim_wo, F1_general]


# RESULTS

mat = np.array([AccuracyVec, PrecisionVec, RecallVec, F1Vec])
plt.colorbar(plt.imshow(mat))
plt.show()

# GENERAL
print('\nACCURACY (GENERAL):' + str(Accuracy_general))

print('\nPRECISION (GENERAL) :' + str(Precision_general))

print('\nRECALL (GENERAL) :' + str(Recall_general))

print('\nF1 (GENERAL) :' + str(F1_general))

print('\n\nCLASSIFIER COEFFICIENTS:\n')
print('Jaccard (Words)              : '+str(classifier_coefficients[0]))
print('Jaccard (Lemmas)             : '+str(classifier_coefficients[1]))
print('Jaccard (Triples)            : '+str(classifier_coefficients[2]))
print('Cosine (Words)               : '+str(classifier_coefficients[3]))
print('Cosine (Lemmas)              : '+str(classifier_coefficients[4]))
print('Cosine (Triples)             : '+str(classifier_coefficients[5]))
print('Simple word overlap (Words)  : '+str(classifier_coefficients[6]))
print('Simple word overlap (Lemmas) : '+str(classifier_coefficients[7]))
print('Simple word overlap (Triples): '+str(classifier_coefficients[8]))
print('Phrasal overlap (Words)      : '+str(classifier_coefficients[9]))
print('Phrasal overlap (Lemmas)     : '+str(classifier_coefficients[10]))


'''
Training size variation
'''

step = 500

Accuracy_mat = np.zeros((int(np.floor(np.size(list_triples_train)/step)),12))
Precision_mat = Accuracy_mat.copy()
Recall_mat = Accuracy_mat.copy()
F1_mat = Accuracy_mat.copy()

axis_horizontal = np.zeros(int(np.floor(np.size(list_triples_train)/step)))

for i in range(int(np.floor(np.size(list_triples_train)/step))):
    print('Current train size = '+str(500*(i+1)))
    current_list_triples = list_triples_train[0:step*(i+1)]
    current_list_words = sentence_word_list_train[0:step * (i + 1)]
    current_list_lemmas = sentence_lemmas_list_train[0:step * (i + 1)]
    current_labels = labels_true_train[0:step*(i+1)]


    # Phrasal overlap measure
    print('Phrasal overlap measure')
    swo_words = Metrics.phrasal_overlap_measure(current_list_words)
    swo_lemmas = Metrics.phrasal_overlap_measure(current_list_lemmas)

    # Jaccard
    print('Jaccard')
    jacc_words = Metrics.jaccard(current_list_words)
    jacc_lemmas = Metrics.jaccard(current_list_lemmas)
    jacc_triples = Metrics.jaccard(current_list_triples)

    # Cosine
    print('Cosine')
    cosinesim_lemmas = Metrics.TFIDF(current_list_lemmas, type='standard')
    cosinesim_words = Metrics.TFIDF(current_list_words, type='standard')
    cosinesim_triples = Metrics.TFIDF(current_list_triples, type='whitespace')

    # Simple Word Overlap
    print('Simple word overlap')
    sim_wo_words = Metrics.simple_word_overlap_IDF(current_list_words, type='standard')
    sim_wo_lemmas = Metrics.simple_word_overlap_IDF(current_list_lemmas, type='standard')
    sim_wo_triples = Metrics.simple_word_overlap_IDF(current_list_triples, type='whitespace')

    # TRAINING AND TEST

    # Phrasal Overlap Measure Accuracy using Words.
    Classifier = LogisticRegression()
    Classifier.fit(swo_words[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(swo_words_test[:, np.newaxis])
    Accuracy_words_swo, Precision_words_swo, Recall_words_swo, F1_words_swo = Metrics.ResultsStatistics(
        labels_predicted,
        labels_true_test)

    # Phrasal Overlap Measure Accuracy using Lemmas.
    Classifier = LogisticRegression()
    Classifier.fit(swo_lemmas[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(swo_lemmas_test[:, np.newaxis])
    Accuracy_lemmas_swo, Precision_lemmas_swo, Recall_lemmas_swo, F1_lemmas_swo = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test)

    # Jaccard Accuracy using Words
    Classifier = LogisticRegression()
    Classifier.fit(jacc_words[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(jacc_words_test[:, np.newaxis])
    Accuracy_words_jacc, Precision_words_jacc, Recall_words_jacc, F1_words_jacc = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test)

    # Jaccard Accuracy using Lemmas
    Classifier = LogisticRegression()
    Classifier.fit(jacc_lemmas[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(jacc_lemmas_test[:, np.newaxis])
    Accuracy_lemmas_jacc, Precision_lemmas_jacc, Recall_lemmas_jacc, F1_lemmas_jacc = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test)

    # TFIDF cosine similarity using words
    Classifier = LogisticRegression()
    Classifier.fit(cosinesim_words[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(cosinesim_words_test[:, np.newaxis])
    Accuracy_words_cosinesim, Precision_words_cosinesim, Recall_words_cosinesim, F1_words_cosinesim = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test)

    # TFIDF cosine similarity using lemmas
    Classifier = LogisticRegression()
    Classifier.fit(cosinesim_lemmas[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(cosinesim_lemmas_test[:, np.newaxis])
    Accuracy_lemmas_cosinesim, Precision_lemmas_cosinesim, Recall_lemmas_cosinesim, F1_lemmas_cosinesim = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test)

    # Simple word overlap IDF using words
    Classifier = LogisticRegression()
    Classifier.fit(sim_wo_words[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(sim_wo_words_test[:, np.newaxis])
    Accuracy_words_sim_wo, Precision_words_sim_wo, Recall_words_sim_wo, F1_words_sim_wo = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test)

    # Simple word overlap IDF using Lemmas
    Classifier = LogisticRegression()
    Classifier.fit(sim_wo_lemmas[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(sim_wo_lemmas_test[:, np.newaxis])
    Accuracy_lemmas_sim_wo, Precision_lemmas_sim_wo, Recall_lemmas_sim_wo, F1_lemmas_sim_wo = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test)

    # Jaccard using triples
    Classifier = LogisticRegression()
    Classifier.fit(jacc_triples[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(jacc_triples_test[:, np.newaxis])
    Accuracy_triples_jacc, Precision_triples_jacc, Recall_triples_jacc, F1_triples_jacc = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test_triples)

    # Cosine using triples
    Classifier = LogisticRegression()
    Classifier.fit(cosinesim_triples[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(cosinesim_triples_test[:, np.newaxis])
    Accuracy_triples_cosinesim, Precision_triples_cosinesim, Recall_triples_cosinesim, F1_triples_cosinesim = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test_triples)

    # Simple Word Overlap using triples
    Classifier = LogisticRegression()
    Classifier.fit(sim_wo_triples[:, np.newaxis], current_labels)
    labels_predicted = Classifier.predict(sim_wo_triples_test[:, np.newaxis])
    Accuracy_triples_sim_wo, Precision_triples_sim_wo, Recall_triples_sim_wo, F1_triples_sim_wo = Metrics.ResultsStatistics(
        labels_predicted, labels_true_test_triples)

    # GENERAL MATRIX CREATION
    mat_train = np.transpose(np.array([jacc_words, jacc_lemmas, jacc_triples, cosinesim_words, cosinesim_lemmas, cosinesim_triples
                     , sim_wo_words, sim_wo_lemmas, sim_wo_triples, swo_words, swo_lemmas]))

    # TRAINING AND TEST
    Classifier = LogisticRegression()
    Classifier.fit(mat_train, current_labels)
    labels_predicted = Classifier.predict(mat_test)
    Accuracy_general, Precision_general, Recall_general, F1_general = Metrics.ResultsStatistics(labels_predicted,
                                                                                                labels_true_test)
    classifier_coefficients = Classifier.coef_[0]

    AccuracyVec = [Accuracy_triples_jacc, Accuracy_triples_cosinesim, Accuracy_triples_sim_wo, Accuracy_lemmas_jacc,
                   Accuracy_words_jacc, Accuracy_lemmas_swo, Accuracy_words_swo, Accuracy_lemmas_cosinesim,
                   Accuracy_words_cosinesim, Accuracy_lemmas_sim_wo, Accuracy_words_sim_wo, Accuracy_general]

    PrecisionVec = [Precision_triples_jacc, Precision_triples_cosinesim, Precision_triples_sim_wo,
                    Precision_lemmas_jacc, Precision_words_jacc, Precision_lemmas_swo, Precision_words_swo, Precision_lemmas_cosinesim,
                    Precision_words_cosinesim, Precision_lemmas_sim_wo, Precision_words_sim_wo, Precision_general]

    RecallVec = [Recall_triples_jacc, Recall_triples_cosinesim, Recall_triples_sim_wo, Recall_lemmas_jacc,
                 Recall_words_jacc, Recall_lemmas_swo, Recall_words_swo, Recall_lemmas_cosinesim, Recall_words_cosinesim,
                 Recall_lemmas_sim_wo, Recall_words_sim_wo, Recall_general]

    F1Vec = [F1_triples_jacc, F1_triples_cosinesim, F1_triples_sim_wo, F1_lemmas_jacc, F1_words_jacc, F1_lemmas_swo,
             F1_words_swo, F1_lemmas_cosinesim, F1_words_cosinesim, F1_lemmas_sim_wo, F1_words_sim_wo, F1_general]

    Accuracy_mat[i,:] = AccuracyVec
    Precision_mat[i,:] = PrecisionVec
    Recall_mat[i,:] = RecallVec
    F1_mat[i,:] = F1Vec

    axis_horizontal[i] = (i+1)*500

# ACCURACY
fig, ax = plt.subplots()
ax.plot(axis_horizontal, Accuracy_mat[:,4], 'r', label = 'Jaccard (Words)')
ax.plot(axis_horizontal, Accuracy_mat[:,3], 'r--', label = 'Jaccard (Lemmas)')
ax.plot(axis_horizontal, Accuracy_mat[:,0], 'r:', label = 'Jaccard (Triples)')
ax.plot(axis_horizontal, Accuracy_mat[:,8], 'g', label = 'Cosine (Words)')
ax.plot(axis_horizontal, Accuracy_mat[:,7], 'g--', label = 'Cosine (Lemmas)')
ax.plot(axis_horizontal, Accuracy_mat[:,1], 'g:', label = 'Cosine (Triples)')
ax.plot(axis_horizontal, Accuracy_mat[:,10], 'b', label = 'Simple Word Overlap (Words)')
ax.plot(axis_horizontal, Accuracy_mat[:,9], 'b--', label = 'Simple Word Overlap (Lemmas)')
ax.plot(axis_horizontal, Accuracy_mat[:,2], 'b:', label = 'Simple Word Overlap (Triples)')
ax.plot(axis_horizontal, Accuracy_mat[:,6], 'y', label = 'Phrasal Word Overlap (Words)')
ax.plot(axis_horizontal, Accuracy_mat[:,5], 'y--', label = 'Phrasal Word Overlap (Lemmas)')
ax.plot(axis_horizontal, Accuracy_mat[:,11], 'k', label = 'General')
ax.set_title('ACCURACY')
plt.legend(bbox_to_anchor=(1, 1))
plt.savefig('Accuracy.jpg',bbox_inches='tight')
plt.show()


# PRECISION
fig, ax = plt.subplots()
ax.plot(axis_horizontal, Precision_mat[:,4], 'r', label = 'Jaccard (Words)')
ax.plot(axis_horizontal, Precision_mat[:,3], 'r--', label = 'Jaccard (Lemmas)')
ax.plot(axis_horizontal, Precision_mat[:,0], 'r:', label = 'Jaccard (Triples)')
ax.plot(axis_horizontal, Precision_mat[:,8], 'g', label = 'Cosine (Words)')
ax.plot(axis_horizontal, Precision_mat[:,7], 'g--', label = 'Cosine (Lemmas)')
ax.plot(axis_horizontal, Precision_mat[:,1], 'g:', label = 'Cosine (Triples)')
ax.plot(axis_horizontal, Precision_mat[:,10], 'b', label = 'Simple Word Overlap (Words)')
ax.plot(axis_horizontal, Precision_mat[:,9], 'b--', label = 'Simple Word Overlap (Lemmas)')
ax.plot(axis_horizontal, Precision_mat[:,2], 'b:', label = 'Simple Word Overlap (Triples)')
ax.plot(axis_horizontal, Precision_mat[:,6], 'y', label = 'Phrasal Word Overlap (Words)')
ax.plot(axis_horizontal, Precision_mat[:,5], 'y--', label = 'Phrasal Word Overlap (Lemmas)')
ax.plot(axis_horizontal, Precision_mat[:,11], 'k', label = 'General')
ax.set_title('PRECISION')
plt.legend(bbox_to_anchor=(1, 1))
plt.savefig('Precision.jpg',bbox_inches='tight')
plt.show()


# RECALL
fig, ax = plt.subplots()
ax.plot(axis_horizontal, Recall_mat[:,4], 'r', label = 'Jaccard (Words)')
ax.plot(axis_horizontal, Recall_mat[:,3], 'r--', label = 'Jaccard (Lemmas)')
ax.plot(axis_horizontal, Recall_mat[:,0], 'r:', label = 'Jaccard (Triples)')
ax.plot(axis_horizontal, Recall_mat[:,8], 'g', label = 'Cosine (Words)')
ax.plot(axis_horizontal, Recall_mat[:,7], 'g--', label = 'Cosine (Lemmas)')
ax.plot(axis_horizontal, Recall_mat[:,1], 'g:', label = 'Cosine (Triples)')
ax.plot(axis_horizontal, Recall_mat[:,10], 'b', label = 'Simple Word Overlap (Words)')
ax.plot(axis_horizontal, Recall_mat[:,9], 'b--', label = 'Simple Word Overlap (Lemmas)')
ax.plot(axis_horizontal, Recall_mat[:,2], 'b:', label = 'Simple Word Overlap (Triples)')
ax.plot(axis_horizontal, Recall_mat[:,6], 'y', label = 'Phrasal Word Overlap (Words)')
ax.plot(axis_horizontal, Recall_mat[:,5], 'y--', label = 'Phrasal Word Overlap (Lemmas)')
ax.plot(axis_horizontal, Recall_mat[:,11], 'k', label = 'General')
ax.set_title('RECALL')
plt.legend(bbox_to_anchor=(1, 1))
plt.savefig('Recall.jpg',bbox_inches='tight')
plt.show()


# F1
fig, ax = plt.subplots()
ax.plot(axis_horizontal, F1_mat[:,4], 'r', label = 'Jaccard (Words)')
ax.plot(axis_horizontal, F1_mat[:,3], 'r--', label = 'Jaccard (Lemmas)')
ax.plot(axis_horizontal, F1_mat[:,0], 'r:', label = 'Jaccard (Triples)')
ax.plot(axis_horizontal, F1_mat[:,8], 'g', label = 'Cosine (Words)')
ax.plot(axis_horizontal, F1_mat[:,7], 'g--', label = 'Cosine (Lemmas)')
ax.plot(axis_horizontal, F1_mat[:,1], 'g:', label = 'Cosine (Triples)')
ax.plot(axis_horizontal, F1_mat[:,10], 'b', label = 'Simple Word Overlap (Words)')
ax.plot(axis_horizontal, F1_mat[:,9], 'b--', label = 'Simple Word Overlap (Lemmas)')
ax.plot(axis_horizontal, F1_mat[:,2], 'b:', label = 'Simple Word Overlap (Triples)')
ax.plot(axis_horizontal, F1_mat[:,6], 'y', label = 'Phrasal Word Overlap (Words)')
ax.plot(axis_horizontal, F1_mat[:,5], 'y--', label = 'Phrasal Word Overlap (Lemmas)')
ax.plot(axis_horizontal, F1_mat[:,11], 'k', label = 'General')
ax.set_title('F1 COEFFICIENT')
plt.legend(bbox_to_anchor=(1, 1))
plt.savefig('F1_coefficient.jpg',bbox_inches='tight')
plt.show()





print('final')
