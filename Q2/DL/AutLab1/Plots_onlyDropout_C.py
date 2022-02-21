import numpy as np
import matplotlib.pyplot as plt
import os


dir = os.getcwd() + '\\variables\\'

model1 = 'L2_0005-drop_06_09'

J_validation_1 = np.load(dir + 'J_validation_' + model1 + '.npy')
acc_validation_1 = np.load(dir + 'acc_validation_' + model1 + '.npy')


model2 = 'L2_0005-drop_07_09'

J_validation_2 = np.load(dir + 'J_validation_' + model2 + '.npy')
acc_validation_2 = np.load(dir + 'acc_validation_' + model2 + '.npy')

model3 = 'L2_0005-drop_08_09'

J_validation_3 = np.load(dir + 'J_validation_' + model3 + '.npy')
acc_validation_3 = np.load(dir + 'acc_validation_' + model3 + '.npy')

model4 = 'L2_0005-drop_09_09'

J_validation_4 = np.load(dir + 'J_validation_' + model4 + '.npy')
acc_validation_4 = np.load(dir + 'acc_validation_' + model4 + '.npy')

model5 = 'L2_0005-drop_10_09'

J_validation_5 = np.load(dir + 'J_validation_' + model5 + '.npy')
acc_validation_5 = np.load(dir + 'acc_validation_' + model5 + '.npy')

print(np.max(acc_validation_1), np.max(acc_validation_2), np.max(acc_validation_3), np.max(acc_validation_4), np.max(acc_validation_5))

xaxis = np.arange(50)

plt.figure(1)
plt.plot(xaxis,J_validation_1[:50], label=r'$p_{fc} = 0.6$')
plt.plot(xaxis,J_validation_2[:50], label=r'$p_{fc} = 0.7$')
plt.plot(xaxis,J_validation_3[:50], label=r'$p_{fc} = 0.8$')
plt.plot(xaxis,J_validation_4[:50], label=r'$p_{fc} = 0.9$')
plt.plot(xaxis,J_validation_5[:50], label=r'$p_{fc} = 1.0$')
plt.xlabel(r'Number of epochs')
plt.ylabel(r'Validation Cost Function')
#plt.ylim(0,None)
plt.grid()
plt.legend()


plt.figure(2)
plt.plot(xaxis,acc_validation_1[:50], label=model1)
plt.plot(xaxis,acc_validation_2[:50], label=model2)
plt.plot(xaxis,acc_validation_3[:50], label=model3)
plt.plot(xaxis,acc_validation_4[:50], label=model4)
plt.plot(xaxis,acc_validation_5[:50], label=model5)
plt.xlabel(r'Number of epochs')
plt.ylabel(r'Validation set accuracy')
#plt.ylim(0,60)
plt.grid()
plt.legend()

plt.show()