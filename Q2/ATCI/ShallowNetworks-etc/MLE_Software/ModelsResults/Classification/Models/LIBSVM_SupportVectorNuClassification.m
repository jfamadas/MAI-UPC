
function Output = LIBSVM_SupportVectorNuClassification (traintest,DataSet,Model,Param);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('LIBSVM_SupportVectorNuClassification: string "traintest" invalid');
end;

%%%----------------------
%%% Train/Test the model
%%%----------------------

if strcmp(traintest,'train')   %%% Construct the model

  ParamLIBSVM = '-s 1';		%'
  if isfield(Param,'ParamKernel')
    ParamLIBSVM = sprintf('%s %s',ParamLIBSVM,Param.ParamKernel);
  end;
  if isfield(Param,'ParamNuSVC')
    ParamLIBSVM = sprintf('%s %s',ParamLIBSVM,Param.ParamNuSVC);
  end;
  Output = svmtrain(DataSet.Labels,DataSet.Inputs,ParamLIBSVM);

else %%% Test the model

  [PredictLabels, Accuracies, DecValues] = svmpredict(DataSet.Labels,DataSet.Inputs,Model);
  Output = Accuracies(1);
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_LIBSVM (PredictLabels,DecValues,Param);
  end;

end;

return;
