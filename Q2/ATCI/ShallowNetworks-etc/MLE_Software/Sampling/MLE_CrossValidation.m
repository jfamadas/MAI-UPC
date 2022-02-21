
function Sampling = MLE_CrossValidation (Param,Labels,NExamples,NFolds)

%%%=======================================================================

%%%--------------------------------------------
%%% Validation of the values of the parameters
%%%--------------------------------------------

MLE_ValidateMandatoryParametersValue (NFolds);

%%%=======================================================================

%%%------------------
%%% Cross-Validation
%%%------------------

NSmpl = 0;

if Param.Stratified

  %%% Stratified Cross-Validation
  ULabels=sort(unique(Labels));
  K = size(ULabels,1);

  n = 0;
  valid = cell(NFolds,1);
  for cl=1:K
    Classids = find(Labels == ULabels(cl));
    NClassids = size(Classids,1);
    Index = 1:NClassids;
    if Param.Randomize
      Index = randperm(NClassids);
    end;
    for ncl = 1:NClassids
      n = n + 1; if (n > NFolds) n = 1; end;
      valid{n} = [valid{n} Classids(Index(ncl))];
    end;
  end;

  n = 0;
  for n=1:NFolds
    n = n + 1; if (n > NFolds) n = 1; end;
    NSmpl = NSmpl + 1;
    Sampling.Test{NSmpl}  = sort(valid{n});
    Sampling.Train{NSmpl} = setdiff(1:NExamples,Sampling.Test{NSmpl});
  end;

else

  %%% Non stratified Cross-Validation
  SizeFold = floor(NExamples / NFolds);

  Index = 1:NExamples;
  if Param.Randomize
    Index = randperm(NExamples);
  end;

  for n=1:NFolds
    NSmpl = NSmpl + 1;
    Sampling.Test{NSmpl}  = sort(Index( (n-1) * SizeFold + 1 : n * SizeFold ));
    Sampling.Train{NSmpl} = setdiff(1:NExamples,Sampling.Test{NSmpl});
  end;

end;

Sampling.NSamplings = NSmpl;

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParametersValue (NFolds);

%%%-----------------------------------
%%% Validation of the number of folds
%%%-----------------------------------

if NFolds <= 0
  error('MLE_CrossValidation: NFolds <= 0'); %'
end;

return;

%%%-------------------------------------------------
