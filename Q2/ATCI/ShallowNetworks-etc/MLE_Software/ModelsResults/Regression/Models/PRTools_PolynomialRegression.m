
function Output = PRTools_PolynomialRegression (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('PRTools_PolynomialRegression: String "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

%%% Create PRTools data structures
DataSet_PRTools = MLE_CreateDataStructures_PRToolsRegression (DataSet);

if strcmp(traintest,'train')   %%% Construct the model
  if isfield(Param,'Lambda') Lambda = Param.Lambda; else Lambda = []; end;
  if isfield(Param,'OPoly')  OPoly  = Param.OPoly;  else OPoly = 1; end;
  prwarning(2);
  Output = linearr(DataSet_PRTools,Lambda,OPoly);
  prwarning off;
else                           %%% Test the model
  MSError = testr(DataSet_PRTools*Model);
  Output = MSError;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_PRTools (DataSet_PRTools,Model,Param);
  end;
end;

return;
