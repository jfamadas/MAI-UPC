function [error, FP, FN, TP, TN] = fold_validation(features, labels, subjects, NFolds)
% FOLD VALIDATION: compute the classification rates of validation after
%classification.
% Inputs:
% features: each columns is a sample and each row is a variable or feature:
% Variables x Samples
% labels: 1xS it contains all the labels (1 patients, 0 controls)
% subjects
% F: F fold validation will be used
% Outputs: vectors containing the rates of validation after classification.

%% Estimate the number of subjects for every fold
id_subjects = unique(subjects);
% We assume that all the subjects have the same number of images samples:
NOcc = sum(subjects==id_subjects(1));
Nsubjects = length(id_subjects);
Ntest = floor(Nsubjects/NFolds);

%% Randomly sort the data set before validation
p=randperm(Nsubjects);
id_subjects=id_subjects(p);

%% Loop of NFolds 
for i = 1:NFolds
    
    if i==NFolds
        n = id_subjects((i-1)*Ntest+1:i*Ntest);    
    else
        n = id_subjects((i-1)*Ntest+1:i*Ntest);    
    end
    
    index=ismember(subjects,n);

    % Load Training Set     
    TrainSet = features(:,find(index ~= 1)');
    TrainLabels=labels(:,find(index ~= 1)');

    % Load Test Set
    TestSet  = features(:,find(index == 1)');
    TestLabel = labels(:,find(index == 1)');
    NTest = length(TestLabel);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Normalization    
    T_TrainSet=TrainSet';
    T_TestSet=TestSet';
    
    % Compute mean and variance:
    m=mean(T_TrainSet);
    v=std(T_TrainSet);

    % Normalize Training Set:
    mMatrix = ones (size(T_TrainSet,1), 1) * m;
    vMatrix = ones (size(T_TrainSet,1), 1) * v;
    T_TrainSet=(T_TrainSet-mMatrix)./vMatrix;

    % Normalize Test Set:
    mMatrix = ones (size(T_TestSet,1), 1) * m;
    vMatrix = ones (size(T_TestSet,1), 1) * v;    
    T_TestSet=(T_TestSet-mMatrix)./vMatrix;      
    
    % Transpose the data:
    TrainSet=T_TrainSet';
    TestSet=T_TestSet';
   
    % Train a k-nn classifier and test the test samples using knnclassify.m
    k=2;
    idx = knnclassify(TestSet', TrainSet', TrainLabels', k);
    Result_labels=idx';
        
    % Compute the classification rates
    thrs=0;
    FP(i) = sum(Result_labels(TestLabel==0)==1); 
    FN(i) = sum(Result_labels(TestLabel==1)==0);
    TP(i) = sum(Result_labels(TestLabel==1)==1); 
    TN(i) = sum(Result_labels(TestLabel==0)==0);
    error(i)=FP(i)+FN(i)/NTest;

end

end





