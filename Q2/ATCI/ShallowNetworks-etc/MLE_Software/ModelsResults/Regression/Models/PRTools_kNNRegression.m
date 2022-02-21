
function Output = PRTools_kNNRegression (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('PRTools_kNNRegression: String "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

%%% Create PRTools data structures
DataSet_PRTools = MLE_CreateDataStructures_PRToolsRegression (DataSet);

if strcmp(traintest,'train')   %%% Construct the model
  if isfield(Param,'kNN') kNN = Param.kNN; else kNN = 2; end;
  prwarning(2);
  Output = knnr(DataSet_PRTools,kNN);
  prwarning off;
else                           %%% Test the model
  MSError = testr(DataSet_PRTools*Model);
  Output = MSError;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_PRTools (DataSet_PRTools,Model,Param);
  end;
end;

return;
