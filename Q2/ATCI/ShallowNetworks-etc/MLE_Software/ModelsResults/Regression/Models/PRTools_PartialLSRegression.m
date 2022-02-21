
function Output = PRTools_PartialLSRegression (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('PRTools_PartialLSRegression: String "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

%%% Create PRTools data structures
DataSet_PRTools = MLE_CreateDataStructures_PRToolsRegression (DataSet);

if strcmp(traintest,'train')   %%% Construct the model
  if isfield(Param,'MaxLV') MaxLV = Param.MaxLV; else MaxLV = inf; end;
  prwarning(2);
  Output = plsr(DataSet_PRTools,MaxLV);
  prwarning off;
else                           %%% Test the model
  MSError = testr(DataSet_PRTools*Model);
  Output = MSError;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_PRTools (DataSet_PRTools,Model,Param);
  end;
end;

return;
