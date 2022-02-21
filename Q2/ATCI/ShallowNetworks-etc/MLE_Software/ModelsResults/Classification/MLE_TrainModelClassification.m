
function Model = MLE_TrainModelClassification (ModelName,Param,DevelopmentData);

%%%=======================================================================

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

MLE_ValidateMandatoryParameters (Param);

%%%=======================================================================

%%%--------------------
%%% Training the model
%%%--------------------

fprintf('Training...\n');

if     strcmp(ModelName,'RBM_AutoencoderClassification')

  Model = RBM_AutoencoderClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'NNToolbox_BackPropagationNNClassification')

  TuningSet = [];
  if isfield(DevelopmentData,'Valid') TuningSet = DevelopmentData.Valid; end;
  Model = NNToolbox_BackPropagationNNClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel,TuningSet);

elseif strcmp(ModelName,'NNToolbox_LevenbergMarquardtNNClassification')

  TuningSet = [];
  if isfield(DevelopmentData,'Valid') TuningSet = DevelopmentData.Valid; end;
  Model = NNToolbox_LevenbergMarquardtNNClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel,TuningSet);

elseif strcmp(ModelName,'ELM_NNClassification')

  Model = ELM_NNClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_kNNClassification')

  Model = PRTools_kNNClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_LogisticClassification')

  Model = PRTools_LogisticClassification...
            ('train',DevelopmentData.Train,[]);

elseif strcmp(ModelName,'PRTools_LeastSquaresClassification')

  Model = PRTools_LeastSquaresClassification...
            ('train',DevelopmentData.Train,[]);

elseif strcmp(ModelName,'PRTools_ParzenClassification')

  Model = PRTools_ParzenClassification...
            ('train',DevelopmentData.Train,[]);

elseif strcmp(ModelName,'PRTools_NaiveBayesClassification')

  Model = PRTools_NaiveBayesClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'PRTools_SupportVectorClassification')

  Model = PRTools_SupportVectorClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'LIBSVM_SupportVectorCostClassification')

  Model = LIBSVM_SupportVectorCostClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'LIBSVM_SupportVectorNuClassification')

  Model = LIBSVM_SupportVectorNuClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'LSSVMlab_Classification')

  Model = LSSVMlab_Classification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

elseif strcmp(ModelName,'AdaptedPRTools_LDAClassification')

  Model = AdaptedPRTools_LDAClassification...
            ('train',DevelopmentData.Train,[]);

elseif strcmp(ModelName,'AdaptedPRTools_KernelGDAClassification')

  Model = AdaptedPRTools_KernelGDAClassification...
            ('train',DevelopmentData.Train,[],Param.ParamModel);

else

  error (strcat('MLE_TrainModelClassification - Model not implemented yet: ',ModelName));

end;

%%%------

fprintf(' done\n');

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParameters (Param);

if ~isfield(Param,'ParamModel')
  error('MLE_TrainModelClassification: No parameters for the model');
end;

return;

%%%-------------------------------------------------
