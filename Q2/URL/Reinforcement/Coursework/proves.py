import matplotlib.pyplot as plt

vector = np.zeros(2000)
for i in range(2000):
    vector[i] = np.mean(episodes[10*i : 10*(i+1)])
plt.plot(10*np.arange(2000), vector)
plt.ylabel('Number of episodes')
plt.xlabel('Number of trial')
plt.show()