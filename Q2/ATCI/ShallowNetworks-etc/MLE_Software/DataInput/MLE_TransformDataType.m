
function Data = MLE_TransformDataType (Param,Data);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

MLE_ValidateMandatoryParameters (Param);

%%%------------------
%%% Global variables
%%%------------------

TypeTransform = Param.TypeTransform;
ParamTransform = 0;
if isfield(Param,'ParamTransform')
  ParamTransform = Param.ParamTransform;
end;

fprintf(' Transforming data (%s)...',TypeTransform);

%%%-------------
%%% NoTransform
%%%-------------

if strcmp(TypeTransform,'NoTransform') || ...
   strcmp(TypeTransform,'NoPreprocess')
  fprintf(' done\n');
  return;

%%%-----------------------------------------------
%%% Mean0DevStd1: Mean 0 and Standard Deviation 1
%%%-----------------------------------------------

elseif strcmp(TypeTransform,'Mean0DevStd1')

  Data.InputsDevelopment = MLE_PreprocessMean0DevStd1 (Data.InputsDevelopment);
  if isfield(Data,'NExamplesValid')
    Data.InputsValid = MLE_PreprocessMean0DevStd1 (Data.InputsValid);
  end;
  if isfield(Data,'NExamplesTest')
    Data.InputsTest = MLE_PreprocessMean0DevStd1 (Data.InputsTest);
  end;

%%%--------------------------------------------------
%%% Hypercube01: minimum value 0 and maximum value 1
%%%--------------------------------------------------

elseif strcmp(TypeTransform,'Hypercube01')

  Data.InputsDevelopment = MLE_PreprocessHypercube01 (Data.InputsDevelopment);
  if isfield(Data,'NExamplesValid')
    Data.InputsValid = MLE_PreprocessHypercube01 (Data.InputsValid);
  end;
  if isfield(Data,'NExamplesTest')
    Data.InputsTest = MLE_PreprocessHypercube01 (Data.InputsTest);
  end;

%%%---------
%%% Scaling
%%%---------

elseif strcmp(TypeTransform,'Scaling')

  Data.InputsDevelopment = MLE_PreprocessScaling (Data.InputsDevelopment,ParamTransform);
  if isfield(Data,'NExamplesValid')
    Data.InputsValid = MLE_PreprocessScaling (Data.InputsValid,ParamTransform);
  end;
  if isfield(Data,'NExamplesTest')
    Data.InputsTest = MLE_PreprocessScaling (Data.InputsTest,ParamTransform);
  end;

else

  error('MLE_TransformData: TypeTransform not implemented yet');

end;

%%%------

fprintf(' done\n');

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParameters (Param);

if ~isfield(Param,'TypeTransform')
  error('MLE_TransformDataType: TypeTransform');
end;

if ~isfield(Param,'ParamTransform')
  if strcmp(Param.TypeTransform,'Scaling')
    error('MLE_TransformDataType: No parameter for Scaling');
  end;
end;

return;

%%%-------------------------------------------------

function Inputs = MLE_PreprocessMean0DevStd1 (Inputs);

  NExamples = size(Inputs,1);
  Inputs = Inputs - ones(NExamples,1) * mean(Inputs);
  stdInputs = std(Inputs);
  if prod(stdInputs) == 0
    error('MLE_PreprocessMean0DevStd1: stdInputs = 0 ');
  end;

  Inputs = Inputs ./ (ones(NExamples,1) * stdInputs);

return;

%%%-------------------------------------------------

function Inputs = MLE_PreprocessHypercube01 (Inputs);

  NExamples = size(Inputs,1);
  MinInputs = min(Inputs);
  MaxInputs = max(Inputs);
  Inputs = (Inputs - ones(NExamples,1) * MinInputs) ./ ...
                    (ones(NExamples,1) * (MaxInputs - MinInputs));

return;

%%%-------------------------------------------------

function Inputs = MLE_PreprocessScaling (Inputs,ScalingFactor);

  Inputs = Inputs * ScalingFactor;

return;

%%%-------------------------------------------------
