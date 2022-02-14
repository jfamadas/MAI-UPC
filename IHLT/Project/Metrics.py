from __future__ import division
import numpy as np
import nltk
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import TfidfVectorizer
from scipy import spatial
from sklearn.metrics.pairwise import cosine_similarity

sw = stopwords.words('english')


def jaccard(sentence_list):
    jacc = np.zeros([len(sentence_list)], dtype=np.float)
    for i in range(len(sentence_list)):
        jacc[i] = len(set(sentence_list[i][0]).intersection(sentence_list[i][1])) / len(
            set(sentence_list[i][0]).union(sentence_list[i][1]))

    return jacc


def simple_word_overlap_IDF(sentence_list,type):
    swo = np.zeros([len(sentence_list)], dtype=np.float)
    idf = IDF(sentence_list,type)
    for i, sentence in enumerate(sentence_list):
        s1 = sentence[0]
        s2 = sentence[1]
        v1 = []
        v2 = []

        for word in s1:
            idx = idf.vocabulary_.get(word.lower())
            v1.append(idf.idf_[idx])

        for word in s2:
            idx = idf.vocabulary_.get(word.lower())
            v2.append(idf.idf_[idx])

        intersection = list(set(s1).intersection(s2))
        v3 = []
        for word in intersection:
            idx = idf.vocabulary_.get(word.lower())
            v3.append(idf.idf_[idx])
        try:
            swo[i] = sum(v3)/max([sum(v1),sum(v2)])
        except:
            swo[i] = 0.5

    return swo


def phrasal_overlap_measure(sentence_list):
    swo = np.zeros([len(sentence_list)], dtype=np.float)
    for i in range(len(sentence_list)):
        overlap = 0
        s1 = sentence_list[i][0]
        s2 = sentence_list[i][1]
        ini = len(s1)
        for j in range(ini, 0, -1):
            for k in range(0, ini - j + 1):
                if k + j > len(s1):
                    break
                gloss = s1[k:k + j]
                if ((''.join(gloss) in ''.join(s2)) and gloss[0] not in sw and gloss[-1] not in sw):
                    overlap = overlap + j * j
                    s1 = s1[0:k] + [''.join(gloss) + ' '] + s1[k + j:len(s1)]
        swo[i] = np.tanh(float(overlap) / (ini + len(s2)))

    return swo


def TFIDF(sentences,type):
    cosinesim = np.zeros([len(sentences)])
    for i in range(len(sentences)):
        v1 = []
        v2 = []
        s1 = sentences[i][0]
        s2 = sentences[i][1]
        text = [' '.join(s1), ' '.join(s2)]
        if type=='standard':
            tfidf1,tfidf2 = TfidfVectorizer(tokenizer=nltk.word_tokenize, stop_words=[]).fit_transform(text)
        elif type == 'whitespace':
            tfidf1, tfidf2 = TfidfVectorizer(tokenizer=nltk.WhitespaceTokenizer().tokenize, stop_words=[]).fit_transform(text)
        s1 = list(dict.fromkeys(sentences[i][0]).keys())
        s2 = list(dict.fromkeys(sentences[i][1]).keys())
        words = set(s1).union(s2)

        for word in words:
            try:
                idx1 = s1.index(word)
                v1.append(tfidf1.data[idx1])
            except:
                v1.append(0)

            try:
                idx2 = s2.index(word)
                v2.append(tfidf2.data[idx2])
            except:
                v2.append(0)
        if (sum(v1)> 0 and sum(v2)>0):
            cosinesim[i] = 1 - spatial.distance.cosine(v1, v2)
        else:
            cosinesim[i] = 0

    return cosinesim
def IDF(sentences,type):
    text = []
    for sentence in sentences:
        s1 = sentence[0]
        s2 = sentence[1]
        text.append(' '.join(s1))
        text.append(' '.join(s2))
    if type == 'standard':
        idf = TfidfVectorizer(tokenizer=nltk.word_tokenize, stop_words=[]).fit(text)
    elif type == 'whitespace':
        idf = TfidfVectorizer(tokenizer=nltk.WhitespaceTokenizer().tokenize, stop_words=[]).fit(text)
    return idf

def ResultsStatistics(labels_pred,labels_true):
    TP = sum((np.array(labels_true) == 1)*(np.array(labels_pred)==1))
    TN = sum((np.array(labels_true) == 0)*(np.array(labels_pred)==0))
    FP = sum((np.array(labels_true) == 0)*(np.array(labels_pred)==1))
    FN = sum((np.array(labels_true) == 1)*(np.array(labels_pred)==0))
    Accuracy = (TP+TN)*1.0/(TP+FP+TN+FN)
    Precision = TP*1.0/(TP+FP)
    Recall = TP*1.0/(TP+FN)
    F1 = 2 * (Precision * Recall) / (Precision + Recall)
    return Accuracy, Precision, Recall, F1