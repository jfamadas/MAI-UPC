
function Model = MLE_TrainModelRegression (ModelName,Param,DevelopmentData);

%%%=======================================================================

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

MLE_ValidateMandatoryParameters (Param);

%%%=======================================================================

%%%--------------------
%%% Training the model
%%%--------------------

fprintf(' Training...\n');

if     strcmp(ModelName,'RBM_AutoencoderRegression')

  Model = RBM_AutoencoderRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'NNToolbox_BackPropagationNNRegression')

  TuningSet = [];
  if isfield(DevelopmentData,'Valid') TuningSet = DevelopmentData.Valid; end;
  Model = NNToolbox_BackPropagationNNRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel,TuningSet);

elseif strcmp(ModelName,'NNToolbox_LevenbergMarquardtNNRegression')

  TuningSet = [];
  if isfield(DevelopmentData,'Valid') TuningSet = DevelopmentData.Valid; end;
  Model = NNToolbox_LevenbergMarquardtNNRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel,TuningSet);

elseif strcmp(ModelName,'ELM_NNRegression')

  Model = ELM_NNRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_kNNRegression')

  Model = PRTools_kNNRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_PolynomialRegression')

  Model = PRTools_PolynomialRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_PartialLSRegression')

  Model = PRTools_PartialLSRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_RidgeRegression')

  Model = PRTools_RidgeRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_LassoRegression')

  Model = PRTools_LassoRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_KernelSmootherRegression')

  Model = PRTools_KernelSmootherRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_SupportVectorRegression')

  Model = PRTools_SupportVectorRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'LIBSVM_SupportVectorEpsilonRegression')

  Model = LIBSVM_SupportVectorEpsilonRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'LIBSVM_SupportVectorNuRegression')

  Model = LIBSVM_SupportVectorNuRegression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'LSSVMlab_Regression')

  Model = LSSVMlab_Regression...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

else

  error (strcat('MLE_TrainModelRegression - Model not implemented yet: ',ModelName));

end;

%%%------

fprintf(' done\n');

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParameters (Param);

if ~isfield(Param,'ParamModel')
  error('MLE_TrainModelRegression: No parameters for the model');
end;

return;

%%%-------------------------------------------------
