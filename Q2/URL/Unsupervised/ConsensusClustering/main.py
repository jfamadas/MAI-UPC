"""K-means based consensus clustering"""

# Authors: Josep Famadas <jfamadas95@gmail.com>


import warnings
import numpy as np
import sklearn
from sklearn import cluster
from sklearn import datasets
import scipy as sp
from kemlglearn.cluster.consensus import SimpleConsensusClustering
from scipy.cluster.hierarchy import linkage, fcluster
from sklearn.mixture import GaussianMixture


###############################################################################
# Main function


def KCC(partitionings, w, distance_type, K, data_instances):
    """K-means consensus clustering algorithm.

    Parameters
    ----------
    partitionings : list of KMeans Objects, len (n_basicPartitions)
        The basic partitions from which a consensus partition has to be achieved.

    w : ndarray of floats, shape (n_basicPartitions,)
        Weights associated to every basic partition.

    distance_type : {'U_c', 'U_H', 'U_cos', 'U_Lp'}
        Type of distance used:

        'U_c' : Euclidean distance.

        'U_H': KL-divergence.

        'U_cos': Cosine distance.

        'U_Lp': Lp norm.

    K : int
        Number of desired clusters in the final partition.

    data_instances : ndarray, shape (n_dataInstances, n_features)
        Dataset on which the basic partitionings have been computed.


    Returns
    -------
    partition_labels : ndarray of int, shape (n_dataInstances,)
        Labels of the data instances in the final consensus partitioning
    """
    r = len(partitionings)  # Number of basic partitions
    n = partitionings[0].labels_.size  # Number of data instances
    clusters_per_partition = []  # Number of clusters of each basic partition
    bin_dataset = []

    # BINARY DATASET BUILDING
    for i in range(r):
        clusters_per_partition.append(partitionings[i].n_clusters)
        bin_dataset.append(
            sklearn.preprocessing.OneHotEncoder().fit_transform(partitionings[i].labels_.reshape(-1, 1)).toarray())
    bin_dataset = np.concatenate(bin_dataset, 1).astype(np.float32)
    clusters_per_partition = np.array(clusters_per_partition)

    # CLUSTERING THE BINARY DATASET
    partition_labels = myKMeans(bin_dataset, K, w, clusters_per_partition, trials=100, type=distance_type, data=data_instances)

    return partition_labels


def myKMeans(dataset, K, w, clusters_per_partition, trials, type, data):
    """K-means algorithm.

    Parameters
    ----------
    dataset : ndarray of bools, shape (n_dataInstances, sum(n_clusters of each basic partition))
        Binary matrix with the basic partitions information.

    K : int
        Number of desired clusters in the final partition.

    w : ndarray of floats, shape (n_basicPartitions,)
        Weights associated to every basic partition.

    clusters_per_partition : ndarray of int, shape (n_basicPartitions,)
        Number of clusters of each basic partition.

    trials : int
        Number of different random initialization, from which the best final result is returned.

    type : {'U_c', 'U_H', 'U_cos', 'U_Lp'}
        Type of distance used:

        'U_c' : Euclidean distance.

        'U_H': KL-divergence.

        'U_cos': Cosine distance.

        'U_Lp': Lp norm.

    data : ndarray, shape (n_dataInstances, n_features)
        Dataset on which the basic partitionings have been computed.


    Returns
    -------
    best_labels : ndarray of int, shape (n_dataInstances,)
        Labels of the data instances in the final consensus partitioning
    """
    best_partition_evaluation = 0
    partition_evaluation = 0
    best_labels = []

    for trial in range(trials):
        print('TRIAL: ' + str(trial + 1))

        # RANDOM CENTROIDS INITIALIZATION
        unique_examples = np.unique(dataset, axis=0)
        idx = np.random.choice(np.arange(unique_examples.shape[0]), K)
        centroids = unique_examples[idx, :]

        # DISTANCES INITIALIZATION TO 0
        distances = np.zeros((dataset.shape[0], K))
        point_centroid_distance = np.zeros(clusters_per_partition.shape[0])
        cumulated = np.cumsum(clusters_per_partition)
        labels_old = np.zeros(dataset.shape[0]) - 1

        for iterations in range(50):  # Make as maximum 50 iterations

            # PHASE 1: CLUSTER COMPUTATION
            # 1.1 distance sample-clusters
            for i in range(dataset.shape[0]):  # Makes it for each dataset sample || i = index of sample
                sample = dataset[i, :]
                for j in range(K):  # Computes de distance between the sample and each centroid || j = index of centroid
                    idx1 = 0
                    for k in range(cumulated.shape[
                                       0]):  # Make the distance computation for each split of the sample associated with the original partitions
                        idx2 = cumulated[k]
                        point_centroid_distance[k] = compute_Distance(sample[idx1:idx2], centroids[j, idx1:idx2],
                                                                      dist_type=type)
                        idx1 = idx2
                    distances[i, j] = np.sum(w * point_centroid_distance)

            # 1.2 Centroid assignation
            labels = np.argmin(distances, axis=1)

            # Check that there is no error
            if np.unique(labels).shape[0] != K:
                break

            # If the labels are the same as the previous iteration, the trial ends
            if (labels == labels_old).all():
                break
            labels_old = labels

            # 1.3 Centroid recomputing
            idx1 = 0
            for k in range(cumulated.shape[0]):  # || k = index for the basic partition equivalent
                idx2 = cumulated[k]
                mat = sklearn.metrics.cluster.contingency_matrix(labels, partitions[k].labels_)
                centroids[:, idx1:idx2] = mat / mat.sum(axis=1, keepdims=1)
                idx1 = idx2

        # END OF THE TRIAL
        # Trial results evaluation
        try:
            partition_evaluation = sklearn.metrics.calinski_harabaz_score(data, labels)
        except:
            pass
        if partition_evaluation > best_partition_evaluation:
            best_partition_evaluation = partition_evaluation
            best_labels = labels

    return best_labels


