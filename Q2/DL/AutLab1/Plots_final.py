import numpy as np
import matplotlib.pyplot as plt
import os


dir = os.getcwd() + '\\variables\\'

model1 = 'drop_06_07'

J_train_1 = np.load(dir + 'J_train_' + model1 + '.npy')
acc_train_1 = np.load(dir + 'acc_train_' + model1 + '.npy')
J_validation_1 = np.load(dir + 'J_validation_' + model1 + '.npy')
acc_validation_1 = np.load(dir + 'acc_validation_' + model1 + '.npy')


model2 = 'drop_07_07'

J_train_2 = np.load(dir + 'J_train_' + model2 + '.npy')
acc_train_2 = np.load(dir + 'acc_train_' + model2 + '.npy')
J_validation_2 = np.load(dir + 'J_validation_' + model2 + '.npy')
acc_validation_2 = np.load(dir + 'acc_validation_' + model2 + '.npy')

model3 = 'drop_09_07'

J_train_3 = np.load(dir + 'J_train_' + model3 + '.npy')
acc_train_3 = np.load(dir + 'acc_train_' + model3 + '.npy')
J_validation_3 = np.load(dir + 'J_validation_' + model3 + '.npy')
acc_validation_3 = np.load(dir + 'acc_validation_' + model3 + '.npy')




xaxis = np.arange(J_train_1[:50].shape[0])

plt.figure(1)
plt.plot(xaxis,J_train_1[:50], label='Training: ' + model1)
plt.plot(xaxis,J_train_2[:50], label='Training: ' + model2)
plt.plot(xaxis,J_train_3[:50], label='Training: ' + model3)
plt.plot(xaxis,J_validation_1[:50], label='Val: ' + model1)
plt.plot(xaxis,J_validation_2[:50], label='Val: ' + model2)
plt.plot(xaxis,J_validation_3[:50], label='Val: ' + model3)
#plt.ylim(0,60)
plt.grid()
plt.legend()


plt.figure(2)
plt.plot(xaxis,acc_train_1[:50], label='Training: ' + model1)
plt.plot(xaxis,acc_train_2[:50], label='Training: ' + model2)
plt.plot(xaxis,acc_train_3[:50], label='Training: ' + model3)
plt.plot(xaxis,acc_validation_1[:50], label='Val: ' + model1)
plt.plot(xaxis,acc_validation_2[:50], label='Val: ' + model2)
plt.plot(xaxis,acc_validation_3[:50], label='Val: ' + model3)
plt.grid()
plt.legend()

plt.show()