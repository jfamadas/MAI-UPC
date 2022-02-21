
function MSError = MLE_TestModelRegression...
                     (ModelName,Model,Param,DataName,DataSet);

%%%-----------------------------------------------------------------
%%% DataName for Param (it should come in "Param", but it does not)
%%%-----------------------------------------------------------------

Param.DataName = DataName;

%%%-------------------
%%% Test of the model
%%%-------------------

if     strcmp(ModelName,'RBM_AutoencoderRegression')

  MSError = RBM_AutoencoderRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'NNToolbox_BackPropagationNNRegression')

  MSError = NNToolbox_BackPropagationNNRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'NNToolbox_LevenbergMarquardtNNRegression')

  MSError = NNToolbox_LevenbergMarquardtNNRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'ELM_NNRegression')

  MSError = ELM_NNRegression ('test',DataSet,Model,Param);
  
elseif strcmp(ModelName,'PRTools_kNNRegression')

  MSError = PRTools_kNNRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_PartialLSRegression')

  MSError = PRTools_PartialLSRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_PolynomialRegression')

  MSError = PRTools_PolynomialRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_RidgeRegression')

  MSError = PRTools_RidgeRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_LassoRegression')

  MSError = PRTools_LassoRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_KernelSmootherRegression')

  MSError = PRTools_KernelSmootherRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'PRTools_SupportVectorRegression')

  MSError = PRTools_SupportVectorRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'LIBSVM_SupportVectorEpsilonRegression')

  MSError = LIBSVM_SupportVectorEpsilonRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'LIBSVM_SupportVectorNuRegression')

  MSError = LIBSVM_SupportVectorNuRegression ('test',DataSet,Model,Param);

elseif strcmp(ModelName,'LSSVMlab_Regression')

  MSError = LSSVMlab_Regression ('test',DataSet,Model,Param);

else

  error (strcat('MLE_TestModelRegression - Model not implemented yet: ',ModelName));

end;

return;
