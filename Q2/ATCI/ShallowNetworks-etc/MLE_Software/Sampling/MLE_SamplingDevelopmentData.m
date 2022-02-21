
function Sampling = MLE_SamplingDevelopmentData (ParamGeneral,Param,Data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Output:
%
%  Sampling.NSamplings --- integer
%  Sampling.Train      --- cell
%  Sampling.Valid      --- cell (optional)
%  Sampling.Test       --- cell (optional)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%=======================================================================

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

MLE_ValidateMandatoryParameters (Param);

%%%=======================================================================

%%%-----------------------------
%%% Default optional parameters
%%%-----------------------------

NTimes = 1;
if isfield(Param,'NTimes')
  NTimes = Param.NTimes;
end;

Common.Randomize = 1;
if isfield(Param,'Randomize')
  Common.Randomize = Param.Randomize;
end;

if Common.Randomize
  Common.RandomSeed = sum(100*clock);
  if isfield(Param,'RandomSeed') && Param.RandomSeed > 0
    Common.RandomSeed = Param.RandomSeed;
  end;
  MLE_SetRandomSeed (Common.RandomSeed);
end;

if ParamGeneral.RegressionProblem || ~isfield(Param,'Stratified')
  Common.Stratified = 0;
else
  Common.Stratified = Param.Stratified;
end;

if Common.Stratified && isempty(Data.LabelsDevelopment)
  error('MLE_SamplingDevelopmentData: Stratified sampling with empty labels');
end;

%%%=======================================================================

Sampling.NSamplings = 0;

%%%----------------------------
%%% Sampling: Loop over NTimes
%%%----------------------------

for time=1:Param.NTimes

  %%%-------------------------------------------------
  %%% Hold-out-TVT: Hold-out Training/Validation/Test
  %%%-------------------------------------------------

  if strcmp(Param.Type,'HoldOutTVT')
    %%% Default optional parameters
    PctTest = 0;
    PctValid = 0;
    if isfield(Param,'HoldOutTVT')
      if isfield(Param.HoldOutTVT,'PctTest')
        PctTest = Param.HoldOutTVT.PctTest;
      end;
      if isfield(Param.HoldOutTVT,'PctValid')
        PctValid = Param.HoldOutTVT.PctValid;
      end;
    end;
    Labels = Data.LabelsDevelopment;
    NExamples = size(Data.InputsDevelopment,1);
    SamplingAux = MLE_HoldOut_TVT...
                    (Common,Labels,NExamples,PctValid,PctTest);
  end;

  %%%------------------------------------------------------------
  %%% Cross-Validation (simple/double --- optionally stratified)
  %%%------------------------------------------------------------

  if strcmp(Param.Type,'CrossValidation')
    NFolds = 10;
    NFoldsDouble = 0;
    %%% Default optional parameters  
    if isfield(Param,'CrossValidation')
      if isfield(Param.CrossValidation,'NFolds')
        NFolds = Param.CrossValidation.NFolds;
      end;
      if isfield(Param.CrossValidation,'NFoldsDouble')
        NFoldsDouble = Param.CrossValidation.NFoldsDouble;
      end;
    end;

    if NFoldsDouble == 0
      %%% Simple Cross-Validation
      Labels = Data.LabelsDevelopment;
      NExamples = size(Data.InputsDevelopment,1);
      SamplingAux = MLE_CrossValidation (Common,Labels,NExamples,NFolds);
    else
      %%% Double Cross-Validation
      NSmpl = 0;
      Labels = Data.LabelsDevelopment;
      NExamples = size(Data.InputsDevelopment,1);
      SamplingOuter = MLE_CrossValidation (Common,Labels,NExamples,NFolds);
      for n=1:SamplingOuter.NSamplings
        Labels = Data.LabelsDevelopment(SamplingOuter.Train{n});
        NExamples = size(SamplingOuter.Train{n},2);
        SamplingInner = MLE_CrossValidation (Common,Labels,NExamples,NFoldsDouble);
        for m=1:SamplingInner.NSamplings
          NSmpl = NSmpl + 1;
          IndexTrainOuter = SamplingOuter.Train{n};
          SamplingAux.Train{NSmpl} = IndexTrainOuter(SamplingInner.Train{m});
          SamplingAux.Valid{NSmpl} = IndexTrainOuter(SamplingInner.Test{m});
          SamplingAux.Test{NSmpl} = SamplingOuter.Test{n};
        end;
      end;
      SamplingAux.NSamplings = NSmpl;
    end;

  end;

  %%%---------------
  %%% Bootstrapping
  %%%---------------

  if strcmp(Param.Type,'Bootstrapping')
    %%% Default optional parameters
    NBSamplings = 100;
    if isfield(Param,'Bootstrapping') && isfield(Param.Bootstrapping,'NBSamplings')
      NBSamplings = Param.Bootstrapping.NBSamplings;
    end;
    Labels = Data.LabelsDevelopment;
    NExamples = size(Data.InputsDevelopment,1);
    SamplingAux = MLE_Bootstrapping...
                    (Common,Labels,NExamples,NBSamplings);
  end;

  %%%------------------------------
  %%% Copy SamplingAux to Sampling
  %%%------------------------------

  for n=1:SamplingAux.NSamplings
    Sampling.NSamplings = Sampling.NSamplings + 1;
    Sampling.Train{Sampling.NSamplings} = SamplingAux.Train{n};
    if isfield(SamplingAux,'Valid')
      Sampling.Valid{Sampling.NSamplings} = SamplingAux.Valid{n};
    end;
    if isfield(SamplingAux,'Test')
      Sampling.Test{Sampling.NSamplings}  = SamplingAux.Test{n};
    end;
  end;

end; %%% end of "for time=1:Param.NTimes"

%%%----------------------------
%%% Sort indexes in Sampling.*
%%%----------------------------

for n=1:Sampling.NSamplings
  Sampling.Train{n} = sort(Sampling.Train{n});
  if isfield(Sampling,'Valid')
    Sampling.Valid{n} = sort(Sampling.Valid{n});
  end;
  if isfield(Sampling,'Test')
    Sampling.Test{n}  = sort(Sampling.Test{n});
  end;
end;

%%%------

fprintf(' done\n');

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParameters (Param);

if ~isfield(Param,'Type')
  error('MLE_SamplingDevelopmentData: Sampling type not defined');
end;

fprintf('Sampling development data (%s)...',Param.Type);

return;

%%%-------------------------------------------------