def compute_Distance(sample, centroid, dist_type):
    """Distance computation.

    Parameters
    ----------
    sample : ndarray of bools, shape (sample_size,)
        Sample of the binary matrix from which the distance has to be computed to the centroid.

    centroid : ndarray of floats, shape (sample_size,)
        Centroid from which the distance has to be computed to the sample.

    dist_type : {'U_c', 'U_H', 'U_cos', 'U_Lp'}
        Type of distance used:

        'U_c' : Euclidean distance.

        'U_H': KL-divergence.

        'U_cos': Cosine distance.

        'U_Lp': Lp norm.


    Returns
    -------
    dist : float
        Distance value between the sample and the centroid
    """
    if dist_type == 'U_c':
        dist = np.sum(np.power((sample - centroid), 2))
        return dist
    elif dist_type == 'U_H':
        epsilon = 1e-10
        dist = sp.stats.entropy(sample + epsilon, centroid + epsilon)
        return dist
    elif dist_type == 'U_cos':
        epsilon = 1e-10
        dist = sp.spatial.distance.cosine(sample + epsilon, centroid + epsilon)
        return dist
    elif dist_type == 'U_Lp':
        p = 5
        norm = np.power(np.sum(np.power(centroid, p)), (p - 1) / p)
        dist = 1.0 - np.sum(sample * np.power(centroid, p - 1)) / norm
        return dist


if __name__ == '__main__':
    # LOAD DATA (the desired dataset has to be uncommented and comment the others)
    dataset = datasets.load_iris()
    # dataset = datasets.load_breast_cancer()
    # dataset = datasets.load_wine()

    data = dataset.data
    labels_true = dataset.target

    # GENERATING BASIC PARTITIONINGS
    r = 100  # Number of basic partitionings
    K = np.unique(labels_true).shape[0]  # Actual number of clusters
    n = data.shape[0]  # Number of data objects (instances)
    partitions = []
    for i in range(r):
        nclusters = np.random.randint(K, np.sqrt(n) + 1)
        partitions.append(cluster.KMeans(n_clusters=nclusters, n_init=10).fit(data))

    # WEIGHTS
    w = np.ones(r) / r

    # CALL THE FUNCTION
    consensus_labels = KCC(partitions, w, 'U_c', K, data_instances=data)

    # OTHER CLUSTETINGS METHODS
    # Simple consensus clustering
    simple_consensus = SimpleConsensusClustering(n_clusters=K, n_clusters_base=10, n_components=30, ncb_rand=False)
    simple_consensus.fit(data)
    simple_consensus_labels = simple_consensus.labels_

    # Hierarchical clustering (single link)
    clust_single = linkage(data, method='single')
    clust_single_labels = fcluster(clust_single, K, criterion='maxclust')

    # Hierarchical clustering (complete link)
    clust_complete = linkage(data, method='complete')
    clust_complete_labels = fcluster(clust_complete, K, criterion='maxclust')

    # Gaussian Mixture Model
    gmm = GaussianMixture(n_components=3, covariance_type='spherical')
    gmm.fit(data)
    gmm_labels = gmm.predict(data)

    # K-Means
    km = cluster.KMeans(n_clusters=K, n_init=10).fit(data)
    km_labels = km.labels_

    # EVALUATION OF THE DIFFERENT CLUSTERINGS (including KCC)
    rn_consensus = sklearn.metrics.adjusted_rand_score(consensus_labels, labels_true)
    rn_simple_consensus = sklearn.metrics.adjusted_rand_score(simple_consensus_labels, labels_true)
    rn_clust_single = sklearn.metrics.adjusted_rand_score(clust_single_labels, labels_true)
    rn_clust_complete = sklearn.metrics.adjusted_rand_score(clust_complete_labels, labels_true)
    rn_gmm = sklearn.metrics.adjusted_rand_score(gmm_labels, labels_true)
    rn_km = sklearn.metrics.adjusted_rand_score(km_labels, labels_true)

    print('KCC partition:           Rn = ' + str(rn_consensus))
    print('Simple consensus:        Rn = ' + str(rn_simple_consensus))
    print('Hierarchical (single):   Rn = ' + str(rn_clust_single))
    print('Hierarchical (complete): Rn = ' + str(rn_clust_complete))
    print('Gaussian Mixture Model:  Rn = ' + str(rn_gmm))
    print('K-Means:                 Rn = ' + str(rn_km))
