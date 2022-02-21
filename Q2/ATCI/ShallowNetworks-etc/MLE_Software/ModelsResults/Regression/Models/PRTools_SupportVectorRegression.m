
function Output = PRTools_SupportVectorRegression (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('PRTools_SupportVectorRegression: String "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

%%% Create PRTools data structures
DataSet_PRTools = MLE_CreateDataStructures_PRToolsRegression (DataSet);

if strcmp(traintest,'train')   %%% Construct the model
  if isfield(Param,'TKernel') TKernel = Param.TKernel; else TKernel = 'radial_basis'; end;
  if isfield(Param,'KParam')  KParam = Param.KParam;   else KParam = 1; end;
  if isfield(Param,'NuParam') NuParam = Param.NuParam; else NuParam = 0.1; end;
  if isfield(Param,'Epsilon') Epsilon = Param.Epsilon; else Epsilon = 0.2; end;
  prwarning(2);
  Output = svmr(DataSet_PRTools,NuParam,TKernel,KParam,Epsilon);
  prwarning off;
else                           %%% Test the model
  MSError = testr(DataSet_PRTools*Model);
  Output = MSError;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_PRTools (DataSet_PRTools,Model,Param);
  end;
end;

return;
