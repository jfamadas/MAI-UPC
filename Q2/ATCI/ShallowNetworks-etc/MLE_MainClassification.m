clear all; clc;

%%% Elapsed time
tic;

%----------------------------------
%%% Defaulta parameters

%%% Set your PATH here!
MatlabMLExperimentsHome = './';
addpath(genpath(MatlabMLExperimentsHome));  %%% recursive addpath

[ParamGeneral ParamData ...
 ParamPreprocess ParamSamplingDevelopment ...
 ParamConstructModel ParamResults] = MLE_DefaultParameters;

%----------------------------------
%%% Classification Problem

ParamGeneral.ClassificationProblem = 1;

%----------------------------------
%%% Original Data

ParamData.DataDirectory = 'Data';
% ParamData.DevelopmentInputsFile = 'vehicle.data';
% ParamData.DevelopmentLabelsFile = 'vehicle.labels';
% ParamData.DevelopmentInputsFile = 'breast-cancer-wisconsinOk.data';
% ParamData.DevelopmentLabelsFile = 'breast-cancer-wisconsinOk.labels';

ParamData.DevelopmentInputsFile = 'breast-cancer-wisconsinOk.data';
ParamData.DevelopmentLabelsFile = 'breast-cancer-wisconsinOk.labels';


ParamData.ValidInputsFile = '';
ParamData.ValidLabelsFile = '';
ParamData.TestInputsFile = '';
ParamData.TestLabelsFile = '';

%%%ParamData.Features = [3:5,10];

%----------------------------------
%%% Preprocessing Data

%ParamPreprocess.TypeTransform = 'NoTransform';
ParamPreprocess.TypeTransform = 'Mean0DevStd1';
%ParamPreprocess.TypeTransform = 'Hypercube01';
%ParamPreprocess.TypeTransform = 'Scaling';
%ParamPreprocess.ParamTransform = 1/255;

%----------------------------------
%%% Sampling

ParamSamplingDevelopment.NTimes = 1;
ParamSamplingDevelopment.Randomize = 1;
ParamSamplingDevelopment.RandomSeed = 0;  %%% values <=0: clock    %you could put 1 and the seed will be different each run
ParamSamplingDevelopment.Stratified = 1;
% ParamSamplingDevelopment.Type = 'HoldOutTVT';
% ParamSamplingDevelopment.HoldOutTVT.PctValid = 0.20;  %%% 0 <= Pct < 1
% ParamSamplingDevelopment.HoldOutTVT.PctTest = 0.20;   %%% 0 <= Pct < 1
ParamSamplingDevelopment.Type = 'CrossValidation';
ParamSamplingDevelopment.CrossValidation.NFolds = 5;  %% the total number of runs is the multiplication of NFolds and NFoldsDouble
ParamSamplingDevelopment.CrossValidation.NFoldsDouble = 4; %for each partition you also move the validation subset between the training subset
%ParamSamplingDevelopment.Type = 'Bootstrapping';
%ParamSamplingDevelopment.Bootstrapping.NBSamplings = 10;

%----------------------------------
%%% Classification models and parameters

