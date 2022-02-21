
function Results = MLE_ConstructModelObtainResults...
                    (ParamGeneral,ParamConstruct,ParamResults,Data,Sampling);

%%%=======================================================================

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

MLE_ValidateMandatoryParameters (ParamConstruct);

%%%=======================================================================

ModelName = ParamConstruct.ModelName;

fprintf('Obtaining results from model %s...\n',ModelName);

%%%---------------------
%%% Fields of ParamTest
%%%---------------------

ParamTest.Dummy = 0;
ParamTest.ParamConstruct = ParamConstruct;
if isfield(ParamResults,'ParamTestModel')
  ParamTest.ParamResults = ParamResults.ParamTestModel;
end;

%%%---------------------------------------------------------------
%%% Validation and Test data (common for all training procedures)
%%%---------------------------------------------------------------

%%% Validation and Test data
if isfield(Data,'NExamplesValid')
  ValidData.Inputs = Data.InputsValid;
  ValidData.Labels = Data.LabelsValid;
end;
if isfield(Data,'NExamplesTest')
  TestData.Inputs = Data.InputsTest;
  TestData.Labels = Data.LabelsTest;
end;

%%%----------------------------------------------------------------------------------
%%% Construct the model with the development data and test it on different data sets
%%%----------------------------------------------------------------------------------

%%% For every sampling...
for n=1:Sampling.NSamplings

  %%% Obtain the development data from the indexes of Sampling
  if ~isfield(Sampling,'Train')
    error('MLE_ConstructModelObtainResults: No Train field in sampling development variable');
  end;
  if isempty(Sampling.Train{n})
    error('MLE_ConstructModelObtainResults: Empty sampling development training variable');
  end;
  DevelopmentData.Train.Inputs = Data.InputsDevelopment(Sampling.Train{n},:);
  if ~isempty(Data.LabelsDevelopment)
    DevelopmentData.Train.Labels = Data.LabelsDevelopment(Sampling.Train{n},:);
  else
    DevelopmentData.Train.Labels = [];
  end;
  if isfield(Sampling,'Valid')
    DevelopmentData.Valid.Inputs = Data.InputsDevelopment(Sampling.Valid{n},:);
    DevelopmentData.Valid.Labels = Data.LabelsDevelopment(Sampling.Valid{n},:);
  end;
  if isfield(Sampling,'Test')
    DevelopmentData.Test.Inputs = Data.InputsDevelopment(Sampling.Test{n},:);
    DevelopmentData.Test.Labels = Data.LabelsDevelopment(Sampling.Test{n},:);
  end;

  %%% Real development data
  DevelopmentDataReal.Train = DevelopmentData.Train;
  if isfield(Sampling,'Valid')
    DevelopmentDataReal.Valid = DevelopmentData.Valid;
  end;

  %%% If classification problem...
  if ParamGeneral.ClassificationProblem && ~strcmp(ModelName,'Dummy')

    Accuracy = zeros(1,6);

    %%% Train and obtain the model

    Model = MLE_TrainModelClassification (ModelName,ParamConstruct,DevelopmentDataReal);

    %%% Test the model on the data sets

    Accuracy(1) = MLE_TestModelClassification...
                      (ModelName,Model,ParamTest,'DevelopRealTrain',DevelopmentDataReal.Train);

    Accuracy(2)   = MLE_TestModelClassification...
                      (ModelName,Model,ParamTest,'DevelopTrain',DevelopmentData.Train);

    if isfield(Sampling,'Valid')
      Accuracy(3) = MLE_TestModelClassification...
                      (ModelName,Model,ParamTest,'DevelopValid',DevelopmentData.Valid);
    end;
    if isfield(Sampling,'Test')
      Accuracy(4) = MLE_TestModelClassification...
                      (ModelName,Model,ParamTest,'DevelopTest',DevelopmentData.Test);
    end;
    if isfield(Data,'NExamplesValid')
      Accuracy(5) = MLE_TestModelClassification...
                      (ModelName,Model,ParamTest,'Valid',ValidData);
    end;
    if isfield(Data,'NExamplesTest')
      Accuracy(6) = MLE_TestModelClassification...
                      (ModelName,Model,ParamTest,'Test',TestData);
    end;
    SampleAccuracy(n,:) = Accuracy;

  end;

  %%% If regression problem...
  if ParamGeneral.RegressionProblem && ~strcmp(ModelName,'Dummy')

    MSError = zeros(1,6);

    %%% Train and obtain the model

    Model = MLE_TrainModelRegression (ModelName,ParamConstruct,DevelopmentDataReal);

    %%% Test the model on the data sets

    MSError(1) = MLE_TestModelRegression...
                   (ModelName,Model,ParamTest,'DevelopRealTrain',DevelopmentDataReal.Train);

    MSError(2)   = MLE_TestModelRegression...
                     (ModelName,Model,ParamTest,'DevelopTrain',DevelopmentData.Train);
    if isfield(Sampling,'Valid')
      MSError(3) = MLE_TestModelRegression...
                     (ModelName,Model,ParamTest,'DevelopValid',DevelopmentData.Valid);
    end;
    if isfield(Sampling,'Test')
      MSError(4) = MLE_TestModelRegression...
                     (ModelName,Model,ParamTest,'DevelopTest',DevelopmentData.Test);
    end;
    if isfield(Data,'NExamplesValid')
      MSError(5) = MLE_TestModelRegression...
                     (ModelName,Model,ParamTest,'Valid',ValidData);
    end;
    if isfield(Data,'NExamplesTest')
      MSError(6) = MLE_TestModelRegression...
                     (ModelName,Model,ParamTest,'Test',TestData);
    end;
    SampleMSError(n,:) = MSError;

  end;
  
  %%% Optionally, save models
  if isfield(ParamResults,'ParamSaveModels')
    MLE_SaveModels (Model,n,ParamResults.ParamSaveModels);
  end;
    
