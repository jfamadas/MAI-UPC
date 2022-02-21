import numpy as np
import matplotlib.pyplot as plt
import os


dir = os.getcwd() + '\\variables\\'

model1 = 'basic'

J_validation_1 = np.load(dir + 'J_validation_' + model1 + '.npy')
acc_validation_1 = np.load(dir + 'acc_validation_' + model1 + '.npy')


model2 = 'L2_001'

J_validation_2 = np.load(dir + 'J_validation_' + model2 + '.npy')
acc_validation_2 = np.load(dir + 'acc_validation_' + model2 + '.npy')

model3 = 'L2_0005'

J_validation_3 = np.load(dir + 'J_validation_' + model3 + '.npy')
acc_validation_3 = np.load(dir + 'acc_validation_' + model3 + '.npy')

model4 = 'L2_0001'

J_validation_4 = np.load(dir + 'J_validation_' + model4 + '.npy')
acc_validation_4 = np.load(dir + 'acc_validation_' + model4 + '.npy')

print(np.max(acc_validation_1), np.max(acc_validation_2), np.max(acc_validation_3), np.max(acc_validation_4))

xaxis = np.arange(50)

plt.figure(1)
plt.plot(xaxis, J_validation_1[:50], label=r'No regularization')
plt.plot(xaxis, J_validation_2[:50], label=r'$\beta$ = 0.01')
plt.plot(xaxis, J_validation_3[:50], label=r'$\beta$ = 0.005')
plt.plot(xaxis, J_validation_4[:50], label=r'$\beta$ = 0.001')
plt.xlabel(r'Number of epochs')
plt.ylabel(r'Validation Cost Function')
#plt.ylim(0,60)
plt.grid()
plt.legend()


plt.figure(2)
plt.plot(xaxis,acc_validation_1[:50], label='No regularization')
plt.plot(xaxis,acc_validation_2[:50], label=r'$\beta$ = 0.01')
plt.plot(xaxis,acc_validation_3[:50], label=r'$\beta$ = 0.005')
plt.plot(xaxis,acc_validation_4[:50], label=r'$\beta$ = 0.001')
plt.xlabel(r'Number of epochs')
plt.ylabel(r'Validation set accuracy')
#plt.ylim(0,60)
plt.grid()
plt.legend()

plt.show()