% This make.m is used under Windows

mex -O -c svm.cpp
mex -O -c svm_model_matlab.c
mex -O svmtrain.c svm.o svm_model_matlab.o
mex -O svmpredict.c svm.o svm_model_matlab.o
mex -O libsvmread.c
mex -O libsvmwrite.c
