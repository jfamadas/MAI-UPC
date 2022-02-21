from __future__ import absolute_import, division, print_function
import nltk
import numpy as np
import tensorflow as tf
from gensim.models import word2vec
import re
import multiprocessing
import sklearn.manifold
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

files = ''
for i in range(7):
    file = open('corpus/book' + str(i+1) + '.txt', 'r', encoding='utf-8').read()
    files = files + file

sentences = nltk.sent_tokenize(files)


words = []
for sentence in sentences:
    clean = re.sub("[^a-zA-Z]", " ", sentence)
    words.append(clean.split())


# Size of the embedding vector
num_features = 300

# Minimum word count
min_word_count = 3

# Context window size
context_size = 7

# For paralel computing
num_workers = multiprocessing.cpu_count()

seed = 1

# MODEL

model = word2vec.Word2Vec(sentences=words, sg=1, seed=seed, workers=num_workers, size=num_features, min_count=min_word_count,
                          window=context_size, sample=1e-3)

# say_vector = model['Harry']
# model.build_vocab(words)
model.train(words, total_examples=model.corpus_count, epochs=model.epochs)

# Save the model
# model.save('trained/hp1.w2v')

tsne = sklearn.manifold.TSNE(n_components=2, random_state=0)

wordlist = np.array(model.wv.index2entity)
embedding_matrix = model.wv.syn0

plot_matrix = tsne.fit_transform(embedding_matrix)


points = pd.DataFrame(
    [
        (word, coords[0], coords[1])
        for word, coords in [
            (word, plot_matrix[model.wv.vocab[word].index])
            for word in model.wv.vocab
        ]
    ],
    columns=["word", "x", "y"]
)

print(points.head(10))

sns.set_context("poster")


points.plot.scatter("x", "y", s=10, figsize=(20, 12))


def plot_region(x_bounds, y_bounds):
    slice = points[
        (x_bounds[0] <= points.x) &
        (points.x <= x_bounds[1]) &
        (y_bounds[0] <= points.y) &
        (points.y <= y_bounds[1])
        ]

    ax = slice.plot.scatter("x", "y", s=35, figsize=(10, 8))
    for i, point in slice.iterrows():
        ax.text(point.x + 0.005, point.y + 0.005, point.word, fontsize=11)


plot_region(x_bounds=(4.0, 4.2), y_bounds=(-0.5, -0.1))

print('final')

