import matplotlib.pyplot as plt


def plot(xaxis, yaxis, title):
    figure,ax = plt.subplots()
    ax.plot(xaxis, yaxis, 'o')
    ax.set_title(title)
    plt.show()
