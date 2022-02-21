
function Output = PRTools_ParzenClassification (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('PRTools_ParzenClassification: String "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

%%% Create PRTools data structures
DataSet_PRTools = MLE_CreateDataStructures_PRToolsClassification (DataSet);

if strcmp(traintest,'train')   %%% Construct the model
  prwarning(2);
  Output = parzenc(DataSet_PRTools);
  prwarning off;
else                           %%% Test the model
  [perror, nerrors] = testc(DataSet_PRTools,Model);
  Output = 1 - perror;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_PRTools (DataSet_PRTools,Model,Param);
  end;
end;

return;
