
function Output = LIBSVM_SupportVectorEpsilonRegression (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('LIBSVM_SupportVectorRegression: string "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

if strcmp(traintest,'train')   %%% Construct the model
  ParamLIBSVM = '-s 3';
  if isfield(Param,'ParamKernel')
    ParamLIBSVM = sprintf('%s %s',ParamLIBSVM,Param.ParamKernel);
  end;
  if isfield(Param,'ParamEpsilonSVR')
    ParamLIBSVM = sprintf('%s %s',ParamLIBSVM,Param.ParamEpsilonSVR);
  end;
  Output = svmtrain(DataSet.Labels,DataSet.Inputs,ParamLIBSVM);
else                           %%% Test the model
  [PredictLabels Accuracies DecValues] = svmpredict(DataSet.Labels,DataSet.Inputs,Model);
  Output = Accuracies(2);
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_LIBSVM (PredictLabels,DecValues,Param);
  end;
end;

return;
