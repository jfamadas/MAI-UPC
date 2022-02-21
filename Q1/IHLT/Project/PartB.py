from __future__ import division
import nltk
from nltk.parse.corenlp import CoreNLPDependencyParser

parser = CoreNLPDependencyParser(url='http://localhost:9000')

def jaccard_coefficient ( input1, input2 ):
# Compara dos sentences i torna el jaccard coeficient
    return len(set(input1).intersection(input2)) / len(set(input1).union(input2))


# Load input file
file = open('C:\\Users\\Josep Famadas\\Desktop\\IHLT\\Session9\\msr_paraphrase_train_input.txt')

n = 3 #number of couple of sentences

# Divide input file in sentences, a list of sublists with a pair of sentences in each sublist
i = 0
sentence_list = []
for line in file:
    if i < n:
        sentence_list.append(nltk.sent_tokenize(line))
        i = i+1
    else:
        break


triples_list = []
for pair in sentence_list:
    triples_pair = []
    for sentence in pair:
        triples = []
        parse, = parser.raw_parse(sentence)
        for governor, dep, dependent in parse.triples():
            triples.append(' '.join(governor) + ' | ' + dep + ' | ' + ' '.join(dependent))
        triples_pair.append(triples)
    triples_list.append(triples_pair)


# Compute the jaccard similarity for each pair of sentences
i = 1
for triples in triples_list:
    jacc = jaccard_coefficient(triples[0],triples[1])
    print("Jaccard similarity between sentences: " + str(i) + " and " + str(i + 1) + " is: " + str(jacc))