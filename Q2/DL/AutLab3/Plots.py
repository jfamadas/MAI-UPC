import numpy as np
import matplotlib.pyplot as plt

ex = '3'

model1 = 'accuracy_15epochs'
J_1 = np.load('results_ex' + ex + '/' + model1 + '.npy')

model2 = 'accuracy_15epochs_initialization'
J_2 = np.load('results_ex' + ex + '/' + model2 + '.npy')
#
# model3 = 'rmsProp_0005'
# J_3 = np.load('results_ex' + ex + '/' + model3 + '.npy')

# model4 = 'rmsProp_0005'
# J_4 = np.load('results_ex' + ex + '/' + model4 + '.npy')
#
# model5 = 'rmsProp_00025'
# J_5 = np.load('results_ex' + ex + '/' + model5 + '.npy')

xaxis = np.arange(J_1.shape[0])

plt.figure(1)
plt.plot(xaxis, 100*J_1, label='Basic Initialization')
plt.plot(xaxis, 100*J_2, label='Enhanced Initialization')
# plt.semilogy(xaxis, J_3, label='RMSProp || lr = 0.005')
# plt.semilogy(xaxis, J_4, label='RMSProp || lr = 0.005')
# plt.semilogy(xaxis, J_5, label='RMSProp || lr = 0.0025')
plt.xlabel('Epochs')
plt.ylabel('Accuracy (%)')
# plt.title('dsadasd')
# plt.ylim(0, 2)
# plt.ylim(1e-13, 1e3)
plt.grid()
plt.legend()

plt.show()