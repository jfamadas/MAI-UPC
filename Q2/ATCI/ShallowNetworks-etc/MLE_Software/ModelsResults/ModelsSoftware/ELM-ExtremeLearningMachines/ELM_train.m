
function [TrainingTime,TrainingAccuracy,ELM_model] = ELM_train(TrainingData_File, Elm_Type, NumberofHiddenNeurons, Param)

% Usage: elm_train(TrainingData_File, Elm_Type, NumberofHiddenNeurons, ...)
% OR:    [TrainingTime, TrainingAccuracy] = elm_train(TrainingData_File, Elm_Type, NumberofHiddenNeurons, ..)
%
% Input:
% TrainingData_File         - Filename of training data set (ERM - modified)
% Elm_Type                  - 0 for regression; 1 for (both binary and multi-classes) classification
% NumberofHiddenNeurons     - Number of hidden neurons assigned to the ELM
% Param.ActFunH             - Type of activation function:
%                               'sig' for Sigmoidal function
%                               'sin' for Sine function
%                               'hardlim' for Hardlim function
% Param.Temperature         - Temperature of the activation function
% Param.WithBias            - Indicates whether there is bias or not
% Param.IniWeights          - Type of weights initialization
%                               'Random' for original random weight initialization
%                               'InputRandom' for weight initialization from input data randomly
% Param.MaxIterInput        - If IniWeights = 'InputRandom', maximum of iterations for finding a valid subset of input data
%
% Output: 
% TrainingTime              - Time (seconds) spent on training ELM
% TrainingAccuracy          - Training accuracy: 
%                               RMSE for regression or correct classification rate for classification
%
% MULTI-CLASSE CLASSIFICATION: NUMBER OF OUTPUT NEURONS WILL BE AUTOMATICALLY SET EQUAL TO NUMBER OF CLASSES
% FOR EXAMPLE, if there are 7 classes in all, there will have 7 output
% neurons; neuron 5 has the highest output means input belongs to 5-th class
%
%
    %%%%    Authors:    MR QIN-YU ZHU AND DR GUANG-BIN HUANG
    %%%%    NANYANG TECHNOLOGICAL UNIVERSITY, SINGAPORE
    %%%%    EMAIL:      EGBHUANG@NTU.EDU.SG; GBHUANG@IEEE.ORG
    %%%%    WEBSITE:    http://www.ntu.edu.sg/eee/icis/cv/egbhuang.htm
    %%%%    DATE:       APRIL 2004

%%% Parameters
ActivationFunction = Param.ActFunH;
Temperature = Param.Temperature;
WithBias = Param.WithBias;
IniWeights = Param.IniWeights;
MaxIterInput = Param.MaxIterInput;

%%%%%%%%%%% Macro definition
REGRESSION=0;
CLASSIFIER=1;

%%%%%%%%%%% Load training dataset
%%%train_data=load(TrainingData_File); %%% ERM
train_data=TrainingData_File;          %%% ERM
T=train_data(:,1)';                    %'  target data
P=train_data(:,2:size(train_data,2))'; %'  input data
clear train_data;                                %   Release raw training data array

NumberofTrainingData=size(P,2);
NumberofInputNeurons=size(P,1);

if Elm_Type~=REGRESSION
    %%%%%%%%%%%% Preprocessing the data of classification
    sorted_target=sort(T,2);
    label=zeros(1,1);    %   Find and save in 'label' class label from training and testing data sets
    label(1,1)=sorted_target(1,1);
    j=1;
    for i = 2:NumberofTrainingData
        if sorted_target(1,i) ~= label(1,j)
            j=j+1;
            label(1,j) = sorted_target(1,i);
        end
    end
    number_class=j;
    NumberofOutputNeurons=number_class;
    
    %%%%%%%%%% Processing the targets of training
    temp_T=zeros(NumberofOutputNeurons, NumberofTrainingData);
    for i = 1:NumberofTrainingData
        for j = 1:number_class
            if label(1,j) == T(1,i)
                break; 
            end
        end
        temp_T(j,i)=1;
    end
    T=temp_T*2-1;
end                                              %   end if of Elm_Type

%%%%%%%%%%% Calculate weights & biases
start_time_train=cputime;

%%%%%%%%%%% Generate input weights InputWeight (w_i) and biases BiasofHiddenNeurons (b_i) of hidden neurons
if strcmp(IniWeights,'Random')
  %%% Random initialization (uniform distribution in [-1,+1])
  InputWeight = rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;