%---
ParamConstructModel.ModelName = 'ELM_NNClassification';
ParamConstructModel.ParamModel.NUnits = 512;
% ParamConstructModel.ParamModel.ActFunH = 'gau';
% ParamConstructModel.ParamModel.Temperature = 1e+12;
% ParamConstructModel.ParamModel.ActFunH = 'sig';
% ParamConstructModel.ParamModel.Temperature = 1;
% ParamConstructModel.ParamModel.ActFunH = 'sin';
% ParamConstructModel.ParamModel.ActFunH = 'hardlim';
% ParamConstructModel.ParamModel.WithBias = 1;  %%% only if sig/sin/hardlim
% ParamConstructModel.ParamModel.WithBias = 0;  %%% only if sig/sin/hardlim
% ParamConstructModel.ParamModel.IniWeights = 'Random';
% ParamConstructModel.ParamModel.IniWeights = 'InputRandom';
% ParamConstructModel.ParamModel.MaxIterInput = 50;
%---
% ParamConstructModel.ModelName = 'NNToolbox_BackPropagationNNClassification';
% ParamConstructModel.ParamModel.NUnits = [20 10];    %%% For several layers: [20 10]
% ParamConstructModel.ParamModel.NIters = 100;
% % %%% Toolbox default transfer functions:
% % %%%   compet / hardlim / hardlims / logsig / netinv / poslin / purelin
% % %%%   radbas / satlin / satlins / softmax / tansig / tribas / elliotsig
% ParamConstructModel.ParamModel.ActFunH = 'tansig';
% ParamConstructModel.ParamModel.LearningRate = 0.01;
% ParamConstructModel.ParamModel.Momentum = 0.9;
% ParamConstructModel.ParamModel.Goal = 0.0001;
% ParamConstructModel.ParamModel.Show = 50;
%---
% ParamConstructModel.ModelName = 'NNToolbox_LevenbergMarquardtNNClassification'; 
% ParamConstructModel.ParamModel.NUnits = [20 10];    %%% For several layers: [20 10]
% ParamConstructModel.ParamModel.NIters = 100;
% % %% Toolbox default transfer functions:
% % %%   compet / hardlim / hardlims / logsig / netinv / poslin / purelin
% % %%   radbas / satlin / satlins / softmax / tansig / tribas / elliotsig
% ParamConstructModel.ParamModel.ActFunH = 'tansig';
% ParamConstructModel.ParamModel.Mu = 1.0000e-03;
% ParamConstructModel.ParamModel.MuDec = 0.1;
% ParamConstructModel.ParamModel.MuInc = 10;
% ParamConstructModel.ParamModel.Goal = 0.0001;
% ParamConstructModel.ParamModel.Show = 50;
% ParamConstructModel.ParamModel.MemReduc = 1;
%---
% ParamConstructModel.ModelName = 'LIBSVM_SupportVectorCostClassification';
% %% Type 'svmtrain' to see the available options
% ParamConstructModel.ParamModel.ParamKernel = '-t 2 -g 0.07 -r 0'; %'
% ParamConstructModel.ParamModel.ParamCSVC = '-c 1';
%---
% ParamConstructModel.ModelName = 'LIBSVM_SupportVectorNuClassification';
% %% Type 'svmtrain' to see the available options
% ParamConstructModel.ParamModel.ParamKernel = '-t 2 -g 0.07 -r 0'; %'
% ParamConstructModel.ParamModel.ParamNuSVC = '-n 0.3';
%---
% ParamConstructModel.ModelName = 'PRTools_kNNClassification';
% ParamConstructModel.ParamModel.kNN = 7;
%---
% ParamConstructModel.ModelName = 'PRTools_LogisticClassification';
% ---
% ParamConstructModel.ModelName = 'PRTools_LeastSquaresClassification';
%---
% ParamConstructModel.ModelName = 'PRTools_ParzenClassification';
%---
% ParamConstructModel.ModelName = 'PRTools_NaiveBayesClassification';
% ParamConstructModel.ParamModel.NBins = 20;
%---
% ParamConstructModel.ModelName = 'PRTools_SupportVectorClassification';
% ParamConstructModel.ParamModel.TKernel = 'radial_basis'; %%% 'gaussian'
% % ParamConstructModel.ParamModel.TKernel = 'polynomial';
% % ParamConstructModel.ParamModel.TKernel = 'cosine';
% ParamConstructModel.ParamModel.KParam = 1e2;
% ParamConstructModel.ParamModel.CParam = 1e5;
%---

%----------------------------------


ParamResults.ParamSaveModels.SaveModels = 1;
ParamResults.ParamSaveModels.DirSavedModels = 'SavedModels';
%ParamResults.ParamSaveModels.PrefixSavedModels = 'model';
ParamResults.ParamSaveModels.PrefixSavedModels = ['model-' ParamConstructModel.ModelName];

ParamResults.ParamSaveFinalResults.SaveFinalResults = 1;
ParamResults.ParamSaveFinalResults.DirSavedFinalResults = 'SavedFinalResults';
ParamResults.ParamSaveFinalResults.PrefixSavedFinalResults = ParamData.DevelopmentInputsFile;

%----------------------------------

% DO NOT MODIFY FROM HERE!

%----------------------------------

Data = MLE_LoadData (ParamGeneral,ParamData);

Data = MLE_PreprocessData (ParamGeneral,ParamPreprocess,Data);

SamplingDevelopment = ...
  MLE_SamplingDevelopmentData (ParamGeneral,ParamSamplingDevelopment,Data);

Results = MLE_ConstructModelObtainResults...
            (ParamGeneral,ParamConstructModel,ParamResults,...
             Data,SamplingDevelopment);

%----------------------------------

Results

%----------------------------------

%%% Elapsed time
toc;