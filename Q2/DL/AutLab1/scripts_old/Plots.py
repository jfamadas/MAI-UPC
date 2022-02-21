import numpy as np
import matplotlib.pyplot as plt
import os


dir = os.getcwd() + '\\variables\\'
model = 'deeper32'

J_train_deeper = np.load(dir + 'J_train_' + model + '.npy')
acc_train_deeper = np.load(dir + 'acc_train_' + model + '.npy')
J_validation_deeper = np.load(dir + 'J_validation_' + model + '.npy')
acc_validation_deeper = np.load(dir + 'acc_validation_' + model + '.npy')


model = 'basic32'

J_train_basic = np.load(dir + 'J_train_' + model + '.npy')
acc_train_basic = np.load(dir + 'acc_train_' + model + '.npy')
J_validation_basic = np.load(dir + 'J_validation_' + model + '.npy')
acc_validation_basic = np.load(dir + 'acc_validation_' + model + '.npy')

model = 'deep32'

J_train_deep = np.load(dir + 'J_train_' + model + '.npy')
acc_train_deep = np.load(dir + 'acc_train_' + model + '.npy')
J_validation_deep = np.load(dir + 'J_validation_' + model + '.npy')
acc_validation_deep = np.load(dir + 'acc_validation_' + model + '.npy')




xaxis = np.arange(J_train_basic.shape[0])

plt.figure(1)
plt.plot(xaxis,J_train_basic, label='Training: basic')
plt.plot(xaxis,J_train_deep[:50], label='Training: deep')
plt.plot(xaxis,J_train_deeper[:50], label='Training: deeper')
plt.plot(xaxis,J_validation_basic, label='Val: basic')
plt.plot(xaxis,J_validation_deep[:50], label='Val: deep')
plt.plot(xaxis,J_validation_deeper[:50], label='Val: deeper')
#plt.ylim(0,60)
plt.grid()
plt.legend()


plt.figure(2)
plt.plot(xaxis,acc_train_basic, label='Training: basic')
plt.plot(xaxis,acc_train_deep[:50], label='Training: deep')
plt.plot(xaxis,acc_train_deeper[:50], label='Training: deeper')
plt.plot(xaxis,acc_validation_basic, label='Val: basic')
plt.plot(xaxis,acc_validation_deep[:50], label='Val: deep')
plt.plot(xaxis,acc_validation_deeper[:50], label='Val: deeper')
plt.grid()
plt.legend()

plt.show()
