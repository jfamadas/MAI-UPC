
function Accuracy = MLE_TestModelClassification...
                      (ModelName,Model,Param,DataName,DataSet);

%%%-----------------------------------------------------------------
%%% DataName for Param (it should come in "Param", but it does not)
%%%-----------------------------------------------------------------

Param.DataName = DataName;

%%%-------------------
%%% Test of the model
%%%-------------------

if     strcmp(ModelName,'RBM_AutoencoderClassification')

  Accuracy = RBM_AutoencoderClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'NNToolbox_BackPropagationNNClassification')

  Accuracy = NNToolbox_BackPropagationNNClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'NNToolbox_LevenbergMarquardtNNClassification')

  Accuracy = NNToolbox_LevenbergMarquardtNNClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'ELM_NNClassification')

  Accuracy = ELM_NNClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_kNNClassification')

  Accuracy = PRTools_kNNClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_LogisticClassification')

  Accuracy = PRTools_LogisticClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_LeastSquaresClassification')

  Accuracy = PRTools_LeastSquaresClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_ParzenClassification')

  Accuracy = PRTools_ParzenClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_NaiveBayesClassification')

  Accuracy = PRTools_NaiveBayesClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_SupportVectorClassification')

  Accuracy = PRTools_SupportVectorClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'LIBSVM_SupportVectorCostClassification')

  Accuracy = LIBSVM_SupportVectorCostClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'LIBSVM_SupportVectorNuClassification')

  Accuracy = LIBSVM_SupportVectorNuClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'LSSVMlab_Classification')

  Accuracy = LSSVMlab_Classification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'AdaptedPRTools_LDAClassification')

  Accuracy = AdaptedPRTools_LDAClassification ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'AdaptedPRTools_KernelGDAClassification')

  Accuracy = AdaptedPRTools_KernelGDAClassification ('test',DataSet,Model,Param);

else

  error (strcat('MLE_TestModelClassification - Model not implemented yet: ',ModelName));

end;

return;