end;


%%%-----------------
%%% Collect Results
%%%-----------------

if strcmp(ModelName,'Dummy')
  Results = [];
end;

if ParamGeneral.ClassificationProblem && ~strcmp(ModelName,'Dummy')
  Results.Sample_Accuracy = SampleAccuracy;
  MeanAccuracy = mean(SampleAccuracy,1);
  %Results.MeanAccuracy_DevelopRealTrain = MeanAccuracy(1);
  Results.MeanAccuracy_DevelopTrain     = MeanAccuracy(2);
  Results.MeanAccuracy_DevelopValid     = MeanAccuracy(3);
  Results.MeanAccuracy_DevelopTest      = MeanAccuracy(4);
  Results.MeanAccuracy_Valid            = MeanAccuracy(5);
  Results.MeanAccuracy_Test             = MeanAccuracy(6);
end;

if ParamGeneral.RegressionProblem && ~strcmp(ModelName,'Dummy')
  Results.Sample_MSError = SampleMSError;
  MeanMSError = mean(SampleMSError,1);
  %Results.MeanMSError_DevelopRealTrain = MeanMSError(1);
  Results.MeanMSError_DevelopTrain     = MeanMSError(2);
  Results.MeanMSError_DevelopValid     = MeanMSError(3);
  Results.MeanMSError_DevelopTest      = MeanMSError(4);
  Results.MeanMSError_Valid            = MeanMSError(5);
  Results.MeanMSError_Test             = MeanMSError(6);
end;
  
%%% Optionally, save results
if ~isempty(Results) && isfield(ParamResults,'ParamSaveFinalResults')
  MLE_SaveFinalResults (Results,ParamResults.ParamSaveFinalResults);
end;

%%%------

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParameters (ParamConstruct);

if ~isfield(ParamConstruct,'ModelName')
  error('MLE_ConstructModelObtainResults: No model to construct');
end;

return;

%%%-------------------------------------------------
