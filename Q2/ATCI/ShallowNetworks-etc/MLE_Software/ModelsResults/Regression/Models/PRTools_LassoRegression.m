
function Output = PRTools_LassoRegression (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('PRTools_LassoRegression: String "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

%%% Create PRTools data structures
DataSet_PRTools = MLE_CreateDataStructures_PRToolsRegression (DataSet);

if strcmp(traintest,'train')   %%% Construct the model
  if isfield(Param,'Lambda') Lambda = Param.Lambda; else Lambda = 1; end;
  prwarning(2);
  Output = lassor(DataSet_PRTools,Lambda);
  prwarning off;
else                           %%% Test the model
  MSError = testr(DataSet_PRTools*Model);
  Output = MSError;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_PRTools (DataSet_PRTools,Model,Param);
  end;
end;

return;
