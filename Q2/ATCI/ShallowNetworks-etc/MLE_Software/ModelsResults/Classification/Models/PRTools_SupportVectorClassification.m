
function Output = PRTools_SupportVectorClassification (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('PRTools_SupportVectorClassification: String "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

%%% Create PRTools data structures
DataSet_PRTools = MLE_CreateDataStructures_PRToolsClassification (DataSet);

if strcmp(traintest,'train')   %%% Construct the model
  if isfield(Param,'TKernel') TKernel = Param.TKernel; else TKernel = 'radial_basis'; end;
  if isfield(Param,'KParam')  KParam = Param.KParam;   else KParam = 1; end;
  if isfield(Param,'CParam')  CParam = Param.CParam;   else CParam = 1; end;
  if strcmp(TKernel,'gaussian') TKernel = 'radial_basis'; end;
  prwarning(2);
  Output = svc(DataSet_PRTools,TKernel,KParam,CParam);
  prwarning off;
else                           %%% Test the model
  [perror, nerrors] = testc(DataSet_PRTools,Model);
  Output = 1 - perror;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_PRTools (DataSet_PRTools,Model,Param);
  end;
end;

return;
