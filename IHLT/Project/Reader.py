import nltk
import os
import numpy as np
from nltk.stem import WordNetLemmatizer
from nltk.corpus import wordnet as wn
import nltk
import os
import numpy as np
from nltk.stem import WordNetLemmatizer
from nltk.corpus import wordnet as wn
import string
from nltk.parse.corenlp import CoreNLPDependencyParser


def read(train_test):
    # Create a reader for the train/test file and its true labels
    current_path = os.path.dirname(os.path.abspath(__file__))
    file = open(current_path + '\\IHLT-eval-framework\\' + train_test + '\\msr_paraphrase_' + train_test + '_input.txt',
                encoding='utf8')
    file_class = open(
        current_path + '\\IHLT-eval-framework\\' + train_test + '\\msr_paraphrase_' + train_test + '_gs.txt',
        encoding='utf8')

    # LIST OF TRAIN SENTENCES
    sentence_list = []
    for line in file:
        s = nltk.sent_tokenize(line)
        if len(s) == 1:
            s = s[0].split(' \t ')
        sentence_list.append(s)

    # LIST OF TRAIN SENTENCES WITH WORDS
    labels_true = np.array([])
    sentence_word_list = []
    sentence_lemmas_list = []
    sentence_synsets_list = []
    punctuation_eraser = str.maketrans(dict.fromkeys(string.punctuation))
    for i,sentences in enumerate(sentence_list):

        # SEPARATE THE SENTENCES IN WORDS
        sentence_word_list.append([nltk.word_tokenize(sentences[0].translate(punctuation_eraser)), nltk.word_tokenize(sentences[1].translate(punctuation_eraser))])

        # COMPUTE THE LEMMAS OF THE WORDS
        t_POS_list0 = nltk.pos_tag(sentence_word_list[-1][0])
        t_POS_list1 = nltk.pos_tag(sentence_word_list[-1][1])
        toks0 = [lemmatize(x) for x in t_POS_list0]
        toks1 = [lemmatize(x) for x in t_POS_list1]
        sentence_lemmas_list.append([toks0, toks1])

        # COMPUTE SYNSETS
        sentence_aux0 = []
        for word in sentence_word_list[-1][0]:
            try:  # Intenta afegir al auxiliar el synset de la paraula
                sentence_aux0.append(wn.synsets(word)[0])

            except:  # Si no existeix el synset d'aquella paraula, afegeix null
                sentence_aux0.append('Null')
        sentence_aux1 = []
        for word in sentence_word_list[-1][1]:
            try:  # Intenta afegir al auxiliar el synset de la paraula
                sentence_aux1.append(wn.synsets(word)[0])
            except:  # Si no existeix el synset d'aquella paraula, afegeix null
                sentence_aux1.append('Null')

        sentence_synsets_list.append([sentence_aux0, sentence_aux1])
        if np.remainder(i, 500) == 0:
            print(i)

        # COMPUTE THE TRUE LABELS
        labels_true = np.append(labels_true, [file_class.readline()[-2]])


    return sentence_list,sentence_word_list, sentence_lemmas_list, sentence_synsets_list, labels_true.astype(np.int)

def read_triples(train_test):

    parser = CoreNLPDependencyParser(url='http://localhost:9000')

    # Create a reader for the train/test file and its true labels
    current_path = os.path.dirname(os.path.abspath(__file__))
    file = open(current_path + '\\IHLT-eval-framework\\' + train_test + '\\msr_paraphrase_' + train_test + '_input.txt',
                encoding='utf8')
    file_class = open(
        current_path + '\\IHLT-eval-framework\\' + train_test + '\\msr_paraphrase_' + train_test + '_gs.txt',
        encoding='utf8')

    # FOR EACH LINE IN THE INPUT FILE SPLITS IT INTO TRIPLES
    triples_list = []
    labels_true = []
    for i,line in enumerate(file):
        s = nltk.sent_tokenize(line)
        if len(s) == 1:
            s = s[0].split(' \t ')
        triples_pair = []
        try:
            for sentence in s:
                triples = []
                parse, = parser.raw_parse(sentence)
                for governor, dep, dependent in parse.triples():
                    triples.append(''.join(governor) + '|' + dep + '|' + ''.join(dependent))
                triples_pair.append(triples)
            triples_list.append(triples_pair)
            # COMPUTE THE TRUE LABELS
            labels_true = np.append(labels_true, [file_class.readline()[-2]])
        except:
            triples_list.append(triples_list[-1])
            labels_true = np.append(labels_true, [file_class.readline()[-2]])
        if np.remainder(i, 500) == 0:
            print(i)



    return triples_list, labels_true.astype(np.int)


def lemmatize(x):
    wnl = WordNetLemmatizer()
    if x[1][0] in {'N', 'V'}:
        return wnl.lemmatize(x[0], pos=x[1][0].lower())
    return x[0]