
function Output = ELM_NNClassification (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('ELM_Classification: string "traintest" invalid');
end;

%%%------------------
%%% Global variables
%%%------------------

%%% Input data for ELM
ELM_Data_File = [DataSet.Labels DataSet.Inputs];

%%%----------------------
%%% Train/Test the model
%%%----------------------

if strcmp(traintest,'train')   %%% Construct the model

  Elm_Type = 1; %%% 1 for classification / 0 for regression
  if ~isfield(Param,'NUnits') error('ELM_Classification: NUnits required'); end;
  NUnits = Param.NUnits;
  if ~isfield(Param,'ActFunH')            Param.ActFunH = 'sig'; end;
  if ~isfield(Param,'Temperature')        Param.Temperature = 1.0; end;
  if ~isfield(Param,'WithBias')           Param.WithBias = 1; end;
  if ~isfield(Param,'IniWeights')         Param.IniWeights = 'Random'; end;
  if ~isfield(Param,'MaxIterInput')       Param.MaxIterInput = 50; end;
  if ~isfield(Param,'LeaderDistance')     Param.LeaderDistance = 'NrmEuclidean'; end;
  if ~isfield(Param,'MaxIterInputLeader') Param.MaxIterInputLeader = 50; end;

  %%% Model Training
  [TrainingTime, TrainingAccuracy, ModelELM] = ELM_train(ELM_Data_File, Elm_Type, NUnits, Param);

  Output.TrainingTime = TrainingTime;
  Output.TrainingAccuracy = TrainingAccuracy;
  Output.ModelELM = ModelELM;

else %%% Test the model

  [TestingTime, TestingAccuracy, OutputValues] = ELM_predict(ELM_Data_File, Model.ModelELM);
  Output = TestingAccuracy;  
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_ELM (OutputValues,Param);
  end;

end;

return;