elseif strcmp(IniWeights,'InputRandom')
  %%% Input initialization with inputs selected randomly
  NExamples = size(P,2);
  if NumberofHiddenNeurons > NExamples           % all examples are needed
    NInputs = size(P,1);
    X = [P, randn(NInputs,NumberofHiddenNeurons-NExamples)]'; %'
  elseif NumberofHiddenNeurons == NExamples      % all examples are needed
    X = P;
  else
    if strcmp(IniWeights,'InputRandom')
      stdX = 0;
      nIter = 0;
      while stdX < 1E-10  &&  nIter < MaxIterInput   %%% random data may give similar inputs values
        Index = randperm(NExamples);
        X = P(:,Index(1:NumberofHiddenNeurons))'; %'
        stdX = abs(prod(std(X)));
        nIter = nIter + 1;
      end;
    else
      strError = sprintf('IniWeights not implemented: %s',IniWeights);
      error(strError);
    end;
  end;
  %%% Normalization to mean 0 and stddev 1
  while (abs(prod(std(X))) < 1E-10) %%% adds Gaussian noise with small variance
    X = X + 0.01 * randn(size(X));
  end;
  X = X - ones(NumberofHiddenNeurons,1) * mean(X);
  X = X ./ (ones(NumberofHiddenNeurons,1) * std(X));
  InputWeight = X;
  clear X;
else
  strError = sprintf('invalid value of IniWeights: %s',IniWeights);
  error(strError);
end;

%%%%%%%%%%% Training
if ELM_is_rbf(ActivationFunction)

  %%% Scale the weights to the same mean and variance than data
  %%% (first convert InputWeight to mean 0 and std deviation 1)
  InputWeight = InputWeight - ones(NumberofHiddenNeurons,1) * mean(InputWeight);
  InputWeight = InputWeight ./ (ones(NumberofHiddenNeurons,1) * std(InputWeight));
  meanP = repmat(mean(P'),NumberofHiddenNeurons,1); %'
  stdP = repmat(std(P'),NumberofHiddenNeurons,1); %'
  InputWeight = meanP + InputWeight .* stdP;

  %%% ||x-y||^2 = ||x||^2 + ||y||^2 - 2<x,y>
  normInputWeight = repmat(sum(InputWeight.^2,2),1,NumberofTrainingData);
  normP = repmat(sum(P.^2,1),NumberofHiddenNeurons,1);
  tempH = normInputWeight + normP - 2 * InputWeight * P;

  H = exp(-Temperature * tempH);

else

  if WithBias
    BiasofHiddenNeurons = randn(NumberofHiddenNeurons,1);
  else
    BiasofHiddenNeurons = zeros(NumberofHiddenNeurons,1);
  end;

  ind=ones(1,NumberofTrainingData);
  BiasMatrix=BiasofHiddenNeurons(:,ind);           %   Extend the bias matrix BiasofHiddenNeurons to match the dimension of H
  tempH = Temperature * (InputWeight * P + BiasMatrix);

  %%%%%%%%%%% Calculate hidden neuron output matrix H
  switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H = 1 ./ (1 + exp(-tempH));
    case {'sin','sine'}
        %%%%%%%% Sine
        H = sin(tempH);    
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H = hardlim(tempH);            
        %%%%%%%% More activation functions can be added here                
  end

end;
clear P;               %   Release input of training data
clear tempH;

%%%%%%%%%%% Calculate output weights OutputWeight (beta_i)
OutputWeight=pinv(H') * T';
end_time_train=cputime;
TrainingTime=end_time_train-start_time_train;    %   Calculate CPU time (seconds) spent for training ELM

%%%%%%%%%%% Calculate the training accuracy
Y=(H' * OutputWeight)';                          %   Y: the actual output of the training data
if Elm_Type == REGRESSION
    TrainingAccuracy=sqrt(mse(T - Y));           %   Calculate training accuracy (RMSE) for regression case
    output=Y;    
end
clear H;

if Elm_Type == CLASSIFIER
%%%%%%%%%% Calculate training & testing classification accuracy
    MissClassificationRate_Training=0;

    for i = 1 : size(T, 2)
        [x, label_index_expected]=max(T(:,i));
        [x, label_index_actual]=max(Y(:,i));
        output(i)=label(label_index_actual);
        if label_index_actual~=label_index_expected
            MissClassificationRate_Training=MissClassificationRate_Training+1;
        end
    end
    TrainingAccuracy=1-MissClassificationRate_Training/NumberofTrainingData;
end

%%% ERM modified: instead of saving to disk, the values are returnes
%if Elm_Type~=REGRESSION
%    save('elm_model', 'NumberofInputNeurons', 'NumberofOutputNeurons', 'InputWeight', 'BiasofHiddenNeurons', 'OutputWeight', 'ActivationFunction', 'label', 'Elm_Type');
%else
%    save('elm_model', 'InputWeight', 'BiasofHiddenNeurons', 'OutputWeight', 'ActivationFunction', 'Elm_Type');    
%end
ELM_model.Elm_Type = Elm_Type;
ELM_model.ActivationFunction = ActivationFunction;
ELM_model.Temperature = Temperature;
ELM_model.InputWeight = InputWeight;
if ~ELM_is_rbf(ActivationFunction)
  ELM_model.BiasofHiddenNeurons = BiasofHiddenNeurons;
end;
ELM_model.OutputWeight = OutputWeight;
if Elm_Type~=REGRESSION
  ELM_model.NumberofOutputNeurons = NumberofOutputNeurons;
  ELM_model.label = label;
end;

return;
