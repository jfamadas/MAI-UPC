
function Output = PRTools_kNNClassification (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('PRTools_kNNClassification: String "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

%%% Create PRTools data structures
DataSet_PRTools = MLE_CreateDataStructures_PRToolsClassification (DataSet);

if strcmp(traintest,'train')   %%% Construct the model
  if isfield(Param,'kNN') kNN = Param.kNN; else kNN = []; end;
  prwarning(2);
  Output = knnc(DataSet_PRTools,kNN);
  prwarning off;
else                           %%% Test the model
  [perror, nerrors] = testc(DataSet_PRTools,Model);
  Output = 1 - perror;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_PRTools (DataSet_PRTools,Model,Param);
  end;
end;

return;
